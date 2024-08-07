#----------Load Aalto RCP 2.6 Scenario Rasters, Make Binary and Stack----------------
# 2050
aalto50_RCP26_1m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_2050RCP26.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=100, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

aalto50_RCP26_2m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_2050RCP26.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=200, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

# 2070
aalto70_RCP26_1m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_2070RCP26.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=100, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

aalto70_RCP26_2m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_2070RCP26.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=200, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

#----------Load Aalto RCP 4.5 Scenario Rasters, Make Binary and Stack----------------
# 2050
aalto50_RCP45_1m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_2050RCP45.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=100, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

aalto50_RCP45_2m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_2050RCP45.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=200, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

# 2070
aalto70_RCP45_1m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_2070RCP45.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=100, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

aalto70_RCP45_2m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_2070RCP45.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=200, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

#----------Load Aalto RCP 8.5 Scenario Rasters, Make Binary and Stack----------------
# 2050
aalto50_RCP85_1m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_2050RCP85.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=100, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

aalto50_RCP85_2m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_2050RCP85.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=200, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

# 2070
aalto70_RCP85_1m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_2070RCP85.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=100, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

aalto70_RCP85_2m_bin = terra::rast("./01-data/doi_10.5061_dryad.886pr72__v1/ALT_Rasters/ALT_2070RCP85.tif") %>%
  terra::crop(akbb_WGS84) %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=1,upper=200, values=FALSE) %>%
  terra::mask(rast_soil) %>%
  .GreaterEqualZero()

#----------Combine timepoints into one scenario stack ----------------
aalto_scen = c(aalto50_RCP26_1m_bin, aalto50_RCP26_2m_bin, aalto70_RCP26_1m_bin, aalto70_RCP26_2m_bin, aalto50_RCP45_1m_bin, aalto50_RCP45_2m_bin, aalto70_RCP45_1m_bin, aalto70_RCP45_2m_bin, aalto50_RCP85_1m_bin, aalto50_RCP85_2m_bin, aalto70_RCP85_1m_bin, aalto70_RCP85_2m_bin)
names(aalto_scen) = c("aalto50_RCP26_1m_bin", "aalto50_RCP26_2m_bin", "aalto70_RCP26_1m_bin", "aalto70_RCP26_2m_bin", "aalto50_RCP45_1m_bin", "aalto50_RCP45_2m_bin", "aalto70_RCP45_1m_bin", "aalto70_RCP45_2m_bin", "aalto50_RCP85_1m_bin", "aalto50_RCP85_2m_bin", "aalto70_RCP85_1m_bin", "aalto70_RCP85_2m_bin")
aalto_scen

# Example: plot timepoints by calling layers
par(mfrow=c(2,2))
plot(aalto_scen$aalto50_RCP26_1m_bin, ext = past00_1000, col = "steelblue3")
plot(aalto_scen$aalto70_RCP26_1m_bin, ext = past00_1000, col = "steelblue3")
plot(aalto_scen$aalto70_RCP45_1m_bin, ext = past00_1000, col = "steelblue3")
plot(aalto_scen$aalto70_RCP85_1m_bin, ext = past00_1000, col = "steelblue3")

#----------Write to Cache----------------
writeRaster(aalto50_RCP26_1m_bin, "./06-cache/aalto50_RCP26_1m_bin.tif")
writeRaster(aalto50_RCP26_2m_bin, "./06-cache/aalto50_RCP26_2m_bin.tif")
writeRaster(aalto70_RCP26_1m_bin, "./06-cache/aalto70_RCP26_1m_bin.tif")
writeRaster(aalto70_RCP26_2m_bin, "./06-cache/aalto70_RCP26_2m_bin.tif")
writeRaster(aalto50_RCP45_1m_bin, "./06-cache/aalto50_RCP45_1m_bin.tif")
writeRaster(aalto50_RCP45_2m_bin, "./06-cache/aalto50_RCP45_2m_bin.tif")
writeRaster(aalto70_RCP45_1m_bin, "./06-cache/aalto70_RCP45_1m_bin.tif")
writeRaster(aalto70_RCP45_2m_bin, "./06-cache/aalto70_RCP45_2m_bin.tif")
writeRaster(aalto50_RCP85_1m_bin, "./06-cache/aalto50_RCP85_1m_bin.tif")
writeRaster(aalto50_RCP85_2m_bin, "./06-cache/aalto50_RCP85_2m_bin.tif")
writeRaster(aalto70_RCP85_1m_bin, "./06-cache/aalto70_RCP85_1m_bin.tif")
writeRaster(aalto70_RCP85_2m_bin, "./06-cache/aalto70_RCP85_2m_bin.tif")

