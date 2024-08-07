#---------- Figure S1 BASELINE COMPARISONS ------------
jpeg("./02-output/a-figures/Figure S1 Baseline Scenarios.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

plot(gel_mask, ext = lrr_albers_domain, col=gel.pal(seq(range_gel[1], range_gel[2], length.out=20)),mar=c(2,2,1.5,3),legend = "right")
polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "A", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("STATSGO\nGelisol\nPrevalence"))), font = 1, cex=1)

# legend(850000,1750000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue3", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=1)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

plot(baseline_binaries$dostem_base_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "B", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("DOS-TEM\n00-09\nBaseline"))), font = 1, cex=1)
legend(850000,1750000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue3", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

plot(baseline_binaries$GIPL00_2m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "C", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("GIPL\n00-09\nBaseline"))), font = 1, cex=1)

plot(baseline_binaries$aalto_2m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "D", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Aalto\n00-14\nBaseline"))), font = 1, cex=1)
legend(850000,1750000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue3", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

plot(baseline_binaries$past00_1m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "E", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\n00-09\nBaseline"))), font = 1, cex=1)

plot(baseline_binaries$yi_2m_bin, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="steelblue3", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "F", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Yi\n00-15\nBaseline"))), font = 1, cex=1)

dev.off()


######

