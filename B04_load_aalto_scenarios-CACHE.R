#----------Load Aalto RCP 2.6 Scenario Rasters, Make Binary and Stack----------
# 2050
aalto50_RCP26_1m_bin = terra::rast("./06-cache/aalto50_RCP26_1m_bin.tif") 

aalto50_RCP26_2m_bin = terra::rast("./06-cache/aalto50_RCP26_2m_bin.tif")

# 2070
aalto70_RCP26_1m_bin = terra::rast("./06-cache/aalto70_RCP26_1m_bin.tif")

aalto70_RCP26_2m_bin = terra::rast("./06-cache/aalto70_RCP26_2m_bin.tif") 

#----------Load Aalto RCP 4.5 Scenario Rasters, Make Binary and Stack----------
# 2050
aalto50_RCP45_1m_bin = terra::rast("./06-cache/aalto50_RCP45_1m_bin.tif") 

aalto50_RCP45_2m_bin = terra::rast("./06-cache/aalto50_RCP45_2m_bin.tif")

# 2070
aalto70_RCP45_1m_bin = terra::rast("./06-cache/aalto70_RCP45_1m_bin.tif")

aalto70_RCP45_2m_bin = terra::rast("./06-cache/aalto70_RCP45_2m_bin.tif") 

#----------Load Aalto RCP 8.5 Scenario Rasters, Make Binary and Stack----------
# 2050
aalto50_RCP85_1m_bin = terra::rast("./06-cache/aalto50_RCP85_1m_bin.tif") 

aalto50_RCP85_2m_bin = terra::rast("./06-cache/aalto50_RCP85_2m_bin.tif")

# 2070
aalto70_RCP85_1m_bin = terra::rast("./06-cache/aalto70_RCP85_1m_bin.tif")

aalto70_RCP85_2m_bin = terra::rast("./06-cache/aalto70_RCP85_2m_bin.tif") 

#----------Combine timepoints into one scenario stack----------
aalto_scen = c(aalto50_RCP26_1m_bin, aalto50_RCP26_2m_bin, aalto70_RCP26_1m_bin, aalto70_RCP26_2m_bin, aalto50_RCP45_1m_bin, aalto50_RCP45_2m_bin, aalto70_RCP45_1m_bin, aalto70_RCP45_2m_bin, aalto50_RCP85_1m_bin, aalto50_RCP85_2m_bin, aalto70_RCP85_1m_bin, aalto70_RCP85_2m_bin)
names(aalto_scen) = c("aalto50_RCP26_1m_bin", "aalto50_RCP26_2m_bin", "aalto70_RCP26_1m_bin", "aalto70_RCP26_2m_bin", "aalto50_RCP45_1m_bin", "aalto50_RCP45_2m_bin", "aalto70_RCP45_1m_bin", "aalto70_RCP45_2m_bin", "aalto50_RCP85_1m_bin", "aalto50_RCP85_2m_bin", "aalto70_RCP85_1m_bin", "aalto70_RCP85_2m_bin")
aalto_scen

# Example: plot scenarios by calling layers
par(mfrow=c(2,2))
plot(aalto_scen$aalto50_RCP26_1m_bin, ext = past00_1000, col = "steelblue3")
plot(aalto_scen$aalto70_RCP26_1m_bin, ext = past00_1000, col = "steelblue3")
plot(aalto_scen$aalto70_RCP45_1m_bin, ext = past00_1000, col = "steelblue3")
plot(aalto_scen$aalto70_RCP85_1m_bin, ext = past00_1000, col = "steelblue3")

