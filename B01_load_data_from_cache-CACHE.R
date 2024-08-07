#----------Load Processed STATSGO & gNATSGO data----------
stat_rast_gelisol = terra::rast("./06-cache/stat_rast_gelisol.tif") 

stat_rast_turbel = terra::rast("./06-cache/stat_rast_turbel.tif") 

stat_rast_orthel = terra::rast("./06-cache/stat_rast_orthel.tif") 

stat_rast_histel = terra::rast("./06-cache/stat_rast_histel.tif") 

gnat_rast_gelisol = terra::rast("./06-cache/gnat_rast_gelisol.tif") 

gnat_rast_turbel = terra::rast("./06-cache/gnat_rast_turbel.tif") 

gnat_rast_orthel = terra::rast("./06-cache/gnat_rast_orthel.tif") 

gnat_rast_histel = terra::rast("./06-cache/gnat_rast_histel.tif") 

gnatsgo_1000 = terra::rast("./06-cache/gnatsgo_1000.tif")

stat_rast = terra::rast("./06-cache/stat_rast.tif")

mlra_albers_AK = terra::vect("./06-cache/mlra_albers_AK.shp")

lrr_albers_AK = terra::vect("./06-cache/lrr_albers_AK.shp")

lrr_albers_domain = terra::vect("./06-cache/lrr_albers_domain.shp")

mlra_albers_domain = terra::vect("./06-cache/mlra_albers_domain.shp")

mlra_rast = terra::rast("./06-cache/mlra_rast.tif")

lrr_rast = terra::rast("./06-cache/lrr_rast.tif")

#----------Load Processed Pastick Baseline and Domain data----------

past00_1000 <- terra::rast("./06-cache/past00_1000.tif")

rast_soil = terra::rast("./06-cache/rast_soil.tif")

rast_domain = terra::rast("./06-cache/rast_domain.tif")

rast_water = terra::rast("./06-cache/rast_water.tif")

rast_rock = terra::rast("./06-cache/rast_rock.tif")

rast_ice = terra::rast("./06-cache/rast_ice.tif")

rast_urban = terra::rast("./06-cache/rast_urban.tif")

rast_nonsoil = terra::rast("./06-cache/rast_nonsoil.tif")

rast_rockiceurban = terra::rast("./06-cache/rast_rockiceurban.tif")

#----------Load Baseline Binaries Stack----------

baseline_binaries = terra::rast("./06-cache/baseline_binaries.tif")
