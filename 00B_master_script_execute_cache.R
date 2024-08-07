#---------- This master script executes all modules in sequence. NOTE: this master script (00B_master_script_execute_cache) is for running all steps starting with processed data products (derived from original data sources). These processed data products are derived from the raw data products in the "A" series scripts (described in 00A_master_script_raw_data). Raw data sources are not made available as part of this release due to copyright and data ownership. Derived products are distributed as part of this release as a series of .zip files:-----------
# "./aalto.zip"
# "./baseline.zip"
# "./gipl.zip"
# "./lrr_mlra.zip"
# "./pastick.zip"
# "./stat_gnat.zip"
# "./yi_and_misc.zip"
# All of these must be unzipped (last step in B00_prep_workspace) before running the rest of the scripts. 

#---------- Dataset preparation and loading ----------

#B00_prep_workspace.R:
#1. Loads required packages
#2. Sets global objects, like for example standard projection, etc
#3. Writes custom functions
#4. Set .CacheUse to "yes" to use cached datasets rather than reprocess all - will save significant time. If you would like to generate from raw data sources, then set .CacheUse to "no".
#5. Unzips files to cache
source("B00_prep_workspace.R") #takes < 1min

#B01_load_data_from_cache-CACHE.R:
#1. Loads processed data
source("B01_load_data_from_cache-CACHE.R") # takes ~ 1min

#B02_load_pastick_scenarios.R:
#1. Loads and processes Pastick near-surface permafrost (NSP) probability rasters for three climate scenarios (B1, A1B, A2) and two time periods (2050, 2090)
#2. Combines all processed rasters into a single stack called "pastick_scen"
source("B02_load_pastick_scenarios-CACHE.R") #takes < 1min with cache

#B03_load_gipl_scenarios.R:
#1. Loads and processes GIPL A1B scenario rasters for two time periods (2050-2059 and 2090-2099) and two depth thresholds (1m and 2m)
#2. Combines all processed rasters into a single stack called "GIPL_scen"
source("B03_load_gipl_scenarios-CACHE.R") #takes ~1 min

#B04_load_aalto_scenarios.R:
#1. Loads and processes Aalto et al. rasters for three climate scenarios (RCP 2.6, 4.5, and 8.5), two time periods (2050 and 2070), and two depth thresholds (1m and 2m)
#2. Combines all processed rasters (12 in total) into a single stack called "aalto_scen"
source("B04_load_aalto_scenarios-CACHE.R")  #takes ~ 5min without cache, < 1min with cache

#B05_generate_all_scenarios.R:
#1. Loads generated scenario rasters for four soil taxa (orthel, histel, turbel, gelisol) across multiple climate scenarios from cache files
source("B05_generate_all_scenarios-CACHE.R")  #takes ~ 10min without cache, < 1min with Cache. Note that these scenario stacks (16 in all) amount to ~ 4.6Gb of data.

#---------- Make Tables ----------

#B06_make_table_function_lrr.R:
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
source("B06_make_table_function_lrr.R")  #takes < 1min

#B07_make_lrr_general_stats_table.R:
#1. Generates multiple tables using the previously defined functions generate.custom.table.lrr and generate.custom.table.commas.lrr. These tables include:
  # Basic LRR statistics (total area, domain area, water area, etc.)
  # Baseline near-surface permafrost (NSP) scenarios
  # Baseline Gelisol, Turbel, Histel, and Orthel scenarios
  # Pastick scenarios for Gelisols, Turbels, Histels, and Orthels
  # GIPL scenarios for Gelisols, Turbels, Histels, and Orthels
  # Aalto scenarios for Gelisols, Turbels, Histels, and Orthels
#2. The tables are saved in CSV format, with versions both with and without commas in the numbers for better readability.
#3. The code uses various pre-processed raster datasets (e.g., baseline_gelisol, pastick_scen_gelisol, gipl_scen_gelisol, etc.) to create these tables.
source("B07_make_lrr_general_stats_tables.R")  #takes < 1min

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