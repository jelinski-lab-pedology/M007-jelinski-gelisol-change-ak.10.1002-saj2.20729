#----------Load required packages----------
# generate list of required packages
list_of_packages <- c("terra", "sf", "leaflet", "magrittr", "htmlTable", "dplyr", "stringr", "hrbrthemes", "tidyverse", "ggplot2", "gridExtra", "cowplot", "prettymapr", "plotrix")

# load packages
lapply(list_of_packages, library, character.only = TRUE)

#----------Set standard projection----------

# standard projection for project = NAD83(2011) / Alaska Albers (EPSG: 6393), NOT the original version (3338): https://epsg.io/6393
ak_albers = "EPSG:6393"

#----------Define custom functions----------

# Define custom use cache function (this allows the user to choose to use pre-generated files and skip the time-consuming processing steps). In this case since everything is pulled from the cache, .CacheUse is set to yes. Any other option will throw an error for the B series scripts.

.CacheUse = askYesNo("Would you like to files from the cache? Code execution time is much faster w cached files.", default  = TRUE, prompts = c("yes","no", "na"))

yes

# Define function for pipes for greater than 0. 
.GreaterEqualZero=function(x){
  return(x >=0)
}

# Define function for pipes to multiply by 100. 
.Mult100=function(x){
  return(x*100)
}

# Define function for multiplying rasters to use with pipes
.MultRaster=function(x,y){
  return(x*y)
}

# Define function for subtracting rasters to use with pipes
.SubtractRaster=function(x,y){
  return(x-y)
}

#----------Unzip files to cache----------
unzip("./aalto.zip", exdir = "./06-cache")
unzip("./baseline.zip", exdir = "./06-cache")
unzip("./gipl.zip", exdir = "./06-cache")
unzip("./lrr_mlra.zip", exdir = "./06-cache")
unzip("./pastick.zip", exdir = "./06-cache")
unzip("./stat_gnat.zip", exdir = "./06-cache")
unzip("./yi_and_misc.zip", exdir = "./06-cache")