#----------Load Pastick B1 Scenario Rasters----------
past50_B1_1m_bin = terra::rast("./06-cache/past50_B1_1m_bin.tif") 

past90_B1_1m_bin = terra::rast("./06-cache/past90_B1_1m_bin.tif") 

#----------Load Pastick A1B Scenario Raster----------
past50_A1B_1m_bin = terra::rast("./06-cache/past50_A1B_1m_bin.tif") 

past90_A1B_1m_bin = terra::rast("./06-cache/past90_A1B_1m_bin.tif") 

#----------Load Pastick A2 Scenario Rasters----------
past50_A2_1m_bin = terra::rast("./06-cache/past50_A2_1m_bin.tif") 

past90_A2_1m_bin = terra::rast("./06-cache/past90_A2_1m_bin.tif") 

#----------Stack Rasters----------
# Combine into one scenario stack for A1B
pastick_scen = c(past50_B1_1m_bin, past90_B1_1m_bin, past50_A1B_1m_bin, past90_A1B_1m_bin, past50_A2_1m_bin, past90_A2_1m_bin)
names(pastick_scen) = c("past50_B1_1m_bin", "past90_B1_1m_bin", "past50_A1B_1m_bin", "past90_A1B_1m_bin", "past50_A2_1m_bin", "past90_A2_1m_bin")
pastick_scen

# Example: plot scenarios by calling layers
par(mfrow=c(2,2))
plot(pastick_scen$past50_A1B_1m_bin, ext=past00_1000, col="steelblue3")
plot(pastick_scen$past50_B1_1m_bin, ext=past00_1000, col="steelblue3")
plot(pastick_scen$past50_A2_1m_bin,ext=past00_1000, col="steelblue3")