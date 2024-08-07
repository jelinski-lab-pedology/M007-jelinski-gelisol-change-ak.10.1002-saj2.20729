#---------- Figure 3: STATSGO ORDER/SUBORDER ----------------
jpeg("./02-output/a-figures/Figure 3 STATSGO Suborder Distributions.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

# define ranges
range_gel = c(0,1)
range_orth = c(0, 0.85)
range_hist = c(0,0.5)
range_turb = c(0,1)

# define color palettes
gel.pal <- leaflet::colorNumeric(palette = "Blues", domain = range_gel,na.color = "white", reverse = FALSE)
hist.pal <- leaflet::colorNumeric(palette = "Greens", domain = range_hist,na.color = "white", reverse = FALSE)
turb.pal <- leaflet::colorNumeric(palette = "Purples", domain = range_turb,na.color = "white", reverse = FALSE)
orth.pal <- leaflet::colorNumeric(palette = "Oranges", domain = range_orth,na.color = "white", reverse = FALSE)

#---------- Gelisols ----------
gel_mask = terra::mask(stat_rast_gelisol, past00_1000, maskvalues=NA, updatevalue=NA)
terra::plot(gel_mask, ext = lrr_albers_domain, col=gel.pal(seq(range_gel[1], range_gel[2], length.out=20)),mar=c(2,2,1.5,3),legend = "right")
##overprint zeros as NAs
stat_rast_gelisol_clamp0 = terra::clamp(stat_rast_gelisol, upper=0.009, values=FALSE)
plot(stat_rast_gelisol_clamp0, col="white", na.color="transparent", legend = FALSE, add=TRUE,axes=FALSE)
polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "A", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("STATSGO\nGelisol\nPrevalence"))), font = 1, cex=1)
north(xy = "topright", type = 1, label = "N")
sbar(d = 500000, xy= c(6.5e05, 6.5e05),type = "bar", divs = 4, below = "kilometers", label = c(0, 250,500))

#---------- Histels ----------
hist_mask = terra::mask(stat_rast_histel, past00_1000, maskvalues=NA, updatevalue=NA)
plot(hist_mask, ext = lrr_albers_domain, col=hist.pal(seq(range_hist[1], range_hist[2], length.out=20)),mar=c(2,2,1.5,3),legend = "right")
##overprint zeros as NAs
stat_rast_histel_clamp0 = terra::clamp(stat_rast_histel, upper=0.009, values=FALSE)
plot(stat_rast_histel_clamp0, col="white", na.color="transparent", legend = FALSE, add=TRUE,axes=FALSE)

polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "C", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("STATSGO\nHistel\nPrevalence"))), font = 1, cex=1)

# Blank for plotting
plot.new()

#----------Orthels ----------
orth_mask = terra::mask(stat_rast_orthel, past00_1000, maskvalues=NA, updatevalue=NA)
plot(orth_mask, ext = lrr_albers_domain, col=orth.pal(seq(range_orth[1], range_orth[2], length.out=20)),mar=c(2,2,1.5,3),legend = "right")
##overprint zeros as NAs
stat_rast_orthel_clamp0 = terra::clamp(stat_rast_orthel, upper=0.009, values=FALSE)
plot(stat_rast_orthel_clamp0, col="white", na.color="transparent", legend = FALSE, add=TRUE,axes=FALSE)
polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "C", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("STATSGO\nOrthel\nPrevalence"))), font = 1, cex=1)

#---------- Turbels ----------
turb_mask = terra::mask(stat_rast_turbel, past00_1000, maskvalues=NA, updatevalue=NA)
plot(turb_mask, ext = lrr_albers_domain, col=turb.pal(seq(range_turb[1], range_turb[2], length.out=20)),mar=c(2,2,1.5,3),legend = "right")
##overprint zeros as NAs
stat_rast_turbel_clamp0 = terra::clamp(stat_rast_turbel, upper=0.009, values=FALSE)
plot(stat_rast_turbel_clamp0, col="white", na.color="transparent", legend = FALSE, add=TRUE,axes=FALSE)
polys(lrr_albers_AK, lwd=0.25)

symbols(-6.0e+05,2200000, circles=1e05, inches=FALSE, fg="black", add=T, lwd=0.5)
text(-6.0e+05,2200000, "D", font = 1, cex=1)
text(1000000,1900000, substitute(paste(italic("STATSGO\nTurbel\nPrevalence"))), font = 1, cex=1)

dev.off()