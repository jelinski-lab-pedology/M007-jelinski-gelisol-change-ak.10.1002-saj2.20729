#----------Read in Yi et al dataset, Generate 1000m Presence/Absence Raster for PF w/in 1m, 1-2m, and 2m----------
# Opened the raw nc4 file in QGIS and then exported as a geotiff - now the projection is correct. 
yi_corr = terra::rast("./01-data/Sat_ActiveLayer_Thickness_Maps_1760/data/Yi_AL_mean_0015.tif")
plot(yi_corr)
plot(lrr_albers_AK, add=T)

yi_1m_bin = terra::rast("./01-data/Sat_ActiveLayer_Thickness_Maps_1760/data/Yi_AL_mean_0015.tif") %>%
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=0,upper=1.0, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

yi_1to2m_bin = terra::rast("./01-data/Sat_ActiveLayer_Thickness_Maps_1760/data/Yi_AL_mean_0015.tif") %>%
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1.0,upper=2.0, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

yi_2m_bin = terra::rast("./01-data/Sat_ActiveLayer_Thickness_Maps_1760/data/Yi_AL_mean_0015.tif") %>%
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=0,upper=2.0, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

# SANITY CHECKS 
              # just visualize to check
              par(mfrow=c(2,2))
              plot(yi_1m_bin, ext=past00_1000, col="steelblue3")
              plot(lrr_albers_AK, add=T)
              plot(yi_1to2m_bin, ext=past00_1000, col="steelblue3")
              plot(lrr_albers_AK, add=T)
              plot(yi_2m_bin, ext=past00_1000, col="steelblue3")
              plot(lrr_albers_AK, add=T)

#---------- Read in Aalto ALT, Generate 1000m Raster ----------
# read in WGS84 bounding box for AK - which we had to manually generate. This Aalto dataset is in WGS84 which presents problems in cropping because it is infinite at the top and Alaska crosses the longitude line. This approach fixes it. 
akbb_WGS84 = terra::vect("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/AKBoundingBox_WGS84.shp")

aalto_1m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_Baseline.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=100, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

aalto_1to2m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_Baseline.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=100,upper=200, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

aalto_2m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_Baseline.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=200, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

          # SANITY CHECKS
          # just visualize to check
          par(mfrow=c(2,2))
          plot(aalto_1m_bin, ext=past00_1000, col="steelblue3")
          plot(lrr_albers_AK, add=T)
          plot(aalto_1to2m_bin, ext=past00_1000, col="steelblue3")
          plot(lrr_albers_AK, add=T)
          plot(aalto_2m_bin, ext=past00_1000, col="steelblue3")
          plot(lrr_albers_AK, add=T)

#----------Read in DOS-TEM, Generate 1000m Raster----------
dostem = terra::rast("./01-data/DOS-TEM/TEM_PA_Gapfilled.img")
plot(dostem)

dostem_base_bin = terra::rast("./01-data/DOS-TEM/TEM_PA_Gapfilled.img") %>%
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=1, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

plot(dostem_base_bin, ext=past00_1000, col="steelblue3")
plot(lrr_albers_AK, add=T)

#----------Read in GIPL 2000, Generate 1000m Raster----------
GIPL00_1m_bin = terra::rast("./01-data/GIPL_ALT/ALT_2000_2009.tif") %>%
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=0,upper=1.0, values=FALSE) %>%
  .Mult100() %>%
  round() %>%
  terra::subst(from=c(0:100), to=1) %>%
  terra::mask(rast_soil)

GIPL00_1to2m_bin = terra::rast("./01-data/GIPL_ALT/ALT_2000_2009.tif") %>%
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1.0,upper=2.0, values=FALSE) %>%
  .Mult100() %>%
  round() %>%
  terra::subst(from=c(100:200), to=1) %>%
  terra::mask(rast_soil)

GIPL00_2m_bin = terra::rast("./01-data/GIPL_ALT/ALT_2000_2009.tif") %>%
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=0,upper=2.0, values=FALSE) %>%
  .Mult100() %>%
  round() %>%
  terra::subst(from=c(0:200), to=1) %>%
  terra::mask(rast_soil)

# just visualize to check
par(mfrow=c(2,2))
plot(GIPL00_1m_bin,ext=past00_1000, col="steelblue3")
plot(lrr_albers_AK, add=T)
plot(GIPL00_1to2m_bin,ext=past00_1000, col="steelblue3")
plot(lrr_albers_AK, add=T)
plot(GIPL00_2m_bin,ext=past00_1000, col="steelblue3")
plot(lrr_albers_AK, add=T)

#---------- Read Pastick Early Century Raster Binary ----------
# Pastick, 2000, because it is a probability raster and is different from the others, and because the initial reviewers asked why we used the 50% threshold, there is a reason to justify the choice of probability. We use a 50% threshold as justified by the analysis in Pastick et al. (2015) and also included in the response to reviewers. 
past00_1m_bin = past00_1000 %>%
  terra::clamp(lower=50,upper=100, values=FALSE) %>%
  round() %>%
  terra::subst(from=c(50:100), to=1) %>%
  terra::mask(rast_soil)

plot(past00_1m_bin,ext=past00_1000, col="steelblue3")
plot(lrr_albers_AK, add=T)

#----------Stack Baseline Early-Century Rasters----------
# Combine timepoints into one scenario stack for Baseline Binaries
baseline_binaries = c(yi_1m_bin, yi_1to2m_bin, yi_2m_bin, aalto_1m_bin, aalto_1to2m_bin, aalto_2m_bin, dostem_base_bin, GIPL00_1m_bin, GIPL00_1to2m_bin, GIPL00_2m_bin, past00_1m_bin)
names(baseline_binaries) = c("yi_1m_bin", "yi_1to2m_bin", "yi_2m_bin", "aalto_1m_bin", "aalto_1to2m_bin", "aalto_2m_bin", "dostem_base_bin", "GIPL00_1m_bin", "GIPL00_1to2m_bin", "GIPL00_2m_bin", "past00_1m_bin")
baseline_binaries

#----------Other baselines STATSGO, gNATSGO----------
#Since STATSGO (and gNATSGO) are the main sources of data, it doesn't make any sense to use them as binary. However, we do generate distribution maps and compare them to the baseline maps as a section in the paper. 

#----------Write to Cache----------
writeRaster(baseline_binaries, "./06-cache/baseline_binaries.tif", overwrite = T)
