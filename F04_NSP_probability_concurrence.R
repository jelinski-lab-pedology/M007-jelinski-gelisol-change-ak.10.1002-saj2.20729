#---------- Figure 4 NSP STATSGO gNATSGO Concurrence ----------
# This creates a raster that sums the binaries at each cell for all of the baselines. So, a value of 1 means that 1 baseline predicted NSP there. a value of 5 means that all 5 baselines predicted NSP there.
maximum_nsp = sum(baseline_binaries$yi_2m_bin, baseline_binaries$aalto_2m_bin, baseline_binaries$dostem_base_bin, baseline_binaries$GIPL00_2m_bin, baseline_binaries$past00_1m_bin, na.rm=TRUE)
plot(maximum_nsp,ext = lrr_albers_domain, col = rainbow(5))
plot(lrr_albers_domain, add=T)

# This is making a binary presence absence raster for anywhere NSP was predicted (even if just by 1 model).
maximum_nsp_bin = maximum_nsp %>%
  terra::clamp(lower=1,upper=5, values=FALSE) %>%
  terra::subst(from=c(1:5), to=1) %>%
  terra::mask(rast_soil)

plot(maximum_nsp_bin, ext = lrr_albers_domain, col = "steelblue3")
plot(lrr_albers_domain, add=T)

#---------- STATSGO Concurrence ----------
# This is making a binary presence absence raster for anywhere Gelisols were mapped in STATSGO (even if just 1% of the comp_r).
stat_rast_gelisol_binall = stat_rast_gelisol %>%
  terra::clamp(lower=0.01,upper=1.0, values=FALSE) %>%
  .GreaterEqualZero()

plot(stat_rast_gelisol_binall, ext = lrr_albers_domain, col = "steelblue3")
plot(lrr_albers_domain, add=T)

# Here we are building to generate a difference raster between the NSP baselines and STATSGO to see where STATSGO gelisols occur where no NSP is predicted and vice versa. To do that I am assigning all presence cells a value of 2, and all nonpresence cells (NA) a value of 1 for both binary rasters.
stat_rast_gelisol_binall_val2na1=subst(stat_rast_gelisol_binall, from = c(1, NA), to = c(2, 1))
plot(stat_rast_gelisol_binall_val2na1,ext = lrr_albers_domain, col = rainbow(4))
plot(lrr_albers_AK, add=T)

maximum_nsp_bin_val2na1=subst(maximum_nsp_bin, from = c(1, NA), to = c(2, 1))
plot(maximum_nsp_bin_val2na1,ext = lrr_albers_domain, col = rainbow(4))
plot(lrr_albers_AK, add=T)

# Now take the difference between them. This gives you 3 unique values: -1 (Gelisols mapped in STATSGO, no NSP predicted in baselines), 0 (either concurrence OR NA (delat with separating later), or 1 (NSP predicted, no Gelisols mapped in STATSGO))
nsp_stat_diff = maximum_nsp_bin_val2na1 - stat_rast_gelisol_binall_val2na1
plot(nsp_stat_diff,ext = lrr_albers_domain, col = rainbow(4))
plot(lrr_albers_AK, add=T)

# Now to separate the NA from the concurrence, create a domain raster, which has NA for anywhere that STAT Gelisols or NSP is not predicted, and a value everywhere else. The value is equal to 1 for where STATSGO is predicted, and 2-6 (for 1-5 in the original) for how many NSP baseline datasets predicted NSP at that cell
nsp_stat_domain = sum(maximum_nsp, stat_rast_gelisol_binall, na.rm=T) 

# So now multiplying by nsp_stat_diff, which has -1 for all of the STATSGO predicted area - you get a value of -1. You get a value of 0 for all areas of concurrence, and then 1-5 for all values where NSP predicted (and the number of baselines predicting it there).
nsp_stat_diff_soil = nsp_stat_diff * nsp_stat_domain
plot(nsp_stat_diff_soil,ext = lrr_albers_domain, col = rainbow(7))
plot(lrr_albers_AK, add=T)

# Now make this categorical and assign names to the categories
levels(nsp_stat_diff_soil)<- data.frame(ID=c(-1, 0, 1, 2, 3, 4, 5), class=c("STATSGO", "Concurrence", "NSP - 1", "NSP - 2", "NSP - 3", "NSP - 4", "NSP - 5"))

# and plot with colors that make sense
plot(nsp_stat_diff_soil,ext = lrr_albers_domain, col = c("#d53e4f", "grey80","#c6dbef", "#9ecae1","#6baed6","#3182bd","#08519c"))
plot(mlra_albers_domain, add=T)

#---------- gNATSGO Concurrence ----------

# This is making a binary presence absence raster for anywhere Gelisols were mapped in gNATSGO (even if just 1% of the comp_r).
gnat_rast_gelisol_binall = gnat_rast_gelisol %>%
  terra::clamp(lower=0.01,upper=1.0, values=FALSE) %>%
  .GreaterEqualZero()

plot(gnat_rast_gelisol_binall, ext = mlra_albers_domain, col = "steelblue3")
plot(mlra_albers_domain, add=T)

# Building to generate a difference raster between the NSP baselines and gNATSGO to see where gNATSGO gelisols occur where no NSP is predicted and vice versa. To do that I am assigning all presence cells a value of 2, and all nonpresence cells (NA) a value of 1 for both binary rasters.
gnat_rast_gelisol_binall_val2na1=subst(gnat_rast_gelisol_binall, from = c(1, NA), to = c(2, 1))
plot(gnat_rast_gelisol_binall_val2na1,ext = lrr_albers_domain, col = rainbow(4))
plot(lrr_albers_AK, add=T)

maximum_nsp_bin_val2na1=subst(maximum_nsp_bin, from = c(1, NA), to = c(2, 1))
plot(maximum_nsp_bin_val2na1,ext = lrr_albers_domain, col = rainbow(4))
plot(lrr_albers_AK, add=T)

# Now take the difference between them. This gives you 3 unique values: -1 (Gelisols mapped in gNATSGO, no NSP predicted in baselines), 0 (either concurrence OR NA (dealt with separating later), or 1 (NSP predicted, no Gelisols mapped in gNATSGO))
nsp_gnat_diff = maximum_nsp_bin_val2na1 - gnat_rast_gelisol_binall_val2na1
plot(nsp_gnat_diff,ext = lrr_albers_domain, col = rainbow(4))
plot(lrr_albers_AK, add=T)

# Now to separate the NA from the concurrence, create a domain raster, which has NA for anywhere that STAT Gelisols or NSP is not predicted, and a value everywhere else. The value is equal to 1 for where gNATSGO is predicted, and 2-6 (for 1-5 in the original) for how many NSP baseline datasets predicted NSP at that cell
nsp_gnat_domain = sum(maximum_nsp, gnat_rast_gelisol_binall, na.rm=T) 

# So now multiplying by nsp_stat_diff, which has -1 for all of the STATSGO predicted area - you get a value of -1. You get a value of 0 for all areas of concurrence, and then 1-5 for all values where NSP predicted (and the number of baselines predicting it there).
nsp_gnat_diff_soil = nsp_gnat_diff * nsp_gnat_domain
plot(nsp_gnat_diff_soil,ext = lrr_albers_domain, col = rainbow(7))
plot(lrr_albers_AK, add=T)

# Now make this categorical and assign names to the categories
levels(nsp_gnat_diff_soil)<- data.frame(ID=c(-1, 0, 1, 2, 3, 4, 5), class=c("gNATSGO", "Concurrence", "NSP - 1", "NSP - 2", "NSP - 3", "NSP - 4", "NSP - 5"))

#and plot with colors that make sense
plot(nsp_gnat_diff_soil,ext = lrr_albers_domain, col = c("#d53e4f", "grey80","#c6dbef", "#9ecae1","#6baed6","#3182bd","#08519c"))
plot(mlra_albers_domain, add=T)

#---------- Difference STATSGO and gNATSGO ----------
# This is a binary raster for the domain of cells where Gelisols were mapped for EITHER STATSGO or gNATSGO
stat_gnat_gelisol_domain = sum(stat_rast_gelisol_binall, gnat_rast_gelisol_binall, na.rm=T)
stat_gnat_gelisol_domain = terra::clamp(stat_gnat_gelisol_domain, lower = 1, upper = 2, values = FALSE) %>%
  .GreaterEqualZero()

# Load in survey area boundaries for plotting
survey <- terra::vect("./01-data/2022_SoilDataAvailabilityShapefile/ak_soil_survey_boundaries_a.shp")
survey_albers = terra::project(survey, "epsg:6393")
survey_albers_ssurgo = terra::subset(survey_albers, survey_albers$SSURGO == "Certified")

# this generates a raster where -1 equals present in gNATSGO but not STATSGO, 0 = concurrence, and 1 = present in STATSGO but not gNATSGO - note that a lot of these, even though presence absence looks like a lot - they tended to be low prevalence to in STATSGO - I think
stat_gnat_diff = stat_rast_gelisol_binall_val2na1 - gnat_rast_gelisol_binall_val2na1
stat_gnat_diff_soil = stat_gnat_diff * stat_gnat_gelisol_domain

# Now make this categorical and assign names to the categories
levels(stat_gnat_diff_soil)<- data.frame(ID=c(-1, 0, 1), class=c("-STAT, +gNAT", "Concurrence", "+STAT, -gNAT"))

plot(stat_gnat_diff_soil,ext = mlra_albers_domain, col = c("#af8dc3", "grey80","#7fbf7b"))
plot(survey_albers_ssurgo, add=T, lwd=0.5)

#---------- FINAL PLOT ----------

jpeg("./02-output/a-figures/Figure 4 NSP Probability Concurrence.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

# NSP SUM
maximum_nsp = sum(baseline_binaries$yi_2m_bin, baseline_binaries$aalto_2m_bin, baseline_binaries$dostem_base_bin, baseline_binaries$GIPL00_2m_bin, baseline_binaries$past00_1m_bin, na.rm=TRUE)
plot(maximum_nsp,ext = lrr_albers_domain, col = rainbow(5),mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "A", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Baseline\nNSP\nConcurrence"))), font = 1, cex=1)
legend(850000,1750000,legend=c("+1 Model", "+2 Model", "+3 Model", "+4 Model", "+5 Model"), box.lwd = 0.5, lty = NULL, pt.bg=rainbow(5), pt.lwd = 0.5, pch = c(22, 22,22,22,22), col = "black", cex=0.7)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

# Difference between STATSGO and gNATSGO
plot(stat_gnat_diff_soil,ext = mlra_albers_domain, col = c("#af8dc3", "grey80","#7fbf7b"),mar=c(2,2,1.5,3),legend = NULL)
plot(survey_albers_ssurgo, add=T, lwd=0.2)
polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "B", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("STATSGO-\ngNATSGO\nConcurrence"))), font = 1, cex=1)
legend(850000,1750000,legend=c("-STAT,\n+gNAT", "Concurrence", "+STAT,\n-gNAT"), box.lwd = 0.5, lty = NULL, pt.bg=c("#af8dc3", "grey80","#7fbf7b"), pt.lwd = 0.5, pch = c(22, 22,22,22,22), col = "black", cex=0.7)

# Empty Plot 
plot.new()

# Difference between NSP Predictions and gNATSGO
plot(nsp_stat_diff_soil,ext = lrr_albers_domain, col = c("#d53e4f", "grey80","#c6dbef", "#9ecae1","#6baed6","#3182bd","#08519c"),mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "C", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("STATSGO-\nNSP Model\nConcurrence"))), font = 1, cex=1)
legend(850000,1750000,legend=c("STATSGO", "Concurrence", "+1 NSP Model", "+2 NSP Model", "+3 NSP Model", "+4 NSP Model", "+5 NSP Model"), box.lwd = 0.5, lty = NULL, pt.bg=c("#d53e4f", "grey80","#c6dbef", "#9ecae1","#6baed6","#3182bd","#08519c"), pt.lwd = 0.5, pch = c(22, 22,22,22,22), col = "black", cex=0.7)

# Difference between NSP predictions and STATSGO
plot(nsp_gnat_diff_soil,ext = lrr_albers_domain, col = c("#d53e4f", "grey80","#c6dbef", "#9ecae1","#6baed6","#3182bd","#08519c"),mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "D", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("gNATSGO-\nNSP Model\nConcurrence"))), font = 1, cex=1)
legend(850000,1750000,legend=c("STATSGO", "Concurrence", "+1 NSP Model", "+2 NSP Model", "+3 NSP Model", "+4 NSP Model", "+5 NSP Model"), box.lwd = 0.5, lty = NULL, pt.bg=c("#d53e4f", "grey80","#c6dbef", "#9ecae1","#6baed6","#3182bd","#08519c"), pt.lwd = 0.5, pch = c(22, 22,22,22,22), col = "black", cex=0.7)

dev.off()