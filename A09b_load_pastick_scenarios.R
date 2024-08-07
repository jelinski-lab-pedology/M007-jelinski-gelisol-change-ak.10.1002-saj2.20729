#----------Load Pastick B1 Scenario Rasters, Make Binary and Stack----------------
# Pastick is an NSP probability raster, with values from 0-100 (for 0% prob to 100%prob). plus values from 101-105 for the water, rock, ice urban and ag. This one takes about 7 minutes.
past50_B1_1m_bin = terra::rast("./01-data/Pastick_NSP/B1/AK_pa_1m_2050_b1.tif") %>% 
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=50,upper=100, values=FALSE) %>%
  round() %>%
  terra::subst(from=c(50:100), to=1) %>%
  terra::mask(rast_soil)

past90_B1_1m_bin = terra::rast("./01-data/Pastick_NSP/B1/AK_pa_1m_2090_b1.tif") %>% 
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=50,upper=100, values=FALSE) %>%
  round() %>%
  terra::subst(from=c(50:100), to=1) %>%
  terra::mask(rast_soil)

#----------Load Pastick A1B Scenario Raster, Make Binary and Stack----------------
# Pastick is an NSP probability raster, with values from 0-100 (for 0% prob to 100%prob). plus values from 101-105 for the water, rock, ice urban and ag. This one takes about 7 minutes.
past50_A1B_1m_bin = terra::rast("./01-data/Pastick_NSP/A1B/Pastick_NSPProb_2050to2059.tif") %>% 
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=50,upper=100, values=FALSE) %>%
  round() %>%
  terra::subst(from=c(50:100), to=1) %>%
  terra::mask(rast_soil)

past90_A1B_1m_bin = terra::rast("./01-data/Pastick_NSP/A1B/Pastick_NSPProb_2090to2099.tif") %>% 
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=50,upper=100, values=FALSE) %>%
  round() %>%
  terra::subst(from=c(50:100), to=1) %>%
  terra::mask(rast_soil)

#----------Load Pastick A2 Scenario Rasters, Make Binary and Stack----------------
past50_A2_1m_bin = terra::rast("./01-data/Pastick_NSP/A2/AK_pa_1m_2050_a2.tif") %>% 
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=50,upper=100, values=FALSE) %>%
  round() %>%
  terra::subst(from=c(50:100), to=1) %>%
  terra::mask(rast_soil)

past90_A2_1m_bin = terra::rast("./01-data/Pastick_NSP/A2/AK_pa_1m_2090_a2.tif") %>% 
  terra::project(ak_albers) %>%
  terra::resample(gnatsgo_1000, method = "near") %>%
  terra::clamp(lower=50,upper=100, values=FALSE) %>%
  round() %>%
  terra::subst(from=c(50:100), to=1) %>%
  terra::mask(rast_soil)

#----------Combine timepoints and scenarios into one stack----------------
pastick_scen = c(past50_B1_1m_bin, past90_B1_1m_bin, past50_A1B_1m_bin, past90_A1B_1m_bin, past50_A2_1m_bin, past90_A2_1m_bin)
names(pastick_scen) = c("past50_B1_1m_bin", "past90_B1_1m_bin", "past50_A1B_1m_bin", "past90_A1B_1m_bin", "past50_A2_1m_bin", "past90_A2_1m_bin")
pastick_scen

# EXAMPLE: plot scenarios by calling layers
par(mfrow=c(1,3))
plot(pastick_scen$past50_A1B_1m_bin)
plot(pastick_scen$past50_B1_1m_bin)
plot(pastick_scen$past50_A2_1m_bin)

#----------Write to Cache----------------
writeRaster(past50_B1_1m_bin, "./06-cache/past50_B1_1m_bin.tif")
writeRaster(past90_B1_1m_bin, "./06-cache/past90_B1_1m_bin.tif")
writeRaster(past50_A1B_1m_bin, "./06-cache/past50_A1B_1m_bin.tif")
writeRaster(past90_A1B_1m_bin, "./06-cache/past90_A1B_1m_bin.tif")
writeRaster(past50_A2_1m_bin, "./06-cache/past50_A2_1m_bin.tif")
writeRaster(past90_A2_1m_bin, "./06-cache/past90_A2_1m_bin.tif")
