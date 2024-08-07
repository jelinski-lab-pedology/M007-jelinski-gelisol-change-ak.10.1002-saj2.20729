#---------- Generate Domain Using Pastick Raster as Template, Generate Masks ------------

# We use the Pastick raster as the best possible product for defining the analysis domain (since it is the smallest extent of gNATSGO, STATSGO, and all of the input datasets) and because it allows us to better define soil/non-soil. For our purposes, the "soil" domain is everything except water, ice, rock, and urban. We do include ag in the soil domain. The Pastick dataset has values of 0-100 (for probability of permafrost within 1m of the soil surface and then additional values for other land cover types (101 = water, 102 = ice, 103 = rock, 104 = urban, 105 = ag) - see Pastick et al. (2015) for details.

#----------Reclassify Pastick baseline raster to correct for ice values in MLRAs 245/246 and set agriculture values to zero------------
# NOTE: there is some water (value 101) in this raster in the northern portion of Alaska that is classified as ice (probably because lake was frozen at time of satellite image?) this was exclusively in MLRA 245 and 246 (Alaska Arctic Foothills (245) and Coastal Plain (246)). Need to reclassify -. here is how I solved this:
# Now, you need to have MLRA read in and rasterized first. Then subset the two northern MLRAs (245, 246) (gives you a binary 0,1 raster) and multiply by the original raster.
mlra_north = mlra_rast >= 245
plot(mlra_north)
# The below two lines are just a sanity check to ensure that what was cut out are 245 and 246. multiplying the binary mlra_north (which should be coded as 0, 1) with the original rasterized mlra data to ensure that what is returned is 245 and 246. It is.
mlra_times = mlra_north * mlra_rast
plot(mlra_times)
# Now here, multiplying the binary 1,0 raster for mlras 245 and 246 by the pastick raster to recover the original values for that area. plot for sanity check - looks good.
mlra_north_past = mlra_north * past00_1000
plot(mlra_north_past)

# Now, for this mlra 245/246 raster need to reclassify the ice to water here (step1) and then mosaic with the original raster (step2)
# Using terra::reclassify - https://rdrr.io/cran/terra/man/classify.html
# first build reclassification matrix according to these rules:
# matrix for classification. This matrix must have 1, 2 or 3 columns. If there are three columns, the first two columns are "from" "to" of the input values, and the third column "becomes" has the new value for that range.The two column matrix ("is", "becomes") can be useful for classifying integer values. In that case, the arguments right and include.lowest are ignored. A single column matrix (or a vector) is interpreted as a set of cuts if there is more than one value. In that case the values are classified based on their location in-between the cut-values.
# This is a two-column matrix, so then of type "is" [column 1] ---> "becomes" [column 2]. Note, I am making all of the zeroes 200 so that when I mosaic with this original raster eventually below I can take the min of each raster and it will remain correct in both the area where ice (102) has been reclassed to water (101) in the north and also where the subset created zeroes in the rest of the state (0) will now be (200), so can take the min value there when mosaicing and get the original raster back. Note the way the numbers are set up, can't do both with only the following choices in mosaic: mean (default), min, max, sum, median
m_water <- c(0,seq(1:100),101, 102, 103, 104, 105,
             200,seq(1:100), 101, 101, 103, 104, 105)
water_reclass <- matrix(m_water, ncol=2, byrow=FALSE)
water_reclass
# everything looks correct, so now give reclass a try - this works great!!!
past_north_reclass = classify(mlra_north_past, water_reclass)
# so now mosaic with the raw dataset that has been resampled to 1000m - this worked correctly!
past_rcl_mosaic = mosaic(past00_1000, past_north_reclass, fun = "min")
plot(past_rcl_mosaic)

# Finally note that ag will not be masked because it is soil. The other values are non-soil (water, rock, ice, urban). But can safely assume that ag does not have near-surface permafrost within 1m. So, will set probability to 0 in this case. So need to do a second reclass on the mosaiced statewide raster for ag, setting 105 to 0 (0 probability of permafrost)
m_ag <- c(0,seq(1:100),101, 102, 103, 104, 105,
          0,seq(1:100), 101, 102, 103, 104, 0)
ag_reclass <- matrix(m_ag, ncol=2, byrow=FALSE)
ag_reclass

past_final_reclass = classify(past_rcl_mosaic, ag_reclass)

#----------Create Domain Mask from Pastick (rast_domain) - everything in this raster that is a 1 is in the analysis domain------------

# OK so here just doing all area to check and see if this works. Since Past_final_reclass is the smallest domain in extent (including all misc areas, I make that a binary - note what terra actually does is make this "TRUE" FALSE" BUT it works out because terra (or R) treats TRUE/FALSE as 1, 0, so you can do numeric operations on it. 
rast_domain = past_final_reclass >= 0
# rename raster variable
names(rast_domain) = "Total_Domain_Cells"
# sanity check
rast_domain
# just visualize to check
plot(rast_domain,ext=past00_1000, col="grey80")
plot(lrr_albers_AK, add=T)

# write to cache
writeRaster(rast_domain, "./06-cache/rast_domain.tif", overwrite=TRUE)

#----------Create Soil Mask from Pastick (rast_soil) - everything in this raster that is a 1 is soil------------ 

# This has values greater than 100, (101 = water, 102 = ice, 103 = rock, 104 = urban, 105 = ag) so need to clamp to get rid of those values - don't worry will use that info to create some great masks later on
# need to have values argument set to FALSE in this case: "values logical. If FALSE values outside the clamping range become NA, if TRUE, they get the extreme values (which would be 100 in this case).
past00_clamp_soil <- terra::clamp(past_final_reclass, upper=100, values=FALSE)
# this took about 1 min (clamp)
rast_soil = past00_clamp_soil >=0
plot(rast_soil)
names(rast_soil) = "Soil_Cells"
# just visualize to check
plot(rast_soil,ext=past00_1000, col="grey80")
plot(lrr_albers_AK, add=T)

# write to cache
writeRaster(rast_soil, "./06-cache/rast_soil.tif", overwrite=TRUE)

#----------Create Non-Soil Layer from Pastick (rast non-soil) - everything in this raster that is a 1 is non-soil, including water------------

# This has values less than 100, here only want to keep the non-soil values (101 = water, 102 = ice, 103 = urban, 104 = rock) so need to clamp to get rid of those values 100 or less
# need to have values argument set to FALSE in this case: "values logical. If FALSE values outside the clamping range become NA, if TRUE, they get the extreme values (which would be 100 in this case).
past00_clamp_nonsoil <- terra::clamp(past_final_reclass, lower=101, values=FALSE)
plot(past00_clamp_nonsoil)
# this took about 1 min (clamp)
rast_nonsoil = past00_clamp_nonsoil >=0
plot(rast_nonsoil)
names(rast_nonsoil) = "Non-Soil_Cells"
# just visualize to check
plot(rast_nonsoil,ext=past00_1000, col="grey80")
plot(lrr_albers_AK, add=T)

# write to cache
writeRaster(rast_nonsoil, "./06-cache/rast_nonsoil.tif", overwrite=TRUE)

#----------Create Water Layer from Pastick (rast_water)------------

# Value of water is 101 so clamp on that
past00_clamp_water <- terra::clamp(past_final_reclass, lower = 101, upper=101, values=FALSE)
plot(past00_clamp_water)
rast_water = past00_clamp_water >=0
plot(rast_water)
names(rast_water) = "Water_Cells"
# just visualize to check
plot(rast_water,ext=past00_1000, col="grey80")
plot(lrr_albers_AK, add=T)

# write to cache
writeRaster(rast_water, "./06-cache/rast_water.tif", overwrite=TRUE)

#----------Create Rock Layer from Pastick (rast_rock)------------

# This raster contains both probability values and non-soil values (101 = water, 102 = ice, 103 = urban, 104 = rock) so need to clamp to get rid of those values not 104 (rock)
# need to have values argument set to FALSE in this case: "values logical. If FALSE values outside the clamping range become NA, if TRUE, they get the extreme values (which would be 104 in this case).
past00_clamp_rock <- terra::clamp(past_final_reclass, lower=104, upper=104, values=FALSE)
plot(past00_clamp_rock)
# this took about 1 min (clamp)
rast_rock = past00_clamp_rock >=0
plot(rast_rock)
names(rast_rock) = "Rock_Cells"
# just visualize to check
plot(rast_rock,ext=past00_1000, col="grey80")
plot(lrr_albers_AK, add=T)

# write to cache
writeRaster(rast_rock, "./06-cache/rast_rock.tif", overwrite=TRUE)

#----------Create Ice Layer from Pastick (rast_ice)------------

# This raster contains both probability values and non-soil values (101 = water, 102 = ice, 103 = urban, 104 = rock) so need to clamp to get rid of those values not 102 (ice)
# need to have values argument set to FALSE in this case: "values logical. If FALSE values outside the clamping range become NA, if TRUE, they get the extreme values (which would be 102 in this case).
past00_clamp_ice <- terra::clamp(past_final_reclass, lower=102, upper=102, values=FALSE)
plot(past00_clamp_ice)
# this took about 1 min (clamp)
rast_ice = past00_clamp_ice >=0
plot(rast_ice)
names(rast_ice) = "Ice_Cells"
# just visualize to check
plot(rast_ice,ext=past00_1000, col="grey80")
plot(lrr_albers_AK, add=T)

# write to cache
writeRaster(rast_ice, "./06-cache/rast_ice.tif", overwrite=TRUE)

#----------Create Urban Layer from Pastick (rast_urban)------------
# This raster contains both probability values and non-soil values (101 = water, 102 = ice, 103 = urban, 104 = rock) so need to clamp to get rid of those values not 102 (ice)
# need to have values argument set to FALSE in this case: "values logical. If FALSE values outside the clamping range become NA, if TRUE, they get the extreme values (which would be 103 in this case).
past00_clamp_urban <- terra::clamp(past_final_reclass, lower=103, upper=103, values=FALSE)
plot(past00_clamp_urban)
# this took about 1 min (clamp)
rast_urban = past00_clamp_urban >=0
# plot(rast_urban)
names(rast_urban) = "Urban_Cells"
# just visualize to check
plot(rast_urban,ext=past00_1000, col="grey80")
plot(lrr_albers_AK, add=T)

# write to cache
writeRaster(rast_urban, "./06-cache/rast_urban.tif", overwrite=TRUE)

#----------Create Non-Soil, Non-Water Layer from Pastick (rock, ice, urban). (rast_rockice_urban)------------
# This raster contains both probability values and non-soil values (101 = water, 102 = ice, 103 = urban, 104 = rock) so need to clamp to get rid of 101 values (water)
# need to have values argument set to FALSE in this case: "values logical. If FALSE values outside the clamping range become NA, if TRUE, they get the extreme values (which would be 100 in this case).
past00_clamp_rockiceurban <- terra::clamp(past_final_reclass, lower=102, upper=104, values=FALSE)
plot(past00_clamp_rockiceurban)
# this took about 1 min (clamp)
rast_rockiceurban = past00_clamp_rockiceurban >=0
plot(rast_rockiceurban)
names(rast_rockiceurban) = "Rock_Ice_and_Urban_Cells"
# just visualize to check
plot(rast_rockiceurban,ext=past00_1000, col="grey80")
plot(lrr_albers_AK, add=T)

# write to cache
writeRaster(rast_rockiceurban, "./06-cache/rast_rockiceurban.tif", overwrite=TRUE)
