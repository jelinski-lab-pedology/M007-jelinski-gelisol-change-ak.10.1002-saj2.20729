# M007-jelinski-gelisol-classification-change
This repository is adapted from jelinski lab project repos which follows our lab-specific open science guide procedures [https://jelinski-lab-pedology.github.io/open-science-guidebook/]. 

## Repo directory and subdirectory structure
-   ./M007-jelinski-gelisol-classification-change
    - 00A_master_script_raw_data.R
	- 00B_master_script_execute_cache.R
    -   /01-data
        -  this is currently empty; see below
    -   /02-output
        -   /a-figures
        -   /b-tables
	-   /06-cache
	- A00_prep_workspace.R
	- A01a_process-baseline-geospatial-data-CACHE.R
	- A01b_process-baseline-geospatial-data.R
	- A02_MLRA-LRR_readin_overlays.R
	- A03_MakePastickMasks.R
	- A04_crop-MLRA-LRR-soil-domain-figure-overlay.R
	- A05a_read_in_PF_baseline_data-CACHE.R
	- A05b_read_in_PF_baseline_data.R
	- A06_preprocess_STATSGO-gNATSGO_tabular_data.R
	- A07_generate_STATSGO_spatial_data.R
	- A08_generate_gNATSGO_spatial_data.R
	- A09a_load_pastick_scenarios-CACHE.R
	- A09b_load_pastick_scenarios.R
	- A10_load_gipl_scenarios.R
	- A11a_load_aalto_scenarios-CACHE.R
	- A11b_load_aalto_scenarios.R
	- A12a_generate_all_scenarios-CACHE.R
	- A12b_generate_all_scenarios.R
	- A13_make_table_function_lrr.R
	- A14_make_lrr_general_stats_tables.R
	- B00_prep_workspace.R
	- B01_load_data_from_cache-CACHE.R
	- B02_load_pastick_scenarios-CACHE.R
	- B03_load_gipl_scenarios-CACHE.R
	- B04_load_aalto_scenarios-CACHE.R
	- B05_generate_all_scenarios-CACHE.R
	- B06_make_table_function_lrr.R
	- B07_make_lrr_general_stats_tables.R
	- F03_STATSGO_Gelisol_Order_Suborder.R
	- F04_NSP_probability_concurrence.R
	- F05-dumbbell-plots-by-LRR.R
	- F06_gelisol_scenarios.R
	- F07_histel_scenarios.R
	- F08_orthel_scenarios.R
	- F09_turbel_scenarios.R
	- FS1_baseline_figures.R
	- FS2-4_emissions_scenario_figures.R
	- FS6_domain_masks.R
	- FS8-28_survey_area_comparisons.R
    -   \[LICENSE]
    -   \[M007-jelinski-gelisol-classification-change.Rproj\]
    -   \[README.md\]

NOTE on scripts: There are two series of scripts (Series A and Series B) in this repository that each produce the same output figures and tables. Users should run either series A or series B. This can be accomplished by use of the master scripts "00A_master_script_raw_data.R" or "00B_master_script_execute_cache.R". Series A "00A_master_script_raw_data.R" is for running all steps starting with raw data sources (see below). Raw data sources are not made available as part of this release due to copyright and data ownership. Those interested in running this portion of the code will need to obtain the raw data from the original sources and/or authors as necessary. Series B "00B_master_script_execute_cache.R" is for running all steps starting with processed data products (derived from original data sources). These processed data products are derived from the raw data products produced in the "A" series scripts (described in 00A_master_script_raw_data), distributed with this package as .zip files, and extracted into the cache. Raw data sources are not made available as part of this release due to copyright and data ownership. Derived products are distributed as part of this release as a series of .zip files:
- "./aalto.zip"
- "./baseline.zip"
- "./gipl.zip"
- "./lrr_mlra.zip"
- "./pastick.zip"
- "./stat_gnat.zip"
- "./yi_and_misc.zip"
All of these must be unzipped (last step in B00_prep_workspace) before running the rest of the B series scripts. THEREFORE, nearly all users will utilize the B series scripts, unless they have obtained the necessary raw data sources.

### /01-data

Raw data sources are not made available as part of this release due to copyright and data ownership. Those interested in running this portion of the code will need to obtain the raw data from the original sources and/or authors as necessary. If you have acquired the raw data sources, they should be placed in this "01-data" folder (currently empty in this release) as follows: 

- MLRA and LRR Boundaries:
	-  https://www.nrcs.usda.gov/resources/data-and-reports/major-land-resource-area-mlra [October 2022 release].
	- named folder in code: "./01-data/2022 MLRA Boundaries from NRCS_52_2022"

- AK Soil Data Availability
	- obtained from Alaska-NRCS State GIS Coordinator [October 2022 release]
	- named folder in code: "./01-data/2022_SoilDataAvailabilityShapefile"

- Alaska coastline, 250,000 scale
	- https://gis.data.alaska.gov/datasets/SOA-DNR::alaska-coastline/about?layer=2 [obtained 04OCT2022] IN https://gis.data.alaska.gov/maps/SOA-DNR::alaska-coastline/about
	- named folder in code: "./01-data/AK_COASTLINE_250000

- Aalto et al. 2018. Northern Circumpoplar ALT Rasters 
	- from publication: https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2018GL078007 
	- Dryad data repository: https://datadryad.org/stash/dataset/doi:10.5061/dryad.886pr72 
	- named folder in code: "./01-data/doi_10.5061_dryad.886pr72__v1"

- DOS-TEM binary near-surface permafrost 
	- from publication: Wylie, B.K., Pastick, N.J., Johnson, K.D., Bliss, N., and H. Genet. 2016. "Chapter 3. Soil Carbon and Permafrost Estimates and Susceptibility to Climate Change in Alaska. In Baseline and Projected Future Carbon Storage and Greenhouse-Gas Fluxes in Ecosystems of Alaska, 196. USGS Professional Paper 1826. United States Geological Survey. https://pubs.usgs.gov/pp/1826/pp1826_chapter3.pdf; model described in: Genet, Hélène, Yujie He, A David McGuire, Qianlai Zhuang, Yujin Zhang, Frances E Biles, David V D’Amore, Xiaoping Zhou, and Kristopher D Johnson. 2016. “Chapter 6. Terrestrial Carbon Modeling: Baseline and Projections in Upland Ecosystems.” In Baseline and Projected Future Carbon Storage and Greenhouse-Gas Fluxes in Ecosystems of Alaska, 196. USGS Professional Paper 1826. United States Geological Survey. https://pubs.usgs.gov/pp/1826/pp1826_chapter6.pdf.
	- must obtain from authors of the above articles
	- named folder in code: "./01-data/DOS-TEM"

- GIPL model ALT under A1B scenario
	- from publications: Wylie, B.K., Pastick, N.J., Johnson, K.D., Bliss, N., and H. Genet. 2016. "Chapter 3. Soil Carbon and Permafrost Estimates and Susceptibility to Climate Change in Alaska. In Baseline and Projected Future Carbon Storage and Greenhouse-Gas Fluxes in Ecosystems of Alaska, 196. USGS Professional Paper 1826. United States Geological Survey. https://pubs.usgs.gov/pp/1826/pp1826_chapter3.pdf; original from Jafarov, E. E., S. S. Marchenko, and V. E. Romanovsky. 2012. “Numerical Modeling of Permafrost Dynamics in Alaska Using a High Spatial Resolution Dataset.” The Cryosphere 6 (3): 613–24. https://doi.org/10.5194/tc-6-613-2012.
	- must obtain from authors of the above articles
	- named folder in code: "./01-data/GIPL_ALT"

- Pastick et al. 2015. Near-surface permafrost probabilities
	- from publication: Pastick, Neal J., M. Torre Jorgenson, Bruce K. Wylie, Shawn J. Nield, Kristofer D. Johnson, and Andrew O. Finley. 2015. “Distribution of Near-Surface Permafrost in Alaska: Estimates of Present and Future Conditions.” Remote Sensing of Environment 168 (October): 301–15. https://doi.org/10.1016/j.rse.2015.07.019.
	- must obtain from authors of above article
	- named folder in code: "./01-data/Pastick_NSP

- Yi and Kimball 2020. ALT Estimates from Remote Sensing (ABoVE)
	- from publication: Yi, Y., and J. S. Kimball. 2020. “Arctic-Boreal Vulnerability Experiment (ABoVE)ABoVE: Active Layer Thickness from Remote Sensing Permafrost Model, Alaska, 2001-2015,” 36.766169 MB. https://doi.org/10.3334/ORNLDAAC/1760.
	- named folder in code: "./01-data/Sat_ActiveLayer_Thickness_Maps_1760"

- gNATSGO
	- from USDA-NRCS: https://www.nrcs.usda.gov/resources/data-and-reports/gridded-national-soil-survey-geographic-database-gnatsgo [OCT 2022 Release]
	- named folder in code: "./01-data/gNATSGO_AK_OCT_2022"

- STATSGO2
	- from USDA-NRCS: https://www.nrcs.usda.gov/resources/data-and-reports/description-of-statsgo2-database [2016 release (most recent for just AK statewide STATSGO)]
	- named folder in code: "./01-data/STATSGO2_AK_2016" 

### /02-output
This folder contains figures and tables or other products that are in the manuscript. Any figures and tables in /02-output are generated from code and source data. 

#### /02-output/a-figures
Figures generated from workflow in R

#### /02-output/b-tables
Tables generated from workflow in R

### /06-cache

These processed data products are derived from the raw data products in the "A" series scripts (described in 00A_master_script_raw_data). Raw data sources are not made available as part of this release due to copyright and data ownership. Derived products are distributed as part of this release as a series of .zip files:
- "./aalto.zip"
- "./baseline.zip"
- "./gipl.zip"
- "./lrr_mlra.zip"
- "./pastick.zip"
- "./stat_gnat.zip"
- "./yi_and_misc.zip"
# All of these must be unzipped (last step in B00_prep_workspace) and extracted to ./06-cache before running the rest of the B series scripts.

### LICENSE
This is a standard open source license shipped with this template. I am choosing to use the MIT license currently, but this may not be the best choice[^1][^2].

### M007-jelinski-gelisol-classification-change.Rproj
The .Rproj file contained in this repository is pre-configured to start with a *completely clean workspace EVERY TIME* by selecting in *Project Options > General* "Restore .RData into workspace at startup" = NO and "Save workspace to .RData on exit" = NO, "Disable .Pprofile execution on session start/resume" = CHECKED, "Quit child processes on exit" = CHECKED. These two options combined will also ensure that others running this code (or even you at a later date) don't experience errors or conflictions due to workspace-specific background[^3].

### README.md

This file.

[^1]: [GitHub Docs::Licensing a Repository](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository)
[^2]: [choosealicense.com::Choose an Open Source License](https://choosealicense.com)
[^3]: [Alex Douglas::Setting up a reproducible project in R](https://alexd106.github.io/intro2R/project_setup.html)
