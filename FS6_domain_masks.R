#---------- Figure S6 DOMAIN MASKS ----------
jpeg("./02-output/a-figures/Figure S6 Pastick Domain Masks.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

plot(rast_ice, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="black", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "A", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\nIce Mask"))), font = 1, cex=1)

legend(850000,1750000,legend=c("+Ice", "-Ice"), box.lwd = 0.5, lty = NULL, pt.bg=c("black", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

plot(rast_rock, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="black", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "B", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\nRock Mask"))), font = 1, cex=1)
legend(850000,1750000,legend=c("+Rock", "-Rock"), box.lwd = 0.5, lty = NULL, pt.bg=c("black", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

plot(rast_urban, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="black", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "C", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\nUrban Mask"))), font = 1, cex=1)
legend(850000,1750000,legend=c("+Urban", "-Urban"), box.lwd = 0.5, lty = NULL, pt.bg=c("black", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

plot(rast_water, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="black", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-7.0e+05,2200000, "D", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\nWater Mask"))), font = 1, cex=1)

legend(850000,1750000,legend=c("+Water", "-Water"), box.lwd = 0.5, lty = NULL, pt.bg=c("black", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

plot(rast_nonsoil, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="black", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "E", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\nNon-Soil Mask"))), font = 1, cex=1)
legend(850000,1750000,legend=c("+NonSoil", "-NonSoil"), box.lwd = 0.5, lty = NULL, pt.bg=c("black", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

plot(rast_soil, ext = lrr_albers_domain, mar=c(2,2,1.5,3), col="black", legend = FALSE)
polys(lrr_albers_AK, lwd=0.25)
symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "E", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("Pastick\nSoil Mask"))), font = 1, cex=1)
legend(850000,1750000,legend=c("+Soil", "-Soil"), box.lwd = 0.5, lty = NULL, pt.bg=c("black", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

dev.off()