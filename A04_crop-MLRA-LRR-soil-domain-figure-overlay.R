#---------- Crop LRR Vector to Domain ----------
# the initial problem to solve is that there are only 5 multipart polygons (one for each LRR, but you need to split then into a record for each individual polygon in order to subset only the ones that are in your modeling domain)

# First convert all single polygons to multi-part polygons:
lrr_albers_AK_multi = disagg(lrr_albers_AK)

# Add a new unique ID column
lrr_albers_AK_multi[["ID_new"]] <- 1:nrow(lrr_albers_AK_multi)

#--- extract 1 for each polygon if soil cells are present ---#
sum_cells_by_polygon <-
  terra::extract(
    rast_soil,
    lrr_albers_AK_multi,
    fun = mean, na.rm=T
  )

# join to lrr_albers vector
lrr_albers_count = terra::merge(lrr_albers_AK_multi, sum_cells_by_polygon, by.x = c('ID_new'), by.y = c("ID"))

# subset polygons to draw only the ones that have soil cells present
lrr_albers_domain = subset(lrr_albers_count, lrr_albers_count$Soil_Cells == 1)

# plot side by side to ensure correct
par(mfrow=c(1,2))
plot(lrr_albers_AK)
plot(lrr_albers_domain)

#---------- Crop MLRA Vector to Domain ----------

# the initial problem to solve is that there are only 5 multipart polygons (one for each LRR, but you need to split then into a record for each individual polygon in order to subset only the ones that are in your modeling domain)

# First convert all single polygons to multi-part polygons:
mlra_albers_AK_multi = disagg(mlra_albers_AK)

# Add a new unique ID column
mlra_albers_AK_multi[["ID_new"]] <- 1:nrow(mlra_albers_AK_multi)

#--- extract 1 for each polygon if soil cells are present ---#
sum_cells_by_polygon <-
  terra::extract(
    rast_soil,
    mlra_albers_AK_multi,
    fun = mean, na.rm=T
  )

# join to lrr_albers vector
mlra_albers_count = terra::merge(mlra_albers_AK_multi, sum_cells_by_polygon, by.x = c('ID_new'), by.y = c("ID"))

# subset polygons to draw only the ones that have soil cells present
mlra_albers_domain = subset(mlra_albers_count, mlra_albers_count$Soil_Cells == 1)

# plot side by side to ensure correct
par(mfrow=c(1,2))
plot(mlra_albers_AK)
plot(mlra_albers_domain)

sbar(d = 500000, xy= "bottomright",type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))
north(xy = "topright", type = 1, label = "N")
# note there are 1-12 different numbers to use for north arrows should check them out

#---------- Write to cache ----------
writeVector(lrr_albers_domain, "./06-cache/lrr_albers_domain.shp")
writeVector(mlra_albers_domain, "./06-cache/mlra_albers_domain.shp")
