#----------Make Basic LRR Stats Table----------------
# Prep: Make normal LRR raster(which encodes LRR numbers in each cell) binary by dividing by itself.
lrr_rast_binary = lrr_rast/lrr_rast
names(lrr_rast_binary) = "Binary_Presence"
plot(lrr_rast_binary, col = "black")

# Prep: Make binary presence absence raster for anywhere Gelisols were mapped in STATSGO (even if just 1% of the comp_r).
stat_rast_gelisol_binall = stat_rast_gelisol %>%
  terra::clamp(lower=0.01,upper=1.0, values=FALSE) %>%
  .GreaterEqualZero()

# Make LRR Basic Stats Table

basic_lyr_list = c(lrr_rast_binary, rast_domain, rast_water, rast_rockiceurban, rast_soil, stat_rast_gelisol)
basic_name_list = c("Total LRR Area", "Total Domain Area", "Total Water Area", "Total Rock/Ice/Urban Area", "Total Soil Area", "STATSGO Binary Gelisol Area")
table_name = "./02-output/b-tables/basic_lrr_table.csv"

generate.custom.table.lrr(lyr_list = basic_lyr_list, name_list = basic_name_list, table_name = "./02-output/b-tables/basic_lrr_table.csv.csv")
generate.custom.table.commas.lrr(lyr_list = basic_lyr_list, name_list = basic_name_list, table_name = "./02-output/b-tables/basic_lrr_table.csv")

#----------Make Baseline NSP Scenarios LRR Stats Table----------------
baseline_nsp_lyr_list = c(stat_rast_gelisol, baseline_binaries$yi_2m_bin, baseline_binaries$aalto_2m_bin, baseline_binaries$dostem_base_bin, baseline_binaries$GIPL00_2m_bin, baseline_binaries$past00_1m_bin, stat_rast_gelisol_binall)
baseline_nsp_name_list = c("STATSGO", "Yi et al", "Aalto et al", "DOS-TEM", "GIPL", "Pastick", "STATSGO Binary All")
table_name = "./02-output/b-tables/baseline_nsp_lrr_table.csv"

generate.custom.table.lrr(lyr_list = baseline_nsp_lyr_list, name_list = baseline_nsp_name_list, table_name = "./02-output/b-tables/baseline_nsp_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = baseline_nsp_lyr_list, name_list = baseline_nsp_name_list, table_name = "./02-output/b-tables/baseline_nsp_lrr_table_commas.csv")

#----------Make Baseline Gelisol Scenarios LRR Stats Table----------
baseline_lyr_list = c(stat_rast_gelisol, gnat_rast_gelisol, baseline_gelisol$yi_2m_bin, baseline_gelisol$aalto_2m_bin, baseline_gelisol$dostem_base_bin, baseline_gelisol$GIPL00_2m_bin, baseline_gelisol$past00_1m_bin)
baseline_name_list = c("STATSGO", "gNATSGO", "Yi et al", "Aalto et al", "DOS-TEM", "GIPL", "Pastick")
table_name = "./02-output/b-tables/baseline_lrr_table.csv"

generate.custom.table.lrr(lyr_list = baseline_lyr_list, name_list = baseline_name_list, table_name = "./02-output/b-tables/baseline_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = baseline_lyr_list, name_list = baseline_name_list, table_name = "./02-output/b-tables/baseline_lrr_table_commas.csv")

#----------Make Baseline Turbel Scenarios LRR Stats Table----------
baseline_turbel_lyr_list = c(stat_rast_turbel, gnat_rast_turbel, baseline_turbel$yi_2m_bin, baseline_turbel$aalto_2m_bin, baseline_turbel$dostem_base_bin, baseline_turbel$GIPL00_2m_bin, baseline_turbel$past00_1m_bin)
baseline_turbel_name_list = c("STATSGO", "gNATSGO", "Yi et al", "Aalto et al", "DOS-TEM", "GIPL", "Pastick")
table_name = "./02-output/b-tables/baseline_turbel_lrr_table.csv"

generate.custom.table.lrr(lyr_list = baseline_turbel_lyr_list, name_list = baseline_turbel_name_list, table_name = "./02-output/b-tables/baseline_turbel_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = baseline_turbel_lyr_list, name_list = baseline_turbel_name_list, table_name = "./02-output/b-tables/baseline_turbel_lrr_table_commas.csv")

#----------Make Baseline Histel Scenarios LRR Stats Table----------
baseline_histel_lyr_list = c(stat_rast_histel, gnat_rast_histel, baseline_histel$yi_2m_bin, baseline_histel$aalto_2m_bin, baseline_histel$dostem_base_bin, baseline_histel$GIPL00_2m_bin, baseline_histel$past00_1m_bin)
baseline_histel_name_list = c("STATSGO", "gNATSGO", "Yi et al", "Aalto et al", "DOS-TEM", "GIPL", "Pastick")
table_name = "./02-output/b-tables/baseline_histel_lrr_table.csv"

generate.custom.table.lrr(lyr_list = baseline_histel_lyr_list, name_list = baseline_histel_name_list, table_name = "./02-output/b-tables/baseline_histel_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = baseline_histel_lyr_list, name_list = baseline_histel_name_list, table_name = "./02-output/b-tables/baseline_histel_lrr_table_commas.csv")

#----------Make Baseline Orthel Scenarios LRR Stats Table----------
baseline_orthel_lyr_list = c(stat_rast_orthel, gnat_rast_orthel, baseline_orthel$yi_2m_bin, baseline_orthel$aalto_2m_bin, baseline_orthel$dostem_base_bin, baseline_orthel$GIPL00_2m_bin, baseline_orthel$past00_1m_bin)
baseline_orthel_name_list = c("STATSGO", "gNATSGO", "Yi et al", "Aalto et al", "DOS-TEM", "GIPL", "Pastick")
table_name = "./02-output/b-tables/baseline_orthel_lrr_table.csv"

generate.custom.table.lrr(lyr_list = baseline_orthel_lyr_list, name_list = baseline_orthel_name_list, table_name = "./02-output/b-tables/baseline_orthel_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = baseline_orthel_lyr_list, name_list = baseline_orthel_name_list, table_name = "./02-output/b-tables/baseline_orthel_lrr_table_commas.csv")

#----------Make Pastick Gelisol Scenarios LRR Stats Table----------
pastick_gelisol_scenarios_lyr_list = c(baseline_gelisol$past00_1m_bin, pastick_scen_gelisol$past50_B1_1m_bin,pastick_scen_gelisol$past90_B1_1m_bin, pastick_scen_gelisol$past50_A1B_1m_bin, pastick_scen_gelisol$past90_A1B_1m_bin, pastick_scen_gelisol$past50_A2_1m_bin,pastick_scen_gelisol$past90_A2_1m_bin)
pastick_gelisol_scenarios_name_list = c("Pastick - Baseline", "Past 50 B1", "Past 90 B1", "Past 50 A1B", "Past 90 A1B", "Past 50 A2", "Past 90 A2")
table_name = "./02-output/b-tables/pastick_gelisol_scenarios_lrr_table.csv"

generate.custom.table.lrr(lyr_list = pastick_gelisol_scenarios_lyr_list, name_list = pastick_gelisol_scenarios_name_list, table_name = "./02-output/b-tables/pastick_gelisol_scenarios_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = pastick_gelisol_scenarios_lyr_list, name_list = pastick_gelisol_scenarios_name_list, table_name = "./02-output/b-tables/pastick_gelisol_scenarios_lrr_table_commas.csv")

#----------Make GIPL Gelisol Scenarios LRR Stats Table----------
gipl_gelisol_scenarios_lyr_list = c(baseline_gelisol$GIPL00_2m_bin, gipl_scen_gelisol$GIPL50_A1B_2m_bin,gipl_scen_gelisol$GIPL90_A1B_2m_bin)
gipl_gelisol_scenarios_name_list = c("GIPL - Baseline", "GIPL 50 A1B", "GIPL 90 A1B")
table_name = "./02-output/b-tables/gipl_gelisol_scenarios_lrr_table.csv"

generate.custom.table.lrr(lyr_list = gipl_gelisol_scenarios_lyr_list, name_list = gipl_gelisol_scenarios_name_list, table_name = "./02-output/b-tables/gipl_gelisol_scenarios_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = gipl_gelisol_scenarios_lyr_list, name_list = gipl_gelisol_scenarios_name_list, table_name = "./02-output/b-tables/gipl_gelisol_scenarios_lrr_table_commas.csv")

#----------Make Aalto Gelisol Scenarios LRR Stats Table----------
aalto_gelisol_scenarios_lyr_list = c(baseline_gelisol$aalto_2m_bin, aalto_scen_gelisol$aalto50_RCP45_2m_bin,aalto_scen_gelisol$aalto70_RCP45_2m_bin, aalto_scen_gelisol$aalto50_RCP85_2m_bin, aalto_scen_gelisol$aalto70_RCP85_2m_bin)
aalto_gelisol_scenarios_name_list = c("Aalto - Baseline", "Aalto 50 RCP4.5", "Aalto 70 RCP4.5", "Aalto 50 RCP8.5", "Aalto 70 RCP8.5")
table_name = "./02-output/b-tables/aalto_gelisol_scenarios_lrr_table.csv"

generate.custom.table.lrr(lyr_list = aalto_gelisol_scenarios_lyr_list, name_list = aalto_gelisol_scenarios_name_list, table_name = "./02-output/b-tables/aalto_gelisol_scenarios_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = aalto_gelisol_scenarios_lyr_list, name_list = aalto_gelisol_scenarios_name_list, table_name = "./02-output/b-tables/aalto_gelisol_scenarios_lrr_table_commas.csv")

#----------Make Pastick Turbel Scenarios LRR Stats Table----------
pastick_turbel_scenarios_lyr_list = c(baseline_turbel$past00_1m_bin, pastick_scen_turbel$past50_B1_1m_bin,pastick_scen_turbel$past90_B1_1m_bin, pastick_scen_turbel$past50_A1B_1m_bin, pastick_scen_turbel$past90_A1B_1m_bin, pastick_scen_turbel$past50_A2_1m_bin,pastick_scen_turbel$past90_A2_1m_bin)
pastick_turbel_scenarios_name_list = c("Pastick - Baseline", "Past 50 B1", "Past 90 B1", "Past 50 A1B", "Past 90 A1B", "Past 50 A2", "Past 90 A2")
table_name = "./02-output/b-tables/pastick_turbel_scenarios_lrr_table.csv"

generate.custom.table.lrr(lyr_list = pastick_turbel_scenarios_lyr_list, name_list = pastick_turbel_scenarios_name_list, table_name = "./02-output/b-tables/pastick_turbel_scenarios_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = pastick_turbel_scenarios_lyr_list, name_list = pastick_turbel_scenarios_name_list, table_name = "./02-output/b-tables/pastick_turbel_scenarios_lrr_table_commas.csv")

#----------Make GIPL Turbel Scenarios LRR Stats Table----------
gipl_turbel_scenarios_lyr_list = c(baseline_turbel$GIPL00_2m_bin, gipl_scen_turbel$GIPL50_A1B_2m_bin,gipl_scen_turbel$GIPL90_A1B_2m_bin)
gipl_turbel_scenarios_name_list = c("GIPL - Baseline", "GIPL 50 A1B", "GIPL 90 A1B")
table_name = "./02-output/b-tables/gipl_turbel_scenarios_lrr_table.csv"

generate.custom.table.lrr(lyr_list = gipl_turbel_scenarios_lyr_list, name_list = gipl_turbel_scenarios_name_list, table_name = "./02-output/b-tables/gipl_turbel_scenarios_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = gipl_turbel_scenarios_lyr_list, name_list = gipl_turbel_scenarios_name_list, table_name = "./02-output/b-tables/gipl_turbel_scenarios_lrr_table_commas.csv")

#----------Make Aalto Turbel Scenarios LRR Stats Table----------
aalto_turbel_scenarios_lyr_list = c(baseline_turbel$past00_1m_bin, aalto_scen_turbel$aalto50_RCP45_2m_bin,aalto_scen_turbel$aalto70_RCP45_2m_bin, aalto_scen_turbel$aalto50_RCP85_2m_bin, aalto_scen_turbel$aalto70_RCP85_2m_bin)
aalto_turbel_scenarios_name_list = c("Aalto - Baseline", "Aalto 50 RCP4.5", "Aalto 70 RCP4.5", "Aalto 50 RCP8.5", "Aalto 70 RCP8.5")
table_name = "./02-output/b-tables/aalto_turbel_scenarios_lrr_table.csv"

generate.custom.table.lrr(lyr_list = aalto_turbel_scenarios_lyr_list, name_list = aalto_turbel_scenarios_name_list, table_name = "./02-output/b-tables/aalto_turbel_scenarios_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = aalto_turbel_scenarios_lyr_list, name_list = aalto_turbel_scenarios_name_list, table_name = "./02-output/b-tables/aalto_turbel_scenarios_lrr_table_commas.csv")

#----------Make Pastick Histel Scenarios LRR Stats Table----------
pastick_histel_scenarios_lyr_list = c(baseline_histel$past00_1m_bin, pastick_scen_histel$past50_B1_1m_bin,pastick_scen_histel$past90_B1_1m_bin, pastick_scen_histel$past50_A1B_1m_bin, pastick_scen_histel$past90_A1B_1m_bin, pastick_scen_histel$past50_A2_1m_bin,pastick_scen_histel$past90_A2_1m_bin)
pastick_histel_scenarios_name_list = c("Pastick - Baseline", "Past 50 B1", "Past 90 B1", "Past 50 A1B", "Past 90 A1B", "Past 50 A2", "Past 90 A2")
table_name = "./02-output/b-tables/pastick_histel_scenarios_lrr_table.csv"

generate.custom.table.lrr(lyr_list = pastick_histel_scenarios_lyr_list, name_list = pastick_histel_scenarios_name_list, table_name = "./02-output/b-tables/pastick_histel_scenarios_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = pastick_histel_scenarios_lyr_list, name_list = pastick_histel_scenarios_name_list, table_name = "./02-output/b-tables/pastick_histel_scenarios_lrr_table.csv")

#----------Make GIPL Histel Scenarios LRR Stats Table----------
gipl_histel_scenarios_lyr_list = c(baseline_histel$GIPL00_2m_bin, gipl_scen_histel$GIPL50_A1B_2m_bin,gipl_scen_histel$GIPL90_A1B_2m_bin)
gipl_histel_scenarios_name_list = c("GIPL - Baseline", "GIPL 50 A1B", "GIPL 90 A1B")
table_name = "./02-output/b-tables/gipl_histel_scenarios_lrr_table.csv"

generate.custom.table.lrr(lyr_list = gipl_histel_scenarios_lyr_list, name_list = gipl_histel_scenarios_name_list, table_name = "./02-output/b-tables/gipl_histel_scenarios_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = gipl_histel_scenarios_lyr_list, name_list = gipl_histel_scenarios_name_list, table_name = "./02-output/b-tables/gipl_histel_scenarios_lrr_table_commas.csv")

#----------Make Aalto Histel Scenarios LRR Stats Table----------
aalto_histel_scenarios_lyr_list = c(baseline_histel$past00_1m_bin, aalto_scen_histel$aalto50_RCP45_2m_bin,aalto_scen_histel$aalto70_RCP45_2m_bin, aalto_scen_histel$aalto50_RCP85_2m_bin, aalto_scen_histel$aalto70_RCP85_2m_bin)
aalto_histel_scenarios_name_list = c("Aalto - Baseline", "Aalto 50 RCP4.5", "Aalto 70 RCP4.5", "Aalto 50 RCP8.5", "Aalto 70 RCP8.5")
table_name = "./02-output/b-tables/aalto_histel_scenarios_lrr_table.csv"

generate.custom.table.lrr(lyr_list = aalto_histel_scenarios_lyr_list, name_list = aalto_histel_scenarios_name_list, table_name = "./02-output/b-tables/aalto_histel_scenarios_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = aalto_histel_scenarios_lyr_list, name_list = aalto_histel_scenarios_name_list, table_name = "./02-output/b-tables/aalto_histel_scenarios_lrr_table_commas.csv")

#----------Make Pastick Orthel Scenarios LRR Stats Table----------
pastick_orthel_scenarios_lyr_list = c(baseline_orthel$past00_1m_bin, pastick_scen_orthel$past50_B1_1m_bin,pastick_scen_orthel$past90_B1_1m_bin, pastick_scen_orthel$past50_A1B_1m_bin, pastick_scen_orthel$past90_A1B_1m_bin, pastick_scen_orthel$past50_A2_1m_bin,pastick_scen_orthel$past90_A2_1m_bin)
pastick_orthel_scenarios_name_list = c("Pastick - Baseline", "Past 50 B1", "Past 90 B1", "Past 50 A1B", "Past 90 A1B", "Past 50 A2", "Past 90 A2")
table_name = "./02-output/b-tables/pastick_orthel_scenarios_lrr_table.csv"

generate.custom.table.lrr(lyr_list = pastick_orthel_scenarios_lyr_list, name_list = pastick_orthel_scenarios_name_list, table_name = "./02-output/b-tables/pastick_orthel_scenarios_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = pastick_orthel_scenarios_lyr_list, name_list = pastick_orthel_scenarios_name_list, table_name = "./02-output/b-tables/pastick_orthel_scenarios_lrr_table_commas.csv")

#----------Make GIPL Orthel Scenarios LRR Stats Table----------
gipl_orthel_scenarios_lyr_list = c(baseline_orthel$GIPL00_2m_bin, gipl_scen_orthel$GIPL50_A1B_2m_bin,gipl_scen_orthel$GIPL90_A1B_2m_bin)
gipl_orthel_scenarios_name_list = c("GIPL - Baseline", "GIPL 50 A1B", "GIPL 90 A1B")
table_name = "./02-output/b-tables/gipl_orthel_scenarios_lrr_table.csv"

generate.custom.table.lrr(lyr_list = gipl_orthel_scenarios_lyr_list, name_list = gipl_orthel_scenarios_name_list, table_name = "./02-output/b-tables/gipl_orthel_scenarios_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = gipl_orthel_scenarios_lyr_list, name_list = gipl_orthel_scenarios_name_list, table_name = "./02-output/b-tables/gipl_orthel_scenarios_lrr_table_commas.csv")

#----------Make Aalto Orthel Scenarios LRR Stats Table----------
aalto_orthel_scenarios_lyr_list = c(baseline_orthel$past00_1m_bin, aalto_scen_orthel$aalto50_RCP45_2m_bin,aalto_scen_orthel$aalto70_RCP45_2m_bin, aalto_scen_orthel$aalto50_RCP85_2m_bin, aalto_scen_orthel$aalto70_RCP85_2m_bin)
aalto_orthel_scenarios_name_list = c("Aalto - Baseline", "Aalto 50 RCP4.5", "Aalto 70 RCP4.5", "Aalto 50 RCP8.5", "Aalto 70 RCP8.5")
table_name = "./02-output/b-tables/aalto_orthel_scenarios_lrr_table.csv"

generate.custom.table.lrr(lyr_list = aalto_orthel_scenarios_lyr_list, name_list = aalto_orthel_scenarios_name_list, table_name = "./02-output/b-tables/aalto_orthel_scenarios_lrr_table.csv")
generate.custom.table.commas.lrr(lyr_list = aalto_orthel_scenarios_lyr_list, name_list = aalto_orthel_scenarios_name_list, table_name = "./02-output/b-tables/aalto_orthel_scenarios_lrr_table_commas.csv")
