#----------Read in 1km gNATSGO serves as a raster template for other baseline data; Pastick 2000 serves as extent template for other baseline data; Read in Raw STATSGO vector spatial and tabular data----------

#---------- Read in gNATSGO Spatial and Tabular Data, Generate 1000m MU Raster ----------
# Raw AK gNATSGO data from NRCS direct BOX download here: https://nrcs.app.box.com/v/soils/file/895774037802. Then unzipped. It is distributed in .gdb format. Use ArcGIS to pre-process and export the gdb as a tiff. In the Data Management toolbox - Raster Processing - Resample. Choose the original 10m MapunitRaster (gNATSGO from NRCS) as the input raster "MapunitRaster_10m. Choose cell size as x = 1000, Y = 1000. These can be in meters because the dataset comes as Alaska Albers. If it is not projected, need to project before doing this. Set an output raster name and file path. Choose resampling technique as NEAREST (nearest neighbor). The result of that was a ~35mB file called "MURast_gNATSGO_1000m_AK_202210_NN.tif". 

# OK read in file:
gnatsgo_1000 = terra::rast("./01-data/gNATSGO_AK_OCT_2022/MURast_gNATSGO_1000m_AK_202210_NN1.tif")
plot(gnatsgo_1000)

# check crs
crs(gnatsgo_1000)

# create SpatExtent object from gnatsgo
gnatsgo_extent=ext(gnatsgo_1000)

# read in gNATSGO component table - RAW export from .gdb using ArcGIS as .txt - converted to .csv in Microsoft Excel
comp_gnatsgo <- read.csv("./01-data/gNATSGO_AK_OCT_2022/gNATSGO_component.csv")
str(comp_gnatsgo)

# read in gNATSGO muaggatt table - RAW export from .gdb using ArcGIS as .txt - converted to .csv in Microsoft Excel
mu_gnatsgo <- read.csv("./01-data/gNATSGO_AK_OCT_2022/gNATSGO_muaggatt.csv")
str(mu_gnatsgo)

#----------Read in STATSGO2 Spatial and Tabular Data, Generate 1000m MU Raster ----------
# Load in STATSGO2 as vector
stat <- terra::vect("./01-data/STATSGO2_AK_2016/spatial/gsmsoilmu_a_ak.shp")
stat

# make mukey numeric instead of character
stat$mukey=as.numeric(stat$MUKEY)

# reproject to EPSG 6393 (standard projection for this project), because that is what gNATSGO is in and using gNATSGO as a template
stat_albers = terra::project(stat, ak_albers)

# check validity. This returns a vector where each entry represents one polygon as TRUE or FALSE. TRUE if geometry is valid "FALSE" if invalid
val_chk <- is.valid(stat_albers)

# This returns a list of which polygons are false. If empty, it means all are TRUE and are valid. In this case it is not empty, so need to try and fix some polygon geometries before moving on.
which('FALSE'==val_chk)

# Attempt to make valid - takes < 10s
stat_albers_val = makeValid(stat_albers)
# check validity
val_chk <- is.valid(stat_albers_val)
# the following returns empty which means every polygon has "TRUE" in valid, so the whole thing is valid
which('FALSE'==val_chk)

# rasterize to 1000m cells, use gNATSGO grid as the foundation. burn in MUKEY value to this raster
stat_rast = rasterize(stat_albers_val, gnatsgo_1000, field="mukey") # less than 1min
stat_rast
plot(stat_rast)

# read in STATSGO component table - RAW export from .mdb using Microsoft Access - converted to .csv in Microsoft Excel
comp_statsgo <- read.csv("./01-data/tables/STATSGO_component.csv")
str(comp_statsgo)

# read in STATSGO muaggatt table - RAW export from .mdb using Microsoft Access - converted to .csv in Microsoft Excel
mu_statsgo <- read.csv("./01-data/tables/STATSGO_muaggatt.csv")
str(mu_statsgo)

#----------Read in Pastick Early Century Baseline Raster, Reproject and Resample to 1000m ----------
# Import and plot Pastick baseline raster 00_09, reproject to epsg 6393 (this is the epsg for gNATSGO so using that as base). Resample to 1000m and align to gNATSGO. This takes ~10min.

past00_1000 <- terra::rast("./01-data/Pastick_NSP/Pastick_NSPProb_2000to2009.tif") %>% 
  terra::project(ak_albers) %>% 
  terra::resample(gnatsgo_1000, method = "near")

plot(past00_1000)

# Write Projected, Resampled Pastick to Cache
writeRaster(past00_1000, "./06-cache/past00_1000.tif", overwrite=TRUE)
