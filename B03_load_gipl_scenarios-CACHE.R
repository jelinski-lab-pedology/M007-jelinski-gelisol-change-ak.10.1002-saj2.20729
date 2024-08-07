#----------Load GIPL A1B Scenario Binary Rasters from Cache ----------------
GIPL50_A1B_1m_bin = terra::rast("./06-cache/GIPL50_A1B_1m_bin.tif")
GIPL90_A1B_1m_bin = terra::rast("./06-cache/GIPL90_A1B_1m_bin.tif")
GIPL50_A1B_2m_bin = terra::rast("./06-cache/GIPL50_A1B_2m_bin.tif")
GIPL90_A1B_2m_bin = terra::rast("./06-cache/GIPL90_A1B_2m_bin.tif")

#----------Combine into one scenario stack for A1B 1m ----------
GIPL_scen = c(GIPL50_A1B_1m_bin, GIPL90_A1B_1m_bin, GIPL50_A1B_2m_bin, GIPL90_A1B_2m_bin)
names(GIPL_scen) = c("GIPL50_A1B_1m_bin", "GIPL90_A1B_1m_bin", "GIPL50_A1B_2m_bin", "GIPL90_A1B_2m_bin")
GIPL_scen

#---------- example plot scenarios by calling layers----------
par(mfrow=c(2,2))
plot(GIPL_scen$GIPL50_A1B_1m_bin, ext = past00_1000, col = "steelblue3")
plot(GIPL_scen$GIPL90_A1B_1m_bin, ext = past00_1000, col = "steelblue3")
plot(GIPL_scen$GIPL50_A1B_2m_bin, ext = past00_1000, col = "steelblue3")
plot(GIPL_scen$GIPL90_A1B_2m_bin, ext = past00_1000, col = "steelblue3")