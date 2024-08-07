#---------- Generate Figure Components and Check Individual Layout ----------

#---------- Low Emissions Scenarios (B1 & RCP 4.5) ----------
# This is making a binary presence absence raster for anywhere Turbels were mapped in STATSGO (even if just 1% of the comp_r).
stat_rast_turbel_binall = stat_rast_turbel %>%
  terra::clamp(lower=0.01,upper=1.0, values=FALSE) %>%
  .GreaterEqualZero()

# This is making a binary presence absence raster for anywhere NSP present in Pastick early-century
past00_1m_bin_turbel = baseline_turbel$past00_1m_bin %>%
  .Mult100() %>%
  terra::clamp(lower=1,upper=100, values=FALSE) %>%
  round() %>%
  terra::subst(from=c(1:100), to=1) %>%
  terra::mask(rast_soil)

# This is making a binary presence absence raster for anywhere NSP present in Aalto early-century
aalto00_2m_bin_turbel = baseline_turbel$aalto_2m_bin %>%
  .Mult100() %>%
  terra::clamp(lower=1,upper=100, values=FALSE) %>%
  round() %>%
  terra::subst(from=c(1:100), to=1) %>%
  terra::mask(rast_soil)

# This is creating a raster with three values by difference - 0 = STATSGO Only, 1 = 1 Model, 2 = 2 Models (model identity not differentiated in this case).
basePK_stat_diff = past00_1m_bin_turbel %>%
  sum(aalto00_2m_bin_turbel, na.rm=T) %>%
  subst(from = c(2, 1, NA), to = c(3, 2, 1)) %>%
  .SubtractRaster(stat_rast_turbel_binall)

#---------- Early-Century Baseline (Low Emissions) ----------
plot(basePK_stat_diff,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

plotrix::draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "A", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("B1-RCP45\nBaseline\n2000-2014"))), font = 1, cex=1)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

legend(850000,1750000,legend=c("STATSGO", "+1 Model","+2 Models"), box.lwd = 0.5, lty = NULL, pt.bg=c("grey80","#bcbddc","#756bb1"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.7)

#---------- Mid-Century 2040-2060 (Low Emissions) ----------
m <- c(0.01, 1.0, 1)
rclmat <- matrix(m, ncol=3, byrow=TRUE)

m0 = c(-0.5,0.5,NA)
rclmat0 <- matrix(m0, ncol=3, byrow=TRUE)

past50_B1_1m_bin_val10 <- classify(pastick_scen_turbel$past50_B1_1m_bin, rclmat, include.lowest=TRUE)

aalto50_RCP45_2m_bin_val10 <- classify(aalto_scen_turbel$aalto50_RCP45_2m_bin, rclmat, include.lowest=TRUE)

b1_turb_preds50 = sum(past50_B1_1m_bin_val10, aalto50_RCP45_2m_bin_val10, na.rm=T)

b150_stat_diff = b1_turb_preds50 %>%
  subst(from = c(2, 1, 0, NA), to = c(3, 2, 1, 0)) %>%
  .SubtractRaster(subst(stat_rast_turbel_binall, from = c(1, NA), to = c(2, 1)))

b150_stat_domain = b1_turb_preds50 %>%
  sum(stat_rast_turbel_binall, na.rm=T) %>%
  classify(rclmat0, include.lowest = TRUE)

b150_stat_diff_soil = b150_stat_diff * b150_stat_domain

plot(b150_stat_diff_soil,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "B", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("B1-RCP45\nMid-Century\n2040-2060"))), font = 1, cex=1)

#---------- Late-Century 2070-2090 (Low Emissions) ----------
m <- c(0.01, 1.0, 1)
rclmat <- matrix(m, ncol=3, byrow=TRUE)

m0 = c(-0.5,0.5,NA)
rclmat0 <- matrix(m0, ncol=3, byrow=TRUE)

past90_B1_1m_bin_val10 <- classify(pastick_scen_turbel$past90_B1_1m_bin, rclmat, include.lowest=TRUE)

aalto70_RCP45_2m_bin_val10 <- classify(aalto_scen_turbel$aalto70_RCP45_2m_bin, rclmat, include.lowest=TRUE)

b1_turb_preds90 = sum(past90_B1_1m_bin_val10, aalto70_RCP45_2m_bin_val10, na.rm=T)

b190_stat_diff = b1_turb_preds90 %>%
  subst(from = c(2, 1, 0, NA), to = c(3, 2, 1, 0)) %>%
  .SubtractRaster(subst(stat_rast_turbel_binall, from = c(1, NA), to = c(2, 1)))

b190_stat_domain = b1_turb_preds90 %>%
  sum(stat_rast_turbel_binall, na.rm=T) %>%
  classify(rclmat0, include.lowest = TRUE)

b190_stat_diff_soil = b190_stat_diff * b190_stat_domain

plot(b190_stat_diff_soil,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "C", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("B1-RCP45\nLate-Century\n2061-2099"))), font = 1, cex=1)

#---------- Moderate Emissions Scenarios (A1B) ----------
stat_rast_turbel_binall = stat_rast_turbel %>%
  terra::clamp(lower=0.01,upper=1.0, values=FALSE) %>%
  .GreaterEqualZero()

past00_1m_bin_turbel = baseline_turbel$past00_1m_bin %>%
  .Mult100() %>%
  terra::clamp(lower=1,upper=100, values=FALSE) %>%
  round() %>%
  terra::subst(from=c(1:100), to=1) %>%
  terra::mask(rast_soil)

GIPL00_2m_bin_turbel = baseline_turbel$GIPL00_2m_bin %>%
  .Mult100() %>%
  terra::clamp(lower=1,upper=100, values=FALSE) %>%
  round() %>%
  terra::subst(from=c(1:100), to=1) %>%
  terra::mask(rast_soil)

basePG_stat_diff = past00_1m_bin_turbel %>%
  sum(GIPL00_2m_bin_turbel, na.rm=T) %>%
  subst(from = c(2, 1, NA), to = c(3, 2, 1)) %>%
  .SubtractRaster(stat_rast_turbel_binall)

#---------- Early-Century Baseline (Mod Emissions) ----------
plot(basePG_stat_diff,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "D", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("A1B\nBaseline\n2000-2009"))), font = 1, cex=1)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

legend(850000,1750000,legend=c("STATSGO", "+1 Model","+2 Models"), box.lwd = 0.5, lty = NULL, pt.bg=c("grey80","#bcbddc","#756bb1"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.7)

#---------- Mid-Century 2050-2059 (Mod Emissions) ----------
m <- c(0.01, 1.0, 1)
rclmat <- matrix(m, ncol=3, byrow=TRUE)

m0 = c(-0.5,0.5,NA)
rclmat0 <- matrix(m0, ncol=3, byrow=TRUE)

past50_A1B_1m_bin_val10 <- classify(pastick_scen_turbel$past50_A1B_1m_bin, rclmat, include.lowest=TRUE)

GIPL50_A1B_2m_bin_val10 <- classify(gipl_scen_turbel$GIPL50_A1B_2m_bin, rclmat, include.lowest=TRUE)

a1b_turb_preds50 = sum(past50_A1B_1m_bin_val10, GIPL50_A1B_2m_bin_val10, na.rm=T)

a1b50_stat_diff = a1b_turb_preds50 %>%
  subst(from = c(2, 1, 0, NA), to = c(3, 2, 1, 0)) %>%
  .SubtractRaster(subst(stat_rast_turbel_binall, from = c(1, NA), to = c(2, 1)))

a1b50_stat_domain = a1b_turb_preds50 %>%
  sum(stat_rast_turbel_binall, na.rm=T) %>%
  classify(rclmat0, include.lowest = TRUE)

a1b50_stat_diff_soil = a1b50_stat_diff * a1b50_stat_domain

plot(a1b50_stat_diff_soil,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "E", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("A1B\nMid-Century\n2050-2059"))), font = 1, cex=1)

#---------- Late-Century 2090-2099 (Mod Emissions) ----------
m <- c(0.01, 1.0, 1)
rclmat <- matrix(m, ncol=3, byrow=TRUE)

m0 = c(-0.5,0.5,NA)
rclmat0 <- matrix(m0, ncol=3, byrow=TRUE)

past90_A1B_1m_bin_val10 <- classify(pastick_scen_turbel$past90_A1B_1m_bin, rclmat, include.lowest=TRUE)

GIPL90_A1B_2m_bin_val10 <- classify(gipl_scen_turbel$GIPL90_A1B_2m_bin, rclmat, include.lowest=TRUE)

a1b_turb_preds90 = sum(past90_A1B_1m_bin_val10, GIPL90_A1B_2m_bin_val10, na.rm=T)

a1b90_stat_diff = a1b_turb_preds90 %>%
  subst(from = c(2, 1, 0, NA), to = c(3, 2, 1, 0)) %>%
  .SubtractRaster(subst(stat_rast_turbel_binall, from = c(1, NA), to = c(2, 1)))

a1b90_stat_domain = a1b_turb_preds90 %>%
  sum(stat_rast_turbel_binall, na.rm=T) %>%
  classify(rclmat0, include.lowest = TRUE)

a1b90_stat_diff_soil = a1b90_stat_diff * a1b90_stat_domain

plot(a1b90_stat_diff_soil,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "F", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("A1B\nLate-Century\n2090-2099"))), font = 1, cex=1)

#---------- High Emissions Scenarios (A2 & RCP8.5) ----------
stat_rast_turbel_binall = stat_rast_turbel %>%
  terra::clamp(lower=0.01,upper=1.0, values=FALSE) %>%
  .GreaterEqualZero()

past00_1m_bin_turbel = baseline_turbel$past00_1m_bin %>%
  .Mult100() %>%
  terra::clamp(lower=1,upper=100, values=FALSE) %>%
  round() %>%
  terra::subst(from=c(1:100), to=1) %>%
  terra::mask(rast_soil)

aalto00_2m_bin_turbel = baseline_turbel$aalto_2m_bin %>%
  .Mult100() %>%
  terra::clamp(lower=1,upper=100, values=FALSE) %>%
  round() %>%
  terra::subst(from=c(1:100), to=1) %>%
  terra::mask(rast_soil)

basePK_stat_diff = past00_1m_bin_turbel %>%
  sum(aalto00_2m_bin_turbel, na.rm=T) %>%
  subst(from = c(2, 1, NA), to = c(3, 2, 1)) %>%
  .SubtractRaster(stat_rast_turbel_binall)

#---------- Early-Century Baseline (High Emissions) ----------
plot(basePK_stat_diff,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "A", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("A2-RCP85\nBaseline\n2000-2014"))), font = 1, cex=1)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

legend(850000,1750000,legend=c("STATSGO", "+1 Model","+2 Models"), box.lwd = 0.5, lty = NULL, pt.bg=c("grey80","#bcbddc","#756bb1"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.7)

#---------- Mid-Century (High Emissions) ----------
m <- c(0.01, 1.0, 1)
rclmat <- matrix(m, ncol=3, byrow=TRUE)

m0 = c(-0.5,0.5,NA)
rclmat0 <- matrix(m0, ncol=3, byrow=TRUE)

past50_A2_1m_bin_val10 <- classify(pastick_scen_turbel$past50_A2_1m_bin, rclmat, include.lowest=TRUE)

aalto50_RCP85_2m_bin_val10 <- classify(aalto_scen_turbel$aalto50_RCP85_2m_bin, rclmat, include.lowest=TRUE)

a2_turb_preds50 = sum(past50_A2_1m_bin_val10, aalto50_RCP85_2m_bin_val10, na.rm=T)

a250_stat_diff = a2_turb_preds50 %>%
  subst(from = c(2, 1, 0, NA), to = c(3, 2, 1, 0)) %>%
  .SubtractRaster(subst(stat_rast_turbel_binall, from = c(1, NA), to = c(2, 1)))

a250_stat_domain = a2_turb_preds50 %>%
  sum(stat_rast_turbel_binall, na.rm=T) %>%
  classify(rclmat0, include.lowest = TRUE)

a250_stat_diff_soil = a250_stat_diff * a250_stat_domain

plot(a250_stat_diff_soil,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "H", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("A2-RCP85\nMid-Century\n2040-2060"))), font = 1, cex=1)

#---------- Late-Century (High Emissions) ----------
m <- c(0.01, 1.0, 1)
rclmat <- matrix(m, ncol=3, byrow=TRUE)

m0 = c(-0.5,0.5,NA)
rclmat0 <- matrix(m0, ncol=3, byrow=TRUE)

past90_A2_1m_bin_val10 <- classify(pastick_scen_turbel$past90_A2_1m_bin, rclmat, include.lowest=TRUE)

aalto70_RCP85_2m_bin_val10 <- classify(aalto_scen_turbel$aalto70_RCP85_2m_bin, rclmat, include.lowest=TRUE)

a2_turb_preds90 = sum(past90_A2_1m_bin_val10, aalto70_RCP85_2m_bin_val10, na.rm=T)

a290_stat_diff = a2_turb_preds90 %>%
  subst(from = c(2, 1, 0, NA), to = c(3, 2, 1, 0)) %>%
  .SubtractRaster(subst(stat_rast_turbel_binall, from = c(1, NA), to = c(2, 1)))

a290_stat_domain = a2_turb_preds90 %>%
  sum(stat_rast_turbel_binall, na.rm=T) %>%
  classify(rclmat0, include.lowest = TRUE)

a290_stat_diff_soil = a290_stat_diff * a290_stat_domain

plot(a290_stat_diff_soil,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "H", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("A2-RCP85\nLate-Century\n2070-2090"))), font = 1, cex=1)

#---------- FINAL FIGURE ----------
jpeg("./02-output/a-figures/Figure 9 Turbel Baseline and Scenarios.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

#---------- Early-Century Baseline (Low Emissions) ----------
plot(basePK_stat_diff,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "A", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("B1-RCP45\nBaseline\n2000-2014"))), font = 1, cex=1)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

legend(850000,1750000,legend=c("STATSGO", "+1 Model","+2 Models"), box.lwd = 0.5, lty = NULL, pt.bg=c("grey80","#bcbddc","#756bb1"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.7)

#---------- Mid-Century Baseline (Low Emissions) ----------
plot(b150_stat_diff_soil,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "B", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("B1-RCP45\nMid-Century\n2040-2060"))), font = 1, cex=1)

#---------- Late-Century Baseline (Low Emissions) ----------
plot(b190_stat_diff_soil,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "C", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("B1-RCP45\nLate-Century\n2061-2099"))), font = 1, cex=1)

#---------- Early-Century Baseline (Mod Emissions) ----------
plot(basePG_stat_diff,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "D", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("A1B\nBaseline\n2000-2009"))), font = 1, cex=1)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

legend(850000,1750000,legend=c("STATSGO", "+1 Model","+2 Models"), box.lwd = 0.5, lty = NULL, pt.bg=c("grey80","#bcbddc","#756bb1"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.7)

#---------- Mid-Century Baseline (Mod Emissions) ----------
plot(a1b50_stat_diff_soil,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "E", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("A1B\nMid-Century\n2050-2059"))), font = 1, cex=1)

#---------- Late-Century Baseline (Mod Emissions) ----------
plot(a1b90_stat_diff_soil,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "F", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("A1B\nLate-Century\n2090-2099"))), font = 1, cex=1)

#---------- Early-Century Baseline (High Emissions) ----------
plot(basePK_stat_diff,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "G", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("A2-RCP85\nBaseline\n2000-2014"))), font = 1, cex=1)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

legend(850000,1750000,legend=c("STATSGO", "+1 Model","+2 Models"), box.lwd = 0.5, lty = NULL, pt.bg=c("grey80","#bcbddc","#756bb1"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.7)

#---------- Mid-Century (High Emissions) ----------
plot(a250_stat_diff_soil,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "H", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("A2-RCP85\nMid-Century\n2040-2060"))), font = 1, cex=1)

#---------- Late-Century (High Emissions) ----------
plot(a290_stat_diff_soil,ext = lrr_albers_domain, col = c("grey80","#bcbddc","#756bb1"), cex.axis = 2, cex.lab = 2, cex = 2, mar=c(2,2,1.5,3),legend = NULL)
polys(lrr_albers_AK, lwd=0.25)

draw.circle(-7.0e+05,2200000, 1e05, lwd=0.5)
text(-7.0e+05,2200000, "I", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("A2-RCP85\nLate-Century\n2061-2099"))), font = 1, cex=1)

dev.off()
