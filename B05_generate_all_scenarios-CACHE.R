#---------- Load Baselines----------------
baseline_orthel = terra::rast("./06-cache/baseline_orthel.grd")

baseline_histel = terra::rast("./06-cache/baseline_histel.grd")

baseline_turbel = terra::rast("./06-cache/baseline_turbel.grd")

baseline_gelisol = terra::rast("./06-cache/baseline_gelisol.grd")

    # Sanity Check
    yi_gel_prev_sum = baseline_orthel$yi_2m_bin + baseline_histel$yi_2m_bin + baseline_turbel$yi_2m_bin
    names(yi_gel_prev_sum) = "yi_gel_prev_sum"
    
    par(mfrow=c(2,2))
    plot(baseline_orthel$yi_2m_bin, ext = past00_1000)
    plot(baseline_histel$yi_2m_bin, ext = past00_1000)
    plot(baseline_turbel$yi_2m_bin, ext = past00_1000)
    plot(baseline_gelisol$yi_2m_bin, ext = past00_1000)
    plot(baseline_gelisol$yi_2m_bin, ext = past00_1000)
    plot(yi_gel_prev_sum, ext = past00_1000)

#---------- Pastick 50-59 and 90-99, B1, A1B, A2----------------
pastick_scen_orthel = terra::rast("./06-cache/pastick_scen_orthel.grd")
    
pastick_scen_histel = terra::rast("./06-cache/pastick_scen_histel.grd")

pastick_scen_turbel = terra::rast("./06-cache/pastick_scen_turbel.grd")

pastick_scen_gelisol = terra::rast("./06-cache/pastick_scen_gelisol.grd")

par(mfrow=c(2,2))
plot(pastick_scen_gelisol$past50_B1_1m_bin, ext = past00_1000)
plot(pastick_scen_gelisol$past90_B1_1m_bin, ext = past00_1000)
plot(pastick_scen_gelisol$past50_A2_1m_bin, ext = past00_1000)
plot(pastick_scen_gelisol$past50_A2_1m_bin, ext = past00_1000)

#----------GIPL 50-59 and 90-99, A1B----------------
gipl_scen_orthel = terra::rast("./06-cache/gipl_scen_orthel.grd")

gipl_scen_histel = terra::rast("./06-cache/gipl_scen_histel.grd")

gipl_scen_turbel = terra::rast("./06-cache/gipl_scen_turbel.grd")

gipl_scen_gelisol = terra::rast("./06-cache/gipl_scen_gelisol.grd")

par(mfrow=c(2,2))
plot(gipl_scen_gelisol$GIPL50_A1B_1m_bin, ext = past00_1000)
plot(gipl_scen_gelisol$GIPL50_A1B_2m_bin, ext = past00_1000)
plot(gipl_scen_gelisol$GIPL90_A1B_1m_bin, ext = past00_1000)
plot(gipl_scen_gelisol$GIPL90_A1B_2m_bin, ext = past00_1000)

#----------Aalto 2050 and 2070, RCP 2.6, 4.5, 8.5 ----------------
aalto_scen_orthel = terra::rast("./06-cache/aalto_scen_orthel.grd")

aalto_scen_histel = terra::rast("./06-cache/aalto_scen_histel.grd")

aalto_scen_turbel = terra::rast("./06-cache/aalto_scen_turbel.grd")

aalto_scen_gelisol = terra::rast("./06-cache/aalto_scen_gelisol.grd")

# Example: Plotting
par(mfrow=c(2,2))
plot(aalto_scen_gelisol$aalto50_RCP26_2m_bin, ext = past00_1000)
plot(aalto_scen_gelisol$aalto70_RCP26_2m_bin, ext = past00_1000)
plot(aalto_scen_gelisol$aalto50_RCP85_2m_bin, ext = past00_1000)
plot(aalto_scen_gelisol$aalto70_RCP85_2m_bin, ext = past00_1000)