#----------Define Scenario Generation Function----------
# Define scenario generation function 
generate.taxon.scenarios <- function(lyr_stack, taxon, scenario_name){
  
  lyr_names.vec = as.vector(unique(names(lyr_stack)))
  lyr_names.length = length(lyr_names.vec)
  stack.init = c(get(paste("stat_rast_",taxon,sep="")))
  stack_name = paste(scenario_name,"_",taxon,sep="")
  
  for (i in 1:lyr_names.length){
    
    a = lyr_stack[[i]]*get(paste("stat_rast_",taxon,sep=""))
    stack.init = append(stack.init, a)
    writeRaster(stack.init,"./06-cache/stack-Cache.grd", overwrite = TRUE)
    
  }
  stack.final = terra::rast("./06-cache/stack-Cache.grd")
  writeRaster(stack.final, paste("./06-cache/",stack_name,".grd",sep=""), overwrite = TRUE)
}
  

#----------Baselines----------
generate.taxon.scenarios(baseline_binaries, taxon = "orthel", scenario_name = "baseline")
baseline_orthel = terra::rast("./06-cache/baseline_orthel.grd")

generate.taxon.scenarios(baseline_binaries, taxon = "histel", scenario_name = "baseline")
baseline_histel = terra::rast("./06-cache/baseline_histel.grd")

generate.taxon.scenarios(baseline_binaries, taxon = "turbel", scenario_name = "baseline")
baseline_turbel = terra::rast("./06-cache/baseline_turbel.grd")

generate.taxon.scenarios(baseline_binaries, taxon = "gelisol", scenario_name = "baseline")
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

#----------Pastick 50-59 and 90-99, B1, A1B, A2----------
generate.taxon.scenarios(pastick_scen, taxon = "orthel", scenario_name = "pastick_scen")
pastick_scen_orthel = terra::rast("./06-cache/pastick_scen_orthel.grd")
    
generate.taxon.scenarios(pastick_scen, taxon = "histel", scenario_name = "pastick_scen")
pastick_scen_histel = terra::rast("./06-cache/pastick_scen_histel.grd")

generate.taxon.scenarios(pastick_scen, taxon = "turbel", scenario_name = "pastick_scen")
pastick_scen_turbel = terra::rast("./06-cache/pastick_scen_turbel.grd")

generate.taxon.scenarios(pastick_scen, taxon = "gelisol", scenario_name = "pastick_scen")
pastick_scen_gelisol = terra::rast("./06-cache/pastick_scen_gelisol.grd")

par(mfrow=c(2,2))
plot(pastick_scen_gelisol$past50_B1_1m_bin, ext = past00_1000)
plot(pastick_scen_gelisol$past90_B1_1m_bin, ext = past00_1000)
plot(pastick_scen_gelisol$past50_A2_1m_bin, ext = past00_1000)
plot(pastick_scen_gelisol$past50_A2_1m_bin, ext = past00_1000)

#----------GIPL 50-59 and 90-99, A1B----------
generate.taxon.scenarios(GIPL_scen, taxon = "orthel", scenario_name = "gipl_scen")
gipl_scen_orthel = terra::rast("./06-cache/gipl_scen_orthel.grd")

generate.taxon.scenarios(GIPL_scen, taxon = "histel", scenario_name = "gipl_scen")
gipl_scen_histel = terra::rast("./06-cache/gipl_scen_histel.grd")

generate.taxon.scenarios(GIPL_scen, taxon = "turbel", scenario_name = "gipl_scen")
gipl_scen_turbel = terra::rast("./06-cache/gipl_scen_turbel.grd")

generate.taxon.scenarios(GIPL_scen, taxon = "gelisol", scenario_name = "gipl_scen")
gipl_scen_gelisol = terra::rast("./06-cache/gipl_scen_gelisol.grd")

par(mfrow=c(2,2))
plot(gipl_scen_gelisol$GIPL50_A1B_1m_bin, ext = past00_1000)
plot(gipl_scen_gelisol$GIPL50_A1B_2m_bin, ext = past00_1000)
plot(gipl_scen_gelisol$GIPL90_A1B_1m_bin, ext = past00_1000)
plot(gipl_scen_gelisol$GIPL90_A1B_2m_bin, ext = past00_1000)

#----------Aalto 2050 and 2070, RCP 2.6, 4.5, 8.5----------
generate.taxon.scenarios(aalto_scen, taxon = "orthel", scenario_name = "aalto_scen")
aalto_scen_orthel = terra::rast("./06-cache/aalto_scen_orthel.grd")

generate.taxon.scenarios(aalto_scen, taxon = "histel", scenario_name = "aalto_scen")
aalto_scen_histel = terra::rast("./06-cache/aalto_scen_histel.grd")

generate.taxon.scenarios(aalto_scen, taxon = "turbel", scenario_name = "aalto_scen")
aalto_scen_turbel = terra::rast("./06-cache/aalto_scen_turbel.grd")

generate.taxon.scenarios(aalto_scen, taxon = "gelisol", scenario_name = "aalto_scen")
aalto_scen_gelisol = terra::rast("./06-cache/aalto_scen_gelisol.grd")

# Example: plotting
par(mfrow=c(2,2))
plot(aalto_scen_gelisol$aalto50_RCP26_2m_bin, ext = past00_1000)
plot(aalto_scen_gelisol$aalto70_RCP26_2m_bin, ext = past00_1000)
plot(aalto_scen_gelisol$aalto50_RCP85_2m_bin, ext = past00_1000)
plot(aalto_scen_gelisol$aalto70_RCP85_2m_bin, ext = past00_1000)