#----------Read in MLRA Spatial Data and Curate Associated Tabular Data, Generate 1000m MLRA Raster ----------
# Load in MLRA as vector, check validity, and rasterize to gNATSGO grid
mlra_albers_AK <- terra::vect("./01-data/2022 MLRA Boundaries from NRCS_52_2022/MLRA_52.shp") %>% 
  terra::project(ak_albers) %>%
  terra::crop(gnatsgo_extent)

# check validity. This returns a vector where each entry represents one polygon as TRUE or FALSE. TRUE if geometry is valid "FALSE" if invalid
val_chk <- is.valid(mlra_albers_AK)
# This returns a list of which polygons are false. If empty, it means all are TRUE and are valid ##it returns empty which means every polygon has "TRUE" in valid, so the whole thing is valid. No need to fix geometries here as was the case in STATSGO import
which('FALSE'==val_chk)

# MLRARSYM is coded as a character here because some MLRAs in the lower 48 have a letter subcode (i.e. like 49a, 49b). However in Alaska they all have unique numbers. So, when you crop, the attribute table still retains the format (i.e. even though MLRARSYM *could* be an integer now it is still coded as a character). So, here convert MLRARSYM to an integer for easier use later on and for easy raster burn in
mlra_albers_AK$MLRARSYM = as.integer(mlra_albers_AK$MLRARSYM)
mlra_albers_AK

writeVector(mlra_albers_AK, filename = "./06-cache/mlra_albers_AK.shp", overwrite = TRUE)

# MLRA - rasterize to 1000m cells (1000m is what you decided on), use gNATSGO grid as the foundation. burn in MLRARSYM value to this raster. ##MLRA - rasterize to 1000m cells (1000m is what you decided on), use gNATSGO grid as the foundation. burn in MLRARSYM value to this raster.
mlra_rast = rasterize(mlra_albers_AK, gnatsgo_1000, field="MLRARSYM") # less than 1min
mlra_rast
plot(mlra_rast)

# Write to cache
writeRaster(mlra_rast, filename = "./06-cache/mlra_rast.tif", overwrite = TRUE)

#----------Generate LRR 1000m LRR Raster from MLRA----------

# Generate LRR vector by dissolving polygons based on common LRR names
lrr_albers_AK = aggregate(mlra_albers_AK, by = 'LRRSYM')
plot(lrr_albers_AK)

# Write to cache
writeVector(lrr_albers_AK, filename = "./06-cache/lrr_albers_AK.shp", overwrite = TRUE)

# LRR - rasterize to 1000m cells, use gNATSGO grid as the foundation. burn in LRRSYM value to this raster. LRR will still burn in as a character and end up as random numbers. You have a choice then, you can either manually figure out the burned in numbers and reclass (but would still be numbers so doesn't make sense - or represent characters as factors):  https://gis.stackexchange.com/questions/391215/attribute-table-in-r-terra-package.
lrr_rast = rasterize(lrr_albers_AK, gnatsgo_1000, field="LRRSYM")
lrr_rast
plot(lrr_rast)

# Write to cache
writeRaster(lrr_rast, filename = "./06-cache/lrr_rast.tif", overwrite = TRUE)

