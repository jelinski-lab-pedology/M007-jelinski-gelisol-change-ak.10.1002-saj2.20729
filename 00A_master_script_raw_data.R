#---------- This master script executes all modules in sequence. NOTE: this master script is for running all steps starting with raw data sources (see readme). Raw data sources are not made available as part of this release due to copyright and data ownership. Those interested in running this portion of the code will need to obtain the raw data from the original sources and/or authors as necessary. ----------

#---------- If you have acquired the raw data sources, they should be placed in the "01-data" folder (currently empty in this release) as follows: ----------

# MLRA and LRR Boundaries:
# https://www.nrcs.usda.gov/resources/data-and-reports/major-land-resource-area-mlra [October 2022 release].
# named folder in code: "./01-data/2022 MLRA Boundaries from NRCS_52_2022"

# AK Soil Data Availability
# obtained from Alaska-NRCS State GIS Coordinator [October 2022 release]
# named folder in code: "./01-data/2022_SoilDataAvailabilityShapefile"

# Alaska coastline, 250,000 scale
# https://gis.data.alaska.gov/datasets/SOA-DNR::alaska-coastline/about?layer=2 [obtained 04OCT2022] IN
# https://gis.data.alaska.gov/maps/SOA-DNR::alaska-coastline/about
# named folder in code: "./01-data/AK_COASTLINE_250000

# Aalto et al. 2018. Northern Circumpoplar ALT Rasters 
# from publication: https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2018GL078007 
# Dryad data repository: https://datadryad.org/stash/dataset/doi:10.5061/dryad.886pr72 
# named folder in code: "./01-data/doi_10.5061_dryad.886pr72__v1"

# DOS-TEM binary near-surface permafrost 
# from publication: Wylie, B.K., Pastick, N.J., Johnson, K.D., Bliss, N., and H. Genet. 2016. "Chapter 3. Soil Carbon and Permafrost Estimates and Susceptibility to Climate Change in Alaska. In Baseline and Projected Future Carbon Storage and Greenhouse-Gas Fluxes in Ecosystems of Alaska, 196. USGS Professional Paper 1826. United States Geological Survey. https://pubs.usgs.gov/pp/1826/pp1826_chapter3.pdf; model described in: Genet, Hélène, Yujie He, A David McGuire, Qianlai Zhuang, Yujin Zhang, Frances E Biles, David V D’Amore, Xiaoping Zhou, and Kristopher D Johnson. 2016. “Chapter 6. Terrestrial Carbon Modeling: Baseline and Projections in Upland Ecosystems.” In Baseline and Projected Future Carbon Storage and Greenhouse-Gas Fluxes in Ecosystems of Alaska, 196. USGS Professional Paper 1826. United States Geological Survey. https://pubs.usgs.gov/pp/1826/pp1826_chapter6.pdf.
# must obtain from authors of the above articles
# named folder in code: "./01-data/DOS-TEM"

# GIPL model ALT under A1B scenario
# from publications: Wylie, B.K., Pastick, N.J., Johnson, K.D., Bliss, N., and H. Genet. 2016. "Chapter 3. Soil Carbon and Permafrost Estimates and Susceptibility to Climate Change in Alaska. In Baseline and Projected Future Carbon Storage and Greenhouse-Gas Fluxes in Ecosystems of Alaska, 196. USGS Professional Paper 1826. United States Geological Survey. https://pubs.usgs.gov/pp/1826/pp1826_chapter3.pdf; original from Jafarov, E. E., S. S. Marchenko, and V. E. Romanovsky. 2012. “Numerical Modeling of Permafrost Dynamics in Alaska Using a High Spatial Resolution Dataset.” The Cryosphere 6 (3): 613–24. https://doi.org/10.5194/tc-6-613-2012.
# must obtain from authors of the above articles
# named folder in code: "./01-data/GIPL_ALT"

# Pastick et al. 2015. Near-surface permafrost probabilities
# from publication: Pastick, Neal J., M. Torre Jorgenson, Bruce K. Wylie, Shawn J. Nield, Kristofer D. Johnson, and Andrew O. Finley. 2015. “Distribution of Near-Surface Permafrost in Alaska: Estimates of Present and Future Conditions.” Remote Sensing of Environment 168 (October): 301–15. https://doi.org/10.1016/j.rse.2015.07.019.
# must obtain from authors of above article
# named folder in code: "./01-data/Pastick_NSP

# Yi and Kimball 2020. ALT Estimates from Remote Sensing (ABoVE)
# from publication: Yi, Y., and J. S. Kimball. 2020. “Arctic-Boreal Vulnerability Experiment (ABoVE)ABoVE: Active Layer Thickness from Remote Sensing Permafrost Model, Alaska, 2001-2015,” 36.766169 MB. https://doi.org/10.3334/ORNLDAAC/1760.
# named folder in code: "./01-data/Sat_ActiveLayer_Thickness_Maps_1760"

# gNATSGO
# from USDA-NRCS: https://www.nrcs.usda.gov/resources/data-and-reports/gridded-national-soil-survey-geographic-database-gnatsgo [OCT 2022 Release]
# named folder in code: "./01-data/gNATSGO_AK_OCT_2022"

# STATSGO2
# from USDA-NRCS: https://www.nrcs.usda.gov/resources/data-and-reports/description-of-statsgo2-database [2016 release (most recent for just AK statewide STATSGO)]
# named folder in code: "./01-data/STATSGO2_AK_2016" 

#---------- Dataset preparation and scenario generation ----------
#A00_prep_workspace.R:
#1. Loads required packages
#2. Sets global objects, like for example standard projection, etc
#3. Writes custom functions
#4. Set .CacheUse to "yes" to use cached datasets rather than reprocess all - will save significant time. If you would like to generate from raw data sources, then set .CacheUse to "no".
#5. Unzips files to cache
source("A00_prep_workspace.R") #takes < 1min

#A01_process-baseline-geospatial-data.R:
#1. Reads in 1km raster for gNATSGO (EPSG:6393)
#2. Generates spat extent object from raster for later use as extent template
#3. Read in gNATSGO component and muaggatt tables
#4. Read in STATSGO shapefile, rasterize to 1km, and reproject to EPSG:6393
#5. Read in STATSGO component and muaggatt tables
#4. Read in raw Pastick early-century baseline raster, reproject to EPSG:6393, and resample to 1km
source(ifelse(.CacheUse == TRUE, "A01a_process-baseline-geospatial-data-CACHE.R","A01b_process-baseline-geospatial-data.R")) #no CACHE takes ~10min (reprojecting Pastick 30m statewide takes the longest) - #CACHE take ~ 1min

#A02_MLRA-LRR_readin_overlays:
#1. Read in MLRA and LRR vectors
#2. Check validity, reproject, and crop to domain
#3. Generate MLRA and LRR 1000m rasters
source("A02_MLRA-LRR_readin_overlays.R") #takes < 1min

#A03_MakePastickMasks.R
#1. Reclassification and correction of the Pastick raster
 # Corrects ice values in MLRAs 245 and 246
 # Reclassifies ice to water in northern Alaska
 # Sets agriculture areas to zero probability of permafrost
#2. Creation of domain and soil masks:
 # Generates a domain mask (rast_domain) for the entire analysis area
 # Creates a soil mask (rast_soil) identifying areas classified as soil
#3. Generation of non-soil masks:
 # Creates a non-soil mask (rast_nonsoil) for areas not classified as soil
 # Produces separate masks for water (rast_water), rock (rast_rock), ice (rast_ice), and urban areas (rast_urban)
#4. Creation of composite masks:
  # Generates a combined mask for rock, ice, and urban areas (rast_rockiceurban)
source("A03_MakePastickMasks.R") #takes ~ 1min

#A04_crop-MLRA-LRR-soil-domain-figure-overlay.R
#1. Crops the Land Resource Region (LRR) vector to the soil domain:
  #Disaggregates the LRR polygons
  #Identifies which polygons contain soil cells
  #Creates a new LRR vector (lrr_albers_domain) containing only polygons with soil cells
#2. Crops the Major Land Resource Area (MLRA) vector to the soil domain:
  # Follows the same process as for LRR, creating mlra_albers_domain
source("A04_crop-MLRA-LRR-soil-domain-figure-overlay.R") #takes ~ 1min

#A05_read_in_PF_baseline_data:
#1. Processes multiple near-surface permafrost presence/absence datasets:
  # Yi et al.
  # Aalto et al.
  # DOS-TEM
  # GIPL
  # Pastick
#2. For each dataset, it:
  # Reads the data
  # Projects to Alaska Albers projection
  # Resamples to 1000m resolution
  # Creates binary rasters for different depth thresholds (e.g., 1m, 1-2m, 2m)
#3. Combines all processed datasets into a single raster stack called "baseline_binaries"
#4. Writes the final raster stack to a cache file for later use
source(ifelse(.CacheUse == TRUE,"A05a_read_in_PF_baseline_data-CACHE.R","A05b_read_in_PF_baseline_data.R")) #takes ~ 2 min without Cache, < 1min w/ cache

#A06_preprocess_STATSGO-gNATSGO_tabular_data.R:
#1. Processes STATSGO (State Soil Geographic) tabular data:
  # Subsets the component table to relevant fields
  # Removes miscellaneous area components
  # Fixes a specific data entry error in the STATSGO tabular data
  # Writes the processed data to a CSV file
#2. Processes gNATSGO (Gridded National Soil Survey Geographic) tabular data:
  # Subsets the component table to relevant fields
  # Removes miscellaneous area components
  # Writes the processed data to a CSV file
source("A06_preprocess_STATSGO-gNATSGO_tabular_data.R") #takes < 1min

#A07_generate_STATSGO_spatial_data.R:
#1. Generates mu proportion rasters for Gelisols and Gelisol suborders
#2. Masks the raster to the soil domain defined by Pastick data
#3. Plots each raster:
  # Uses different color palettes for each soil taxa
  # Overlays Land Resource Region (LRR) boundaries
  # Removes areas with zero proportional area from the visualization
#4. Combines all generated rasters into a single stack called "STATSGO_order_suborder"
source("A07_generate_STATSGO_spatial_data.R") #takes < 1min

#A08_generate_gNATSGO_spatial_data.R:
#1. Generates mu proportion rasters for Gelisols and Gelisol suborders
#2. Masks the raster to the soil domain defined by Pastick data
#3. Plots each raster:
# Uses different color palettes for each soil taxa
# Overlays Land Resource Region (LRR) boundaries
# Removes areas with zero proportional area from the visualization
#4. Combines all generated rasters into a single stack called "gNATSGO_order_suborder"
source("A08_generate_gNATSGO_spatial_data.R") #takes < 1min

#A09_load_pastick_scenarios.R:
#1. Loads and processes Pastick near-surface permafrost (NSP) probability rasters for three climate scenarios (B1, A1B, A2) and two time periods (2050, 2090):
  # Projects rasters to Alaska Albers projection
  # Resamples to 1000m resolution
  # Converts probabilities to binary (1 if ≥50% probability, 0 otherwise)
  # Masks to soil areas
#2. Combines all processed rasters into a single stack called "pastick_scen"
source(ifelse(.CacheUse == TRUE, "A09a_load_pastick_scenarios-CACHE.R","A09b_load_pastick_scenarios.R")) #takes ~ 1hr without cache, < 1min with cache

#A10_load_gipl_scenarios.R:
#1. Loads and processes GIPL A1B scenario rasters for two time periods (2050-2059 and 2090-2099) and two depth thresholds (1m and 2m):
  # Projects rasters to Alaska Albers projection
  # Resamples to 1000m resolution
  # Converts active layer thickness to binary (1 if within threshold, 0 otherwise)
  # Masks to soil areas
#2. Combines all processed rasters into a single stack called "GIPL_scen"
source("A10_load_gipl_scenarios.R") #takes ~1 min

#A11_load_aalto_scenarios.R:
#1. Loads and processes Aalto et al. rasters for three climate scenarios (RCP 2.6, 4.5, and 8.5), two time periods (2050 and 2070), and two depth thresholds (1m and 2m):
  # Crops to Alaska
  # Projects to Alaska Albers projection
  # Resamples to 1000m resolution
  # Converts active layer thickness to binary (1 if within threshold, 0 otherwise)
  # Masks to soil areas
#2. Combines all processed rasters (12 in total) into a single stack called "aalto_scen"
source(ifelse(.CacheUse == TRUE, "A11a_load_aalto_scenarios-CACHE.R","A11b_load_aalto_scenarios.R"))  #takes ~ 5min without cache, < 1min with cache

#A12_generate_all_scenarios.R:
#1. Defines a function generate.taxon.scenarios that:
  # Takes a raster stack, a soil taxon, and a scenario name as inputs
  # Generates new raster layers by multiplying each input layer with the corresponding soil taxon raster
  # Combines these new layers into a stack and saves it to a cache file
#2. Uses this function to generate scenario rasters for four soil taxa (orthel, histel, turbel, gelisol) across multiple climate scenarios:
  # Baseline scenarios
  # Pastick scenarios (B1, A1B, A2 for 2050-59 and 2090-99)
  # GIPL scenarios (A1B for 2050-59 and 2090-99)
  # Aalto et al. scenarios (RCP 2.6, 4.5, 8.5 for 2050 and 2070)
#3. Loads the generated scenario rasters from cache files
source(ifelse(.CacheUse == TRUE, "A12a_generate_all_scenarios-CACHE.R", "A12b_generate_all_scenarios.R"))  #takes ~ 10min without cache, < 1min with Cache. Note that these scenario stacks (16 in all) amount to ~ 4.6Gb of data.

#---------- Make Tables ----------

#A13_make_table_function_lrr.R:
#1. Defines two functions: generate.custom.table.lrr and generate.custom.table.commas.lrr. These functions are nearly identical, with the main difference being how numbers are formatted (with or without commas).
#2. Both functions take three arguments:
  # lyr_list: A list of raster layers to summarize
  # name_list: A list of names for each layer
  # table_name: The name for the output CSV file
#3. The functions perform the following steps for each input raster layer:
  # Calculate the sum of values within each LRR
  # Convert the sum to square kilometers
  # Format the numbers (with or without commas)
  # Add the results to a growing data frame
#3. Create an HTML table for output using the htmlTable package, with LRR names as row names
source("A13_make_table_function_lrr.R")  #takes < 1min

#A14_make_lrr_general_stats_table.R:
#1. Generates multiple tables using the previously defined functions generate.custom.table.lrr and generate.custom.table.commas.lrr. These tables include:
  # Basic LRR statistics (total area, domain area, water area, etc.)
  # Baseline near-surface permafrost (NSP) scenarios
  # Baseline Gelisol, Turbel, Histel, and Orthel scenarios
  # Pastick scenarios for Gelisols, Turbels, Histels, and Orthels
  # GIPL scenarios for Gelisols, Turbels, Histels, and Orthels
  # Aalto scenarios for Gelisols, Turbels, Histels, and Orthels
#2. The tables are saved in CSV format, with versions both with and without commas in the numbers for better readability.
#3. The code uses various pre-processed raster datasets (e.g., baseline_gelisol, pastick_scen_gelisol, gipl_scen_gelisol, etc.) to create these tables.
source("A14_make_lrr_general_stats_tables.R")  #takes < 1min

#---------- Make Figures ----------

#Figure 3 F03_STATSGO_Gelisol_Order_Suborder.R
source("F03_STATSGO_Gelisol_Order_Suborder.R") #takes < 1min

#Figure 4 F04_NSP_probability_concurrence.R
source("F04_NSP_probability_concurrence.R") #takes < 5min

#Figure 5 F05-dumbbell-plots-by-LRR.R
source("F05-dumbbell-plots-by-LRR.R") #takes < 2min

#Figure 6 F06_gelisol_scenarios.R 
source("F06_gelisol_scenarios.R") #takes < 5min

#Figure 7 F07_histel_scenarios.R 
source("F07_histel_scenarios.R") #takes < 5min

#Figure 8 F08_orthel_scenarios.R 
source("F08_orthel_scenarios.R") #takes < 5min

#Figure 9 F09_turbel_scenarios.R 
source("F09_turbel_scenarios.R") #takes < 5min

# Figure S1 FS1_baseline_figures.R
source("FS1_baseline_figures.R") #takes < 1min

# Figures S2-S4 FS2-4_emissions_scenario_figures.R
source("FS2-4_emissions_scenario_figures.R") #takes < 1min

# Figures S6 FS6_domain_masks.R
source("FS6_domain_masks.R") #takes < 1min

# Figures S8-S28 FS8-FS28_survey_area_comparisons.R
source("FS8-FS28_survey_area_comparisons.R") #takes < 5min