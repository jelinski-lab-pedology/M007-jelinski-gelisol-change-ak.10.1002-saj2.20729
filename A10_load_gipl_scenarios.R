#----------Load GIPL A1B Scenario Rasters, Make Binary and Stack----------------
# 2050-2059
GIPL50_A1B_1m_bin = terra::rast("./01-data/GIPL_ALT/ALT_2050_2059.tif") %>%
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=0,upper=1.0, values=FALSE) %>%
  .Mult100() %>%
  round() %>%
  terra::subst(from=c(0:100), to=1) %>%
  terra::mask(rast_soil)

GIPL50_A1B_2m_bin = terra::rast("./01-data/GIPL_ALT/ALT_2050_2059.tif") %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=0,upper=2.0, values=FALSE) %>%
  .Mult100() %>%
  round() %>%
  terra::subst(from=c(0:200), to=1) %>%
  terra::mask(rast_soil)

# 2090-2099
GIPL90_A1B_1m_bin = terra::rast("./01-data/GIPL_ALT/ALT_2090_2099.tif") %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=0,upper=1.0, values=FALSE) %>%
  .Mult100() %>%
  round() %>%
  terra::subst(from=c(0:100), to=1) %>%
  terra::mask(rast_soil)

GIPL90_A1B_2m_bin = terra::rast("./01-data/GIPL_ALT/ALT_2090_2099.tif") %>%
  terra::project("epsg:6393") %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=0,upper=2.0, values=FALSE) %>%
  .Mult100() %>%
  round() %>%
  terra::subst(from=c(0:200), to=1) %>%
  terra::mask(rast_soil)

#----------Combine into one scenario stack for A1B 1m----------------
GIPL_scen = c(GIPL50_A1B_1m_bin, GIPL90_A1B_1m_bin, GIPL50_A1B_2m_bin, GIPL90_A1B_2m_bin)
names(GIPL_scen) = c("GIPL50_A1B_1m_bin", "GIPL90_A1B_1m_bin", "GIPL50_A1B_2m_bin", "GIPL90_A1B_2m_bin")
GIPL_scen

# example plot scenarios by calling layers
par(mfrow=c(2,2))
plot(GIPL_scen$GIPL50_A1B_1m_bin, ext = past00_1000, col = "steelblue3")
plot(GIPL_scen$GIPL90_A1B_1m_bin, ext = past00_1000, col = "steelblue3")
plot(GIPL_scen$GIPL50_A1B_2m_bin, ext = past00_1000, col = "steelblue3")
plot(GIPL_scen$GIPL90_A1B_2m_bin, ext = past00_1000, col = "steelblue3")