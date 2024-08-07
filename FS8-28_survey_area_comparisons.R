#---------- Figures S8 to S28 Compare Gelisol Area from STATSGO and SSURGO for areas that have both (i.e. are certified SSURGO product) as well as NSP baselines from other studies ------------
#---------- Prepare survey boundaries and IDs ------------
# overlay soil survey areas on this - extract only survey areas that have SSURGO certified
survey <- terra::vect("./01-data/2022_SoilDataAvailabilityShapefile/ak_soil_survey_boundaries_a.shp")
survey

survey_albers = terra::project(survey, "epsg:6393")

# visual check
plot(gnat_rast_gelisol)
plot(survey_albers,add=T)

# check what the values are in SSURGO status
unique(survey$SSURGO)
# extract only SSURGO certified polygons
survey_albers_ssurgo = terra::subset(survey_albers, survey_albers$SSURGO == "Certified")

# visual check
plot(gnat_rast_gelisol)
plot(survey_albers_ssurgo, add=T)

# check to make sure these polygons are valid - yes they are
val_chk <- is.valid(survey_albers_ssurgo)
val_chk

# create a column in the attribute table of the SSURGO vector containing the survey ID:
survey_albers_ssurgo$surveyID = as.numeric(gsub("[a-zA-Z ]", "", unique(survey_albers_ssurgo$areasymbol)))

#---------- Figure S08 Survey ID 636 - Bristol Bay ------------
jpeg("./02-output/a-figures/Figure S8 Survey Area Comparison - Bristol Bay.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 636)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(-150000, 1010000, substitute(paste(italic("Yi\nNSP\n(636)"))), font = 1, cex=1, adj = c(0,1))

legend(-100000,1050000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(-150000, 1010000, substitute(paste(italic("Pastick\nNSP\n(636)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 50000, xy= c(-0.75e05, 1e06),type = "bar", divs = 2, below = "km", label = c(0, "",50))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(-150000, 1010000, substitute(paste(italic("GIPL\nNSP\n(636)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(-150000, 1010000, substitute(paste(italic("Aalto\nNSP\n(636)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(-150000, 1010000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(636)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(-150000, 1010000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(636)"))), font = 1, cex=1, adj = c(0,1))

dev.off()


#---------- Figure S09 Survey ID 612 - Copper River ------------
jpeg("./02-output/a-figures/Figure S9 Survey Area Comparison - Copper River.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 612)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(480000, 1382000, substitute(paste(italic("Yi\nNSP\n(612)"))), font = 1, cex=1, adj = c(0,1))

legend(430000,1345000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(480000, 1382000, substitute(paste(italic("Pastick\nNSP\n(612)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 20000, xy= c(480000, 1360000),type = "bar", divs = 4, below = "km", label = c(0, "",20))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(480000, 1382000, substitute(paste(italic("GIPL\nNSP\n(612)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(480000, 1382000, substitute(paste(italic("Aalto\nNSP\n(612)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(480000, 1382000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(612)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(480000, 1382000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(612)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S10 Survey ID 656 - Delta River ------------
jpeg("./02-output/a-figures/Figure S10 Survey Area Comparison - Delta River.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 656)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, xlim=c(360000,440500))
plot(survey_area, add=T)
text(410000, 1480000, substitute(paste(italic("Yi\nNSP\n(656)"))), font = 1, cex=1, adj = c(0,1))

legend(360200, 1490000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, xlim=c(360000,440500))
plot(survey_area, add=T)
text(410000, 1480000, substitute(paste(italic("Pastick\nNSP\n(656)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 20000, xy= c(370000, 1510000),type = "bar", divs = 4, below = "km", label = c(0, "",20))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, xlim=c(360000,440500))
plot(survey_area, add=T)
text(410000, 1480000, substitute(paste(italic("GIPL\nNSP\n(656)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, xlim=c(360000,440500))
plot(survey_area, add=T)
text(410000, 1480000, substitute(paste(italic("Aalto\nNSP\n(656)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,legend = "right", xlim=c(360000,440500))
plot(survey_area, add=T)
text(410000, 1480000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(656)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,legend = "right", xlim=c(360000,440500))
plot(survey_area, add=T)
text(410000, 1480000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(656)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S11 Survey ID 651 - Denali National Park ------------
jpeg("./02-output/a-figures/Figure S11 Survey Area Comparison - Denali National Park.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 651)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(210000, 1440000, substitute(paste(italic("Yi\nNSP\n(651)"))), font = 1, cex=1, adj = c(0,1))

legend(200000, 1420000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.6)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(210000, 1440000, substitute(paste(italic("Pastick\nNSP\n(651)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 50000, xy= c(2e05, 1400000),type = "bar", divs = 4, below = "km", label = c(0, "",50))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(210000, 1440000, substitute(paste(italic("GIPL\nNSP\n(651)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(210000, 1440000, substitute(paste(italic("Aalto\nNSP\n(651)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(170000, 1380000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(651)"))), font = 1, cex=0.8, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(170000, 1380000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(651)"))), font = 1, cex=0.8, adj = c(0,1))

dev.off()

#---------- Figure S12 683 - Fort Greely and Donnelly Training Area ------------
jpeg("./02-output/a-figures/Figure S12 Survey Area Comparison - Fort Greely and Donnelly Training Area.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 683)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(380000, 1595000, substitute(paste(italic("Yi\nNSP\n(683)"))), font = 1, cex=1, adj = c(0,1))

legend(390000, 1600000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(380000, 1595000, substitute(paste(italic("Pastick\nNSP\n(683)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 20000, xy= c(395000, 1595000),type = "bar", divs = 4, below = "km", label = c(0, "",20))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(380000, 1595000, substitute(paste(italic("GIPL\nNSP\n(683)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(380000, 1595000, substitute(paste(italic("Aalto\nNSP\n(683)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(380000, 1595000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(683)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(380000, 1595000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(683)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S13 650 - Fort Wainwright ------------
jpeg("./02-output/a-figures/Figure S13 Survey Area Comparison - Fort Wainwright.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 650)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(260000, 1655000, substitute(paste(italic("Yi\nNSP\n(650)"))), font = 1, cex=0.8, adj = c(0,1))

legend(343000, 1635000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.6)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(260000, 1655000, substitute(paste(italic("Pastick\nNSP\n(650)"))), font = 1, cex=0.8, adj = c(0,1))
sbar(d = 20000, xy= c(340000, 1630000),type = "bar", divs = 4, below = "km", label = c(0, "",20))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(260000, 1655000, substitute(paste(italic("GIPL\nNSP\n(650)"))), font = 1, cex=0.8, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(260000, 1655000, substitute(paste(italic("Aalto\nNSP\n(650)"))), font = 1, cex=0.8, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(260000, 1659500, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(650)"))), font = 1, cex=0.8, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(260000, 1659500, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(650)"))), font = 1, cex=0.8, adj = c(0,1))

dev.off()

#---------- Figure S14 615 - Gerstle River ------------
jpeg("./02-output/a-figures/Figure S14 Survey Area Comparison - Gerstle River.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 615)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(412000, 1565000, substitute(paste(italic("Yi\nNSP\n(615)"))), font = 1, cex=1, adj = c(0,1))

legend(425000,1580000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(412000, 1565000, substitute(paste(italic("Pastick\nNSP\n(615)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 10000, xy= c(430000, 1560000),type = "bar", divs = 4, below = "kilometers", label = c(0, "",10))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(412000, 1565000, substitute(paste(italic("GIPL\nNSP\n(615)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(412000, 1565000, substitute(paste(italic("Aalto\nNSP\n(615)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(412000, 1565000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(615)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(412000, 1565000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(615)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S15 657 - Greater Delta ------------
jpeg("./02-output/a-figures/Figure S15 Survey Area Comparison - Greater Delta.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 657)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(340000, 1570000, substitute(paste(italic("Yi\nNSP\n(657)"))), font = 1, cex=1, adj = c(0,1))

legend(390000, 1640000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(340000, 1570000, substitute(paste(italic("Pastick\nNSP\n(657)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 20000, xy= c(370000, 1580000),type = "bar", divs = 4, below = "kilometers", label = c(0, "",20))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(340000, 1570000, substitute(paste(italic("GIPL\nNSP\n(657)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(340000, 1570000, substitute(paste(italic("Aalto\nNSP\n(657)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(340000, 1570000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(657)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(340000, 1570000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(657)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S16 610 - Greater Fairbanks ------------
jpeg("./02-output/a-figures/Figure S16 Survey Area Comparison - Greater Fairbanks.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 610)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(282000, 1650000, substitute(paste(italic("Yi\nNSP\n(610)"))), font = 1, cex=1, adj = c(0,1))

legend(295000,1658000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(282000, 1650000, substitute(paste(italic("Pastick\nNSP\n(610)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 10000, xy= c(3e05, 1647500),type = "bar", divs = 4, below = "kilometers", label = c(0, "",10))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(282000, 1650000, substitute(paste(italic("GIPL\nNSP\n(610)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(282000, 1650000, substitute(paste(italic("Aalto\nNSP\n(610)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(282000, 1650000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(610)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(282000, 1650000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(610)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S17 655 - Greater Nenana ------------
jpeg("./02-output/a-figures/Figure S17 Survey Area Comparison - Greater Nenana.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 655)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3),xlim=c(180000,300000))
plot(survey_area, add=T)
text(260000, 1610000, substitute(paste(italic("Yi\nNSP\n(655)"))), font = 1, cex=1, adj = c(0,1))

legend(195000, 1640000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3),xlim=c(180000,300000))
plot(survey_area, add=T)
text(260000, 1610000, substitute(paste(italic("Pastick\nNSP\n(655)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 20000, xy= c(190000, 1600000),type = "bar", divs = 4, below = "kilometers", label = c(0, "",20))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3),xlim=c(180000,300000))
plot(survey_area, add=T)
text(260000, 1610000, substitute(paste(italic("GIPL\nNSP\n(655)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3),xlim=c(180000,300000))
plot(survey_area, add=T)
text(260000, 1610000, substitute(paste(italic("Aalto\nNSP\n(655)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right",xlim=c(180000,300000))
plot(survey_area, add=T)
text(260000, 1610000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(655)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right",xlim=c(180000,300000))
plot(survey_area, add=T)
text(260000, 1610000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(655)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S18 649 - Gulkana River ------------
jpeg("./02-output/a-figures/Figure S18 Survey Area Comparison - Gulkana River.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 649)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(375000, 1458000, substitute(paste(italic("Yi\nNSP\n(649)"))), font = 1, cex=1, adj = c(0,1))

legend(385000, 1463000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(375000, 1458000, substitute(paste(italic("Pastick\nNSP\n(649)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 10000, xy= c(4e05, 1440000),type = "bar", divs = 4, below = "kilometers", label = c(0, "",10))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(375000, 1458000, substitute(paste(italic("GIPL\nNSP\n(649)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(375000, 1458000, substitute(paste(italic("Aalto\nNSP\n(649)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(375000, 1458000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(649)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(375000, 1458000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(649)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S19 643 - Kantishna ------------
jpeg("./02-output/a-figures/Figure S19 Survey Area Comparison - Kantishna.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 643)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(115000, 1622000, substitute(paste(italic("Yi\nNSP\n(643)"))), font = 1, cex=1, adj = c(0,1))

legend(128000, 1633000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(115000, 1622000, substitute(paste(italic("Pastick\nNSP\n(643)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 20000, xy= c(135000, 1620000),type = "bar", divs = 4, below = "kilometers", label = c(0, "",20))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(115000, 1622000, substitute(paste(italic("GIPL\nNSP\n(643)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(115000, 1622000, substitute(paste(italic("Aalto\nNSP\n(643)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(115000, 1622000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(643)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(115000, 1622000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(643)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S20 642 - North Star Area ------------
jpeg("./02-output/a-figures/Figure S20 Survey Area Comparison - North Star Area.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 642)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(252000, 1630000, substitute(paste(italic("Yi\nNSP\n(642)"))), font = 1, cex=1, adj = c(0,1))

legend(280000, 1660000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(252000, 1630000, substitute(paste(italic("Pastick\nNSP\n(642)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 20000, xy= c(3e05, 1630000),type = "bar", divs = 4, below = "kilometers", label = c(0, "",20))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(252000, 1630000, substitute(paste(italic("GIPL\nNSP\n(642)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(252000, 1630000, substitute(paste(italic("Aalto\nNSP\n(642)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(252000, 1630000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(642)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(252000, 1630000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(642)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S21 630 - Nulato Hills ------------
jpeg("./02-output/a-figures/Figure S21 Survey Area Comparison - Nulato Hills.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 630)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(-400000, 1550000, substitute(paste(italic("Yi\nNSP\n(630)"))), font = 1, cex=1, adj = c(0,1))

legend(-400000,1482000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.6)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(-400000, 1550000, substitute(paste(italic("Pastick\nNSP\n(630)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 20000, xy= c(-310000, 1460000),type = "bar", divs = 4, below = "km", label = c(0, "",20))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(-400000, 1550000, substitute(paste(italic("GIPL\nNSP\n(630)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(-400000, 1550000, substitute(paste(italic("Aalto\nNSP\n(630)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(-400000, 1550000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(630)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(-400000, 1550000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(630)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S22 658 - Stewart River Training Area ------------
jpeg("./02-output/a-figures/Figure S22 Survey Area Comparison - Stewart River Training Area.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 658)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3), xlim=c(-560000, -530000),ylim = c(1680000,1710000))
plot(survey_area, add=T)
text(-555000, 1705000, substitute(paste(italic("Yi\nNSP\n(658)"))), font = 1, cex=1, adj = c(0,1))

legend(-540000, 1690000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3),xlim=c(-560000, -530000),ylim = c(1680000,1710000))
plot(survey_area, add=T)
text(-555000, 1705000, substitute(paste(italic("Pastick\nNSP\n(658)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 5000, xy= c(-540000, 1685000),type = "bar", divs = 4, below = "km", label = c(0, "",5))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3),xlim=c(-560000, -530000),ylim = c(1680000,1710000))
plot(survey_area, add=T)
text(-555000, 1705000, substitute(paste(italic("GIPL\nNSP\n(658)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3),xlim=c(-560000, -530000),ylim = c(1680000,1710000))
plot(survey_area, add=T)
text(-555000, 1705000, substitute(paste(italic("Aalto\nNSP\n(658)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right",xlim=c(-560000, -530000),ylim = c(1680000,1710000))
plot(survey_area, add=T)
text(-555000, 1705000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(658)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right",xlim=c(-560000, -530000),ylim = c(1680000,1710000))
plot(survey_area, add=T)
text(-555000, 1705000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(658)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S23 637 - Togiak ------------
jpeg("./02-output/a-figures/Figure S23 Survey Area Comparison - Togiak.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 637)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3), xlim=c(-450000, -220000))
plot(survey_area, add=T)
text(-415000, 1020000, substitute(paste(italic("Yi\nNSP\n(637)"))), font = 1, cex=1, adj = c(0,1))

legend(-265000,1100000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3),xlim=c(-450000, -220000))
plot(survey_area, add=T)
text(-415000, 1020000, substitute(paste(italic("Pastick\nNSP\n(637)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 20000, xy= c(-440000, 1100000),type = "bar", divs = 4, below = "km", label = c(0, "",20))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3),xlim=c(-450000, -220000))
plot(survey_area, add=T)
text(-415000, 1020000, substitute(paste(italic("GIPL\nNSP\n(637)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3),xlim=c(-450000, -220000))
plot(survey_area, add=T)
text(-415000, 1020000, substitute(paste(italic("Aalto\nNSP\n(637)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right",xlim=c(-450000, -220000))
plot(survey_area, add=T)
text(-440000, 1020000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(637)"))), font = 1, cex=0.8, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right",xlim=c(-450000, -220000))
plot(survey_area, add=T)
text(-440000, 1020000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(637)"))), font = 1, cex=0.8, adj = c(0,1))

dev.off()

#---------- Figure S24 625 - Totchaket ------------
jpeg("./02-output/a-figures/Figure S24 Survey Area Comparison - Totchaket.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 625)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3), xlim=c(160000,250000))
plot(survey_area, add=T)
text(163000, 1655000, substitute(paste(italic("Yi\nNSP\n(625)"))), font = 1, cex=1, adj = c(0,1))

legend(163000,1645000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3), xlim=c(160000,250000))
plot(survey_area, add=T)
text(163000, 1655000, substitute(paste(italic("Pastick\nNSP\n(625)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 20000, xy= c(225000, 1610000),type = "bar", divs = 4, below = "km", label = c(0, "",20))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3), xlim=c(160000,250000))
plot(survey_area, add=T)
text(163000, 1655000, substitute(paste(italic("GIPL\nNSP\n(625)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3), xlim=c(160000,250000))
plot(survey_area, add=T)
text(163000, 1655000, substitute(paste(italic("Aalto\nNSP\n(625)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),xlim=c(160000,250000), legend = "right")
plot(survey_area, add=T)
text(163000, 1655000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(625)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3), xlim=c(160000,250000))
plot(survey_area, add=T)
text(163000, 1655000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(625)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S25 640 - Upper Tanana ------------
jpeg("./02-output/a-figures/Figure S25 Survey Area Comparison - Upper Tanana.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 640)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(353000, 1585000, substitute(paste(italic("Yi\nNSP\n(640)"))), font = 1, cex=1, adj = c(0,1))

legend(363000, 1592000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(353000, 1585000, substitute(paste(italic("Pastick\nNSP\n(640)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 10000, xy= c(365000, 1585000),type = "bar", divs = 4, below = "km", label = c(0, "",10))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(353000, 1585000, substitute(paste(italic("GIPL\nNSP\n(640)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(353000, 1585000, substitute(paste(italic("Aalto\nNSP\n(640)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(353000, 1585000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(640)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(353000, 1585000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(640)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S26 654 - Western Interior Rivers ------------
jpeg("./02-output/a-figures/Figure S26 Survey Area Comparison - Western Interior Rivers.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 654)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(-240000, 1400000, substitute(paste(italic("Yi\nNSP\n(654)"))), font = 1, cex=1, adj = c(0,1))

legend(-195000, 1450000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(-240000, 1400000, substitute(paste(italic("Pastick\nNSP\n(654)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 50000, xy= c(-180000, 1400000),type = "bar", divs = 4, below = "km", label = c(0, "",50))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(-240000, 1400000, substitute(paste(italic("GIPL\nNSP\n(654)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(-240000, 1400000, substitute(paste(italic("Aalto\nNSP\n(654)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(-240000, 1400000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(654)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(-240000, 1400000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(654)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S27 685 - Yukon Flats ------------
jpeg("./02-output/a-figures/Figure S27 Survey Area Comparison - Yukon Flats.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 685)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(200000, 1920000, substitute(paste(italic("Yi\nNSP\n(685)"))), font = 1, cex=1, adj = c(0,1))

legend(240000, 1950000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(200000, 1920000, substitute(paste(italic("Pastick\nNSP\n(685)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 50000, xy= c(240000, 1900000),type = "bar", divs = 4, below = "km", label = c(0, "",50))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(200000, 1920000, substitute(paste(italic("GIPL\nNSP\n(685)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(200000, 1920000, substitute(paste(italic("Aalto\nNSP\n(685)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(200000, 1920000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(685)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(200000, 1920000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(685)"))), font = 1, cex=1, adj = c(0,1))

dev.off()

#---------- Figure S28 684 - Yukon-Charley Rivers National Preserve ------------
jpeg("./02-output/a-figures/Figure S28 Survey Area Comparison - Yukon-Charley Rivers National Preserve.jpg",
     width=8*300,
     height=8*220,
     res=400,
     pointsize=8)

layout.matrix <- matrix(c(1,4,7,2,5,8,3,6,9), nrow = 3, ncol = 3)
layout(mat = layout.matrix)
layout.show(9)

survey_area = terra::subset(survey_albers_ssurgo, survey_albers_ssurgo$surveyID == 684)

plot(mask(baseline_binaries$yi_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(550000, 1680000, substitute(paste(italic("Yi\nNSP\n(684)"))), font = 1, cex=1, adj = c(0,1))

legend(570000, 1700000,legend=c("+NSP", "-NSP"), box.lwd = 0.5, lty = NULL, pt.bg=c("steelblue", "white"), pt.lwd = 0.5, pch = c(22, 22), col = "black", cex=0.8)

north(xy = "topright", type = 1, label = "N")

plot(mask(baseline_binaries$past00_1m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(550000, 1680000, substitute(paste(italic("Pastick\nNSP\n(684)"))), font = 1, cex=1, adj = c(0,1))
sbar(d = 20000, xy= c(575000, 1662000),type = "bar", divs = 4, below = "km", label = c(0, "",20))

plot(mask(baseline_binaries$GIPL00_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 1, cex.axis = 1, cex.lab = 1, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(550000, 1680000, substitute(paste(italic("GIPL\nNSP\n(684)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(baseline_binaries$aalto_2m_bin, survey_area), ext=ext(survey_area),col="steelblue3", cex = 2, cex.axis = 2, cex.lab = 2, legend = NULL, mar=c(2,2,1.5,3))
plot(survey_area, add=T)
text(550000, 1680000, substitute(paste(italic("Aalto\nNSP\n(684)"))), font = 1, cex=1, adj = c(0,1))

plot(mask(gnat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2, mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(548000, 1680000, substitute(paste(italic("gNATSGO\nGelisol Prevalence\n(684)"))), font = 1, cex=0.8, adj = c(0,1))

plot(mask(stat_rast_gelisol, survey_area), ext=ext(survey_area), cex = 2, cex.axis = 2, cex.lab = 2,mar=c(2,2,1.5,3),legend = "right")
plot(survey_area, add=T)
text(548000, 1680000, substitute(paste(italic("STATSGO\nGelisol Prevalence\n(684)"))), font = 1, cex=0.8, adj = c(0,1))

dev.off()