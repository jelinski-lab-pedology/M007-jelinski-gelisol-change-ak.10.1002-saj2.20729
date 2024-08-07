#---------- Make LRR Table Function No Commas----------
generate.custom.table.lrr = function (lyr_list, name_list, table_name) {
  
  field_list = names(lyr_list)
  lyr_list.length = nlyr(lyr_list)
  #lyr_list.length = length(lyr_list@ptr$names)
  
  mlra_df = terra::as.data.frame(mlra_albers_AK)
  lrr_area_tab<-mlra_df[, c("LRR_NAME","LRRSYM")]
  lrr_area_tab <- lrr_area_tab[!duplicated(lrr_area_tab), ]
  colnames(lrr_area_tab)[1:2] = c("LRR Name", "LRR Symbol")
  
  for (i in 1:lyr_list.length){
    lyr_area = zonal(lyr_list[[i]],lrr_rast, fun="sum",na.rm=TRUE)
    lyr_area$km2 = round(eval(parse(text = paste("lyr_area$",field_list[i],sep=""))))
    # note because the cells are 1km, then the sum of cells is km2
    # other note - for the above line to work the field or layer name (pasted in "field_list[i]") must not have any spaces otherwise it parses incorrect. i.e. "Soil_Cells" not Soil Cells". Need to check the names function for the raster to ensure that is the case - otherwise need to rename.
    lyr_area$km2_com = format(lyr_area$km2,big.mark=",", trim=TRUE, digits = 2, scientific = FALSE)
    
    colnames(lyr_area)[1] = "LRR Symbol"
    colnames(lyr_area)[3] = name_list[i]
    
    lyr_area <- lyr_area %>%
      select('LRR Symbol', name_list[i])
    
    lrr_area_tab <- left_join(lrr_area_tab, lyr_area, by = "LRR Symbol")
  }
  
  final.tab = 
    htmlTable::htmlTable(lrr_area_tab[,2:(i+2)], 
              rnames = lrr_area_tab$'LRR Name',
              align = "r")
  
  write.csv(lrr_area_tab, table_name)
  return(final.tab)
} 

#----------Make LRR Table Function With Commas----------

generate.custom.table.commas.lrr = function (lyr_list, name_list, table_name) {
  
  field_list = names(lyr_list)
  lyr_list.length = nlyr(lyr_list)
  
  mlra_df = terra::as.data.frame(mlra_albers_AK)
  lrr_area_tab<-mlra_df[, c("LRR_NAME","LRRSYM")]
  lrr_area_tab <- lrr_area_tab[!duplicated(lrr_area_tab), ]
  colnames(lrr_area_tab)[1:2] = c("LRR Name", "LRR Symbol")
  
  #if (lyr_list.length == length(name_list)) {
  
  for (i in 1:lyr_list.length){
    lyr_area = zonal(lyr_list[[i]],lrr_rast, fun="sum",na.rm=TRUE)
    lyr_area$km2 = round(eval(parse(text = paste("lyr_area$",field_list[i],sep=""))))
    # note because the cells are 1km, then the sum of cells is km2
    # other note - for the above line to work the field or layer name (pasted in "field_list[i]") must not have any spaces otherwise it parses incorrect. i.e. "Soil_Cells" not Soil Cells". Need to check the names function for the raster to ensure that is the case - otherwise need to rename.
    lyr_area$km2_com = format(lyr_area$km2,big.mark=",", trim=TRUE, digits = 2, scientific = FALSE)
    
    colnames(lyr_area)[1] = "LRR Symbol"
    #use below to have commas in the numbers for readability
    colnames(lyr_area)[4] = name_list[i]
    
    lyr_area <- lyr_area %>%
      select('LRR Symbol', name_list[i])
    
    lrr_area_tab <- left_join(lrr_area_tab, lyr_area, by = "LRR Symbol")
  }
  
  final.tab = 
    htmlTable::htmlTable(lrr_area_tab[,2:(i+2)], 
              rnames = lrr_area_tab$'LRR Name',
              align = "r")
  
  write.csv(lrr_area_tab, table_name)
  return(final.tab)
} 