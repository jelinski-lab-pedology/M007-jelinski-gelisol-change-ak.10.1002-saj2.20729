#---------- Figures S2, S3 and S4: Emissions Scenarios ----------
#----------MODERATE----------
jpeg("./02-output/a-figures/Figure S3 Moderate Emission Scenarios.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

par(mfrow=c(3,3))

plot(baseline_binaries$GIPL00_2m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "A", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("GIPL\n00-09\nBaseline"))), font = 1, cex=1)

legend(850000,1750000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue3", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

plot(GIPL_scen$GIPL50_A1B_2m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "B", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("GIPL\n50-59\nA1B"))), font = 1, cex=1)

plot(GIPL_scen$GIPL90_A1B_2m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "C", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("GIPL\n90-99\nA1B"))), font = 1, cex=1)

plot(baseline_binaries$past00_1m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "D", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\n00-09\nBaseline"))), font = 1, cex=1)

legend(850000,1750000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue3", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

plot(pastick_scen$past50_A1B_1m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "E", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\n50-59\nA1B"))), font = 1, cex=1)

plot(pastick_scen$past90_A1B_1m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "F", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\n90-99\nA1B"))), font = 1, cex=1)

dev.off()

#---------- High ----------------
jpeg("./02-output/a-figures/Figure S4 High Emission Scenarios.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

par(mfrow=c(3,3))

plot(baseline_binaries$aalto_2m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "A", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Aalto\n00-14\nBaseline"))), font = 1, cex=1)

legend(850000,1750000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue3", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

plot(aalto_scen$aalto50_RCP85_2m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "B", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Aalto\n41-60\nRCP8.5"))), font = 1, cex=1)

plot(aalto_scen$aalto70_RCP85_2m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "C", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Aalto\n61-80\nRCP8.5"))), font = 1, cex=1)

plot(baseline_binaries$past00_1m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "D", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\n00-09\nBaseline"))), font = 1, cex=1)

legend(850000,1750000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue3", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

plot(pastick_scen$past50_A2_1m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "E", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\n50-59\nA2"))), font = 1, cex=1)

plot(pastick_scen$past90_A2_1m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "F", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\n90-99\nA2"))), font = 1, cex=1)

dev.off()

#----------LOW----------------
jpeg("./02-output/a-figures/Figure S2 Low Emission Scenarios.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

par(mfrow=c(3,3))

plot(baseline_binaries$aalto_2m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "A", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Aalto\n00-14\nBaseline"))), font = 1, cex=1)

legend(850000,1750000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue3", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

plot(aalto_scen$aalto50_RCP26_2m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "B", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Aalto\n41-60\nRCP2.6"))), font = 1, cex=1)

plot(aalto_scen$aalto70_RCP26_2m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "C", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Aalto\n61-80\nRCP2.6"))), font = 1, cex=1)

plot(baseline_binaries$past00_1m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "D", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\n00-09\nBaseline"))), font = 1, cex=1)

legend(850000,1750000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue3", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

plot(pastick_scen$past50_B1_1m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "E", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\n50-59\nB1"))), font = 1, cex=1)

plot(pastick_scen$past90_B1_1m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "F", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\n90-99\nB1"))), font = 1, cex=1)

dev.off()
######