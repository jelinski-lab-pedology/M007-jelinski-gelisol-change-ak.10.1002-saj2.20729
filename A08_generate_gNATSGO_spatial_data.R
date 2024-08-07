#----------Generate gNATSGO Gelisol Prevalence raster----------------
gelisol_reclass_tab_gnatsgo <- mu_gnatsgo %>% 
  left_join(
    comp_gnatsgo_small_nomisc %>%
      mutate(co_pct_gel = comppct_r * if_else(taxorder == "Gelisols", 1, 0)) %>%
      group_by(mukey) %>%
      summarize(mukey_gelpct = sum(co_pct_gel) / sum(comppct_r)),
    by = "mukey"
  ) %>%
  select(mukey, mukey_gelpct) 

# there is an issue here - because you removed miscellaneous areas before and normalized gelisol percent to the non-miscellaneous area for each MUKEY (did this for STATSGO because extensive miscellaneous areas screwing up Gelisol prevalence, esp, for example on north slope where there is a bunch of water, but since masking out miscellaneous areas with a staeelite based product (Pastick), these needed to be removed before calculating prevalence. However, this is an issue because some MUs are all miscellaneous areas in the SSURGO areas - and hence in gNATSGO for the same areas, this is not the case in STATSGO (these are predominantly Water in SE Alaska, in Yukon-Charley, Western Interior Rivers, and the Aleutians in offshore buffers around the islands - so, if you try to reclass with the existing frame at this point those areas will retain their MUKEYS and while every other cell will be between 0 and 1 (gelisol prevalence), those will have values of the mukeys (since there is no match in the reclass table) which are values > 30000000). So, what need to do is actually do a "left join" of the gelisol prevalence back to ALL of the unique mukeys, which you can retrieve from the original gNASTGO comp table. This will retain all of the records in the first listed ("left") table, and put NA in the joining column if there is no match. Then, you can set all NAs to zero after the join and you will have a complete reclass table.

# get all unique mukeys from gNATSGO
gnatsgo_mukey_unique = as.data.frame(unique(comp_gnatsgo_small$mukey))
# rename column to "mukey" (since unique gives a wierd column name)
names(gnatsgo_mukey_unique)[1] = "mukey"

new_frame = dplyr::left_join(gnatsgo_mukey_unique, gelisol_reclass_tab_gnatsgo, by = "mukey")
new_frame[is.na(new_frame)] = 0
gelisol_reclass_tab_gnatsgo.mat=data.matrix(new_frame)

# Reclassify
# generate Gelisol proportion raster, crop to Pastick soil domain
gnat_rast_gelisol = gnatsgo_1000 %>%
  terra::classify(gelisol_reclass_tab_gnatsgo.mat) %>%
  terra::mask(rast_soil)
plot(gnat_rast_gelisol)

#----------PLOT gNATSGO Gelisol Proportion Raster----------------
range_gel = c(0,1)
gel.pal <- leaflet::colorNumeric(palette = "Blues", domain = range_gel,na.color = "white", reverse = FALSE)
plot(gnat_rast_gelisol, ext=ext(past00_1000), col=gel.pal(seq(range_gel[1], range_gel[2], length.out=20)))
##overprint zeros as NAs
gnat_rast_gelisol_clamp0 = terra::clamp(gnat_rast_gelisol, upper=0.01, values=FALSE)
plot(gnat_rast_gelisol_clamp0, col="white", na.color="transparent", legend = FALSE, add=TRUE,axes=FALSE)
plot(lrr_albers_AK, add=T)

#----------Generate gNATSGO Turbel Proportion Raster----------------
turbel_reclass_tab_gnatsgo <- mu_gnatsgo %>% 
  left_join(
    comp_gnatsgo_small_nomisc %>%
      mutate(co_pct_turb = comppct_r * if_else(taxsuborder == "Turbels", 1, 0)) %>%
      group_by(mukey) %>%
      summarize(mukey_turbpct = sum(co_pct_turb) / sum(comppct_r)),
    by = "mukey"
  ) %>%
  select(mukey, mukey_turbpct) 

new_frame = dplyr::left_join(gnatsgo_mukey_unique, turbel_reclass_tab_gnatsgo, by = "mukey")
new_frame[is.na(new_frame)] = 0
turbel_reclass_tab_gnatsgo.mat=data.matrix(new_frame)

# Reclassify
# generate Turbel proportion raster, crop to Pastick soil domain
gnat_rast_turbel = gnatsgo_1000 %>%
  terra::classify(turbel_reclass_tab_gnatsgo.mat) %>%
  terra::mask(rast_soil)
plot(gnat_rast_turbel)

#----------PLOT gNATSGO Turbel Proportion Raster----------------
range_turb = c(0,1)
turb.pal <- leaflet::colorNumeric(palette = "Purples", domain = range_turb,na.color = "white", reverse = FALSE)
plot(gnat_rast_turbel, ext=ext(past00_1000), col=turb.pal(seq(range_turb[1], range_turb[2], length.out=20)))
# overprint zeros as NAs
gnat_rast_turbel_clamp0 = terra::clamp(gnat_rast_turbel, upper=0.009, values=FALSE)
plot(gnat_rast_turbel_clamp0, col="white", na.color="transparent", legend = FALSE, add=TRUE,axes=FALSE)
plot(lrr_albers_AK, add=T)

#----------Generate gNATSGO Histel Proportion Raster----------------
histel_reclass_tab_gnatsgo <- mu_gnatsgo %>% 
  left_join(
    comp_gnatsgo_small_nomisc %>%
      mutate(co_pct_hist = comppct_r * if_else(taxsuborder == "Histels", 1, 0)) %>%
      group_by(mukey) %>%
      summarize(mukey_histpct = sum(co_pct_hist) / sum(comppct_r)),
    by = "mukey"
  ) %>%
  select(mukey, mukey_histpct) 

new_frame = dplyr::left_join(gnatsgo_mukey_unique, histel_reclass_tab_gnatsgo, by = "mukey")
new_frame[is.na(new_frame)] = 0
histel_reclass_tab_gnatsgo.mat=data.matrix(new_frame)

# Reclassify
# generate Histel proportion raster, crop to Pastick soil domain
gnat_rast_histel = gnatsgo_1000 %>%
  terra::classify(histel_reclass_tab_gnatsgo.mat) %>%
  terra::mask(rast_soil)
plot(gnat_rast_histel)

#----------PLOT gNATSGO Histel Proportion Raster----------------
range_hist = c(0,0.5)
hist.pal <- leaflet::colorNumeric(palette = "Greens", domain = range_hist,na.color = "white", reverse = FALSE)
plot(gnat_rast_histel, ext=ext(past00_1000), col=hist.pal(seq(range_hist[1], range_hist[2], length.out=10)))
# overprint zeros as NAs
gnat_rast_histel_clamp0 = terra::clamp(gnat_rast_histel, upper=0.009, values=FALSE)
plot(gnat_rast_histel_clamp0, col="white", na.color="transparent", legend = FALSE, add=TRUE,axes=FALSE)
plot(lrr_albers_AK, add=T)


#----------Generate gNATSGO Orthel Proportion Raster----------------
orthel_reclass_tab_gnatsgo <- mu_gnatsgo %>% 
  left_join(
    comp_gnatsgo_small_nomisc %>%
      mutate(co_pct_orth = comppct_r * if_else(taxsuborder == "Orthels", 1, 0)) %>%
      group_by(mukey) %>%
      summarize(mukey_orthpct = sum(co_pct_orth) / sum(comppct_r)),
    by = "mukey"
  ) %>%
  select(mukey, mukey_orthpct) 

new_frame = dplyr::left_join(gnatsgo_mukey_unique, orthel_reclass_tab_gnatsgo, by = "mukey")
new_frame[is.na(new_frame)] = 0
orthel_reclass_tab_gnatsgo.mat=data.matrix(new_frame)

# Reclassify
# generate Orthel proportion raster, crop to Pastick soil domain
gnat_rast_orthel = gnatsgo_1000 %>%
  terra::classify(orthel_reclass_tab_gnatsgo.mat) %>%
  terra::mask(rast_soil)
plot(gnat_rast_orthel)

#----------Plot gNATSGO Orthel Proportion Raster----------------
range_orth = c(0, 0.85)
orth.pal <- leaflet::colorNumeric(palette = "Oranges", domain = range_orth,na.color = "white", reverse = FALSE)
plot(gnat_rast_orthel, ext=ext(past00_1000), col=orth.pal(seq(range_orth[1], range_orth[2], length.out=20)))
# overprint zeros as NAs
gnat_rast_orthel_clamp0 = terra::clamp(gnat_rast_orthel, upper=0.009, values=FALSE)
plot(gnat_rast_orthel_clamp0, col="white", na.color="transparent", legend = FALSE, add=TRUE,axes=FALSE)
plot(lrr_albers_AK, add=T)

#----------Stack gNATSGO Rasters----------------
# Combine timepoints into one scenario stack for STATSGO Orders/Suborders
gNATSGO_order_suborder = c(gnat_rast_gelisol, gnat_rast_turbel, gnat_rast_histel, gnat_rast_orthel)
names(gNATSGO_order_suborder) = c("Gelisol Prop","Turbel Prop","Histel Prop","Orthel Prop")
gNATSGO_order_suborder

# plot taxa by calling layers
par(mfrow=c(2,2))
plot(gNATSGO_order_suborder$`Gelisol Prop`)
plot(gNATSGO_order_suborder$`Turbel Prop`)
plot(gNATSGO_order_suborder$`Histel Prop`)
plot(gNATSGO_order_suborder$`Orthel Prop`)

#----------Write to Cache----------------
writeRaster(gnat_rast_gelisol, "./06-cache/gnat_rast_gelisol.tif", overwrite = T)
writeRaster(gnat_rast_turbel, "./06-cache/gnat_rast_turbel.tif", overwrite = T)
writeRaster(gnat_rast_histel, "./06-cache/gnat_rast_histel.tif", overwrite = T)
writeRaster(gnat_rast_orthel, "./06-cache/gnat_rast_orthel.tif", overwrite = T)
