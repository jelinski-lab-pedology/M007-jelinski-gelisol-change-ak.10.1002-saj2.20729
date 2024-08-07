#----------Generate STATSGO Gelisol Proportion Raster----------
gelisol_reclass_tab <- mu_statsgo %>% 
  left_join(
    comp_statsgo_small_nomisc %>%
      mutate(co_pct_gel = comppct_r * if_else(taxorder == "Gelisols", 1, 0)) %>%
      group_by(mukey) %>%
      summarize(mukey_gelpct = sum(co_pct_gel) / sum(comppct_r)),
    by = "mukey"
  ) %>%
  select(mukey, mukey_gelpct)

# generate Gelisol proportion raster, crop to Pastick soil domain
stat_rast_gelisol = stat_rast %>%
  terra::classify(gelisol_reclass_tab) %>%
  terra::mask(rast_soil)

#----------PLOT STATSGO Gelisol Proportion Raster----------
range_gel = c(0,1)
gel.pal <- leaflet::colorNumeric(palette = "Blues", domain = range_gel,na.color = "white", reverse = FALSE)
plot(stat_rast_gelisol, ext=ext(past00_1000), col=gel.pal(seq(range_gel[1], range_gel[2], length.out=20)))
# overprint zeros as NAs
stat_rast_gelisol_clamp0 = terra::clamp(stat_rast_gelisol, upper=0.01, values=FALSE)
plot(stat_rast_gelisol_clamp0, col="white", na.color="transparent", legend = FALSE, add=TRUE,axes=FALSE)
plot(lrr_albers_AK, add=T)

#----------Generate STATSGO Turbel Proportion Raster----------
turbel_reclass_tab <- mu_statsgo %>% 
  left_join(
    comp_statsgo_small_nomisc %>%
      mutate(co_pct_turb = comppct_r * if_else(taxsuborder == "Turbels", 1, 0)) %>%
      group_by(mukey) %>%
      summarize(mukey_turbpct = sum(co_pct_turb) / sum(comppct_r)),
    by = "mukey"
  ) %>%
  select(mukey, mukey_turbpct)

# generate Turbel proportion raster, crop to Pastick soil domain
stat_rast_turbel = stat_rast %>%
  terra::classify(turbel_reclass_tab) %>%
  terra::mask(rast_soil)

#----------PLOT STATSGO Turbel Proportion Raster----------
range_turb = c(0,1)
turb.pal <- leaflet::colorNumeric(palette = "Purples", domain = range_turb,na.color = "white", reverse = FALSE)
plot(stat_rast_turbel, ext=ext(past00_1000), col=turb.pal(seq(range_turb[1], range_turb[2], length.out=20)))
# overprint zeros as NAs
stat_rast_turbel_clamp0 = terra::clamp(stat_rast_turbel, upper=0.009, values=FALSE)
plot(stat_rast_turbel_clamp0, col="white", na.color="transparent", legend = FALSE, add=TRUE,axes=FALSE)
plot(lrr_albers_AK, add=T)

#----------Generate STATSGO Histel Proportion Raster----------
# generate Histel proportion reclass table by mukey
histel_reclass_tab <- mu_statsgo %>% 
  left_join(
    comp_statsgo_small_nomisc %>%
      mutate(co_pct_hist = comppct_r * if_else(taxsuborder == "Histels", 1, 0)) %>%
      group_by(mukey) %>%
      summarize(mukey_histpct = sum(co_pct_hist) / sum(comppct_r)),
    by = "mukey"
  ) %>%
  select(mukey, mukey_histpct)

# generate Histel proportion raster, crop to Pastick soil domain
stat_rast_histel = stat_rast %>%
  terra::classify(histel_reclass_tab) %>%
  terra::mask(rast_soil)

#----------PLOT STATSGO Histel Proportion Raster----------
range_hist = c(0,0.5)
hist.pal <- leaflet::colorNumeric(palette = "Greens", domain = range_hist,na.color = "white", reverse = FALSE)
plot(stat_rast_histel, ext=ext(past00_1000), col=hist.pal(seq(range_hist[1], range_hist[2], length.out=20)))
# overprint zeros as NAs
stat_rast_histel_clamp0 = terra::clamp(stat_rast_histel, upper=0.009, values=FALSE)
plot(stat_rast_histel_clamp0, col="white", na.color="transparent", legend = FALSE, add=TRUE,axes=FALSE)
plot(lrr_albers_AK, add=T)


#----------Generate STATSGO Orthel Proportion Raster----------
orthel_reclass_tab <- mu_statsgo %>% 
  left_join(
    comp_statsgo_small_nomisc %>%
      mutate(co_pct_orth = comppct_r * if_else(taxsuborder == "Orthels", 1, 0)) %>%
      group_by(mukey) %>%
      summarize(mukey_orthpct = sum(co_pct_orth) / sum(comppct_r)),
    by = "mukey"
  ) %>%
  select(mukey, mukey_orthpct)

# generate Orthel proportion raster, crop to Pastick soil domain
stat_rast_orthel = stat_rast %>%
  terra::classify(orthel_reclass_tab) %>%
  terra::mask(rast_soil)

#----------Plot STATSGO Orthel Proportion Raster----------
range_orth = c(0, 0.85)
orth.pal <- leaflet::colorNumeric(palette = "Oranges", domain = range_orth,na.color = "white", reverse = FALSE)
plot(stat_rast_orthel, ext=ext(past00_1000), col=orth.pal(seq(range_orth[1], range_orth[2], length.out=20)))
# overprint zeros as NAs
stat_rast_orthel_clamp0 = terra::clamp(stat_rast_orthel, upper=0.009, values=FALSE)
plot(stat_rast_orthel_clamp0, col="white", na.color="transparent", legend = FALSE, add=TRUE,axes=FALSE)
plot(lrr_albers_AK, add=T)

#----------Stack STATSGO Rasters----------
# Combine into one scenario stack for STATSGO Orders/Suborders
STATSGO_order_suborder = c(stat_rast_gelisol, stat_rast_turbel, stat_rast_histel, stat_rast_orthel)
names(STATSGO_order_suborder) = c("Gelisol Prop","Turbel Prop","Histel Prop","Orthel Prop")
STATSGO_order_suborder

# plot taxa by calling layers
par(mfrow=c(2,2))
plot(STATSGO_order_suborder$`Gelisol Prop`)
plot(STATSGO_order_suborder$`Turbel Prop`)
plot(STATSGO_order_suborder$`Histel Prop`)
plot(STATSGO_order_suborder$`Orthel Prop`)

#----------Write to Cache----------
writeRaster(stat_rast_gelisol, "./06-cache/stat_rast_gelisol.tif", overwrite = T)
writeRaster(stat_rast_turbel, "./06-cache/stat_rast_turbel.tif", overwrite = T)
writeRaster(stat_rast_histel, "./06-cache/stat_rast_histel.tif", overwrite = T)
writeRaster(stat_rast_orthel, "./06-cache/stat_rast_orthel.tif", overwrite = T)
