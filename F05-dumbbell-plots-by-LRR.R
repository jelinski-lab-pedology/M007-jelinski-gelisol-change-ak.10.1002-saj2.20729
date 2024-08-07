#---------- NOTE: for some reason the master script does not run the two sections at the bottom. After running this full script, need to run at least this section at the bottom "#---------- CREATE COMBINED PLOT! SKINNY ----------------" to get the final plot included in the manuscript ----------------
#---------- These are the rasters/raster stacks that contain important data for plotting----------------
#STATSGO/SSURGO
  #gnat_rast_gelisol$
    #MURast_gNATSGO_1000m_AK_202210_NN1

  #stat_rast_gelisol$
    #mukey

#NON-STATSGO/SSURGO BASELINE DATA
  #baseline_gelisol$
    #yi_2m_bin
    #aalto_2m_bin
    #dostem_base_bin
    #GIPL00_2m_bin
    #past00_1m_bin

#SCENARIOS - Aalto
  #aalto_scen_gelisol$
    #aalto50_RCP26_2m_bin
    #aalto70_RCP26_2m_bin
    #aalto50_RCP45_2m_bin
    #aalto70_RCP45_2m_bin
    #aalto50_RCP85_2m_bin
    #aalto70_RCP85_2m_bin

#SCENARIOS - Pastick
  #pastick_scen_gelisol$
    #past50_B1_1m_bin
    #past90_B1_1m_bin
    #past50_A1B_1m_bin
    #past90_A1B_1m_bin
    #past50_A2_1m_bin
    #past90_A2_1m_bin

#SCENARIOS - GIPL
  #gipl_scen_gelisol$
    #GIPL50_A1B_2m_bin
    #GIPL90_A1B_2m_bin


#----------Low Emission Scenario LRR PLOT ----------------

#---------- Make table for plotting----------------
dumbell_lyr_list = c(stat_rast_gelisol, gnat_rast_gelisol, baseline_gelisol$yi_2m_bin, baseline_gelisol$past00_1m_bin, baseline_gelisol$aalto_2m_bin, pastick_scen_gelisol$past50_B1_1m_bin, pastick_scen_gelisol$past90_B1_1m_bin, aalto_scen_gelisol$aalto50_RCP45_2m_bin, aalto_scen_gelisol$aalto70_RCP45_2m_bin)
dumbell_name_list = c("USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Pastick - Baseline", "Aalto - Baseline", "Pastick 50-59", "Pastick 90-99", "Aalto 50", "Aalto 70")
dumbell_table_name = "./02-output/b-tables/dumbell_B1_table_lrr.csv"

generate.custom.table.lrr(lyr_list = dumbell_lyr_list, name_list = dumbell_name_list, table_name = dumbell_table_name)

#---------- Set up Table for Plotting ----------------
b1_area_lrr.dat = read.csv("./02-output/b-tables/dumbell_B1_table_lrr.csv")

# Make into Tibble (needed for some of the plotting code below - I think?)
b1_area_lrr.dat_tibble = as_tibble(b1_area_lrr.dat)
str(b1_area_lrr.dat_tibble)

# Make LRR_NAME a factor
b1_area_lrr.dat_tibble$LRR.Name = as.factor(b1_area_lrr.dat_tibble$LRR.Name)
str(b1_area_lrr.dat_tibble)

# Replace all NAs with 0
b1_area_lrr.dat_tibble[is.na(b1_area_lrr.dat_tibble)] <- 0

# Make colnames work
colnames(b1_area_lrr.dat_tibble)[4:12] = c("USDA - STATSGO", "USDA - gNATSGO","Yi et al - Baseline", "Pastick - Baseline", "Aalto - Baseline", "Pastick 50-59", "Pastick 90-99", "Aalto 50", "Aalto 70")

# define a color palette for the early, mid and late century scenarios
cols <- c("#2b8cbe", "#74a9cf", "#bdc9e1", "#2b8cbe", "#74a9cf", "#bdc9e1")

# reorder from highest Pastick Area to Lowest Pastick Area (doing this manually by looking at the data table for area_mlra.dat_tibble.interior)
lrr.levels = c('Northern Alaska', 'Interior Alaska', 'Western Alaska', 'Southern Alaska','Aleutian Alaska')
b1_area_lrr.dat_tibble$LRR.Name <- factor(b1_area_lrr.dat_tibble$LRR.Name, levels=lrr.levels)
# check that they are reordered
levels(b1_area_lrr.dat_tibble$LRR.Name)

p.low = ggplot2::ggplot() +
  # draw empty plot just to get order right
  # 1 do not include Pastick 00
  ggplot2::geom_segment(
    data = gather(b1_area_lrr.dat_tibble, measure, val, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Aalto - Baseline", "Pastick 50-59", "Pastick 90-99", "Aalto 50", "Aalto 70")) %>% 
      replace_na(list(val = 0)) %>%
      group_by(LRR.Name) %>% 
      top_n(-1) %>% 
      slice(1) %>%
      ungroup() %>%
      mutate(LRR.Name = fct_reorder(LRR.Name, desc(val))),
    ggplot2::aes(x = 0, xend = val, y = LRR.Name, yend = LRR.Name),
    linetype = "dotted", size = 0.5, color = "gray100"
  ) +
  
  annotate("text",
           x = 295000,
           y = 5.4,
           label = "Low Emission Scenarios",
           family = "", fontface = "bold", size=5, hjust = 1) +
  xlab("km2") +
  
  # reshape the data frame & get min value so you can draw an eye-tracking line (this is one geom)
  # 2 - do not include STATSGO
  ggplot2::geom_segment(
    data = gather(b1_area_lrr.dat_tibble, measure, val, -c("X","LRR.Name","LRR.Symbol", "USDA - gNATSGO", "Yi et al - Baseline", "Pastick - Baseline", "Aalto - Baseline", "Pastick 50-59", "Pastick 90-99", "Aalto 50", "Aalto 70")) %>% 
      replace_na(list(val = 0)) %>%
      group_by(LRR.Name) %>% 
      top_n(-1) %>% 
      slice(1) %>%
      ungroup(),
    
    ggplot2::aes(x = 0, xend = val, y = LRR.Name, yend = LRR.Name),
    linetype = "dotted", size = 0.5, color = "gray80"
  ) +
  
  # reshape the data frame & get min/max category values so you can draw the segment (this is another geom) for Pastick scenarios - offset +0.15
  # 3 - do not include Pastick 00, Pastick 50, Pastick 90
  ggplot2::geom_segment(
    data = gather(b1_area_lrr.dat_tibble, measure, val, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Aalto - Baseline", "Aalto 50", "Aalto 70")) %>% 
      replace_na(list(val = 0)) %>%
      group_by(LRR.Name) %>% 
      summarise(start = range(val)[1], end = range(val)[2]) %>% 
      ungroup(),
    ggplot2::aes(x = start, xend = end, y = as.numeric(LRR.Name)+0.15, yend = as.numeric(LRR.Name)+0.15),
    color = "gray80", size = 0.5
  ) +
  
  # reshape the data frame & get min/max category values so you can draw the segment (this is another geom) for Aalto scenarios - offset +0.05
  # 4 - do not include Aalto - Baseline, Aalto 50, Aalto 70
  ggplot2::geom_segment(
    data = gather(b1_area_lrr.dat_tibble, measure, val, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Pastick - Baseline", "Pastick 50-59", "Pastick 90-99")) %>% 
      replace_na(list(val = 0)) %>%
      group_by(LRR.Name) %>% 
      summarise(start = range(val)[1], end = range(val)[2]) %>% 
      ungroup(),
    ggplot2::aes(x = start, xend = end, y = as.numeric(LRR.Name)+0.05, yend = as.numeric(LRR.Name)+0.05),
    color = "gray80", size = 0.5
  ) +
  
  # reshape the data frame & plot the points for Pastick - offset +0.15
  # 6 - do not include Pastick 00, Pastick 50, Pastick 90
  ggplot2::geom_point(
    data = gather(b1_area_lrr.dat_tibble, measure, value, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Aalto - Baseline", "Aalto 50", "Aalto 70")),
    ggplot2::aes(value, as.numeric(LRR.Name)+0.15, color = factor(measure), fill = factor(measure), shape = factor(measure), size = factor(measure)), 
  )+
  
  # extended the scale a bit + put axis on top; choose aesthetics that work for you
  scale_x_comma(position = "top", limits = c(0, 300000)) +
  scale_shape_manual(values = c(21, 21, 21, 21, 21, 21)) +
  scale_colour_manual(values = c("black", "black", "black", "black", "black", "black"), aesthetics = "colour") +
  scale_fill_manual(values = cols, aesthetics = "fill") +
  scale_size_manual(values = c(4,4,4,4,4,4)) +
  
  # reshape the data frame & plot the points for Aalto - offset +0.05
  # 7 - do not include Aalto Baseline, Aalto 50, Aalto 70
  ggplot2::geom_point(
    data = gather(b1_area_lrr.dat_tibble, measure, value, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Pastick - Baseline", "Pastick 50-59", "Pastick 90-99")),
    ggplot2::aes(value, as.numeric(LRR.Name)+0.05, color = factor(measure), fill = factor(measure), shape = factor(measure), size = factor(measure)), 
  )+
  
# reshape the data frame & plot the baseline points in line with category label - offset -0.15
# 9 - do not include STATSGO, gNATSGO, Yi
ggplot2::geom_point(
  data = gather(b1_area_lrr.dat_tibble, measure, value, -c("X","LRR.Name","LRR.Symbol", "Pastick - Baseline", "Aalto - Baseline", "Pastick 50-59", "Pastick 90-99", "Aalto 50", "Aalto 70")),
  ggplot2::aes(value, as.numeric(LRR.Name)-0.15, color = factor(measure), fill = factor(measure), shape = factor(measure), size = factor(measure)), 
)+
  scale_shape_manual(values = c(23, 23, 23, 21, 21, 21, 25, 25, 25)) +
  scale_colour_manual(values = c("black", "black", "black", "black", "black", "black","black", "black", "black"), aesthetics = "colour") +
  scale_fill_manual(values = c("#756bb1", "#bcbddc", "#efedf5", "#e6550d", "#fdae6b", "#fee6ce", "#969696", "#cccccc", "#f7f7f7"), aesthetics = "fill") +
  scale_size_manual(values = c(4,4,4,4,4,4,4,4,4)) +
  
  theme(axis.title.y=element_blank())+
  theme_ipsum_rc(base_family = "Arial", subtitle_family = if (.Platform$OS.type == "windows") "Roboto Condensed" else
    "Arial",caption_family = if (.Platform$OS.type == "windows") "Roboto Condensed" else
      "Arial",  grid = "X") +
  theme(legend.background = element_rect(fill="transparent",
                                         size=0.5, linetype="solid", 
                                         colour ="transparent"))+
  theme(legend.title=element_blank())+
  theme(legend.position = c(0.80, 0.65)) +
  theme(legend.key.size = unit(0.5, 'cm'))+
  theme(panel.border=element_rect(fill=NA),axis.title.y=element_blank())

# check output
p.low

# generate jpg
jpeg("./03-support-files/temp/Gelisol Dumbell LRR Low Emission Test 27JUN2023.jpg",
     width=8*600,
     height=8*700,
     res=400,
     pointsize=8)

# quartz()
p.low


dev.off()

#----------  Moderate Emission Scenario LRR PLOT ----------------------------
#---------- Make table for plotting-----------------------------------------
dumbell_lyr_list = c(stat_rast_gelisol, gnat_rast_gelisol, baseline_gelisol$yi_2m_bin, baseline_gelisol$past00_1m_bin, baseline_gelisol$GIPL00_2m_bin, pastick_scen_gelisol$past50_A1B_1m_bin, pastick_scen_gelisol$past90_A1B_1m_bin, gipl_scen_gelisol$GIPL50_A1B_2m_bin, gipl_scen_gelisol$GIPL90_A1B_2m_bin)
dumbell_name_list = c("USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Pastick - Baseline", "GIPL - Baseline", "Aalto - Baseline", "Pastick 50-59", "Pastick 90-99", "GIPL 50-59", "GIPL 90-99", "Aalto 50", "Aalto 70")
dumbell_table_name = "./02-output/b-tables/dumbell_A1B_table_lrr.csv"

generate.custom.table.lrr(lyr_list = dumbell_lyr_list, name_list = dumbell_name_list, table_name = dumbell_table_name)

#----------  Set up Table for Plotting -------------------------------------

a1b_area_lrr.dat = read.csv("./02-output/b-tables/dumbell_A1B_table_lrr.csv")

# Make into Tibble (needed for some of the plotting code below - I think?)
a1b_area_lrr.dat_tibble = as_tibble(a1b_area_lrr.dat)
str(a1b_area_lrr.dat_tibble)

# Make LRR_NAME a factor
a1b_area_lrr.dat_tibble$LRR.Name = as.factor(a1b_area_lrr.dat_tibble$LRR.Name)
str(a1b_area_lrr.dat_tibble)

# Replace all NAs with 0
a1b_area_lrr.dat_tibble[is.na(a1b_area_lrr.dat_tibble)] <- 0

# Make colnames work
colnames(a1b_area_lrr.dat_tibble)[4:12] = c("USDA - STATSGO", "USDA - gNATSGO","Yi et al - Baseline", "Pastick - Baseline", "GIPL - Baseline", "Pastick 50-59", "Pastick 90-99", "GIPL 50-59", "GIPL 90-99")

# define a color palette for the early, mid and late century scenarios
cols <- c("#2b8cbe", "#74a9cf", "#bdc9e1", "#2b8cbe", "#74a9cf", "#bdc9e1")

# reorder from highest Pastick Area to Lowest Pastick Area (doing this manually by looking at the data table for area_mlra.dat_tibble.interior)
lrr.levels = c('Northern Alaska', 'Interior Alaska', 'Western Alaska', 'Southern Alaska','Aleutian Alaska')
a1b_area_lrr.dat_tibble$LRR.Name <- factor(a1b_area_lrr.dat_tibble$LRR.Name, levels=lrr.levels)
#check that they are reordered
levels(a1b_area_lrr.dat_tibble$LRR.Name)

p.mod = ggplot2::ggplot() +
  # draw empty plot just to get order right
  # 1 do not include Pastick 00
  ggplot2::geom_segment(
    data = gather(a1b_area_lrr.dat_tibble, measure, val, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "GIPL - Baseline", "Pastick 50-59", "Pastick 90-99", "GIPL 50-59", "GIPL 90-99")) %>% 
      replace_na(list(val = 0)) %>%
      group_by(LRR.Name) %>% 
      top_n(-1) %>% 
      slice(1) %>%
      ungroup() %>%
      mutate(LRR.Name = fct_reorder(LRR.Name, desc(val))),
    ggplot2::aes(x = 0, xend = val, y = LRR.Name, yend = LRR.Name),
    linetype = "dotted", size = 0.5, color = "gray100"
  ) +
  
  annotate("text",
           x = 295000,
           y = 5.4,
           label = "Moderate Emission Scenarios",
           family = "", fontface = "bold", size=5, hjust = 1) +
  
  # reshape the data frame & get min value so you can draw an eye-tracking line (this is one geom)
  # 2 - do not include STATSGO
  ggplot2::geom_segment(
    data = gather(a1b_area_lrr.dat_tibble, measure, val, -c("X","LRR.Name","LRR.Symbol", "USDA - gNATSGO", "Yi et al - Baseline", "Pastick - Baseline", "GIPL - Baseline", "Pastick 50-59", "Pastick 90-99", "GIPL 50-59", "GIPL 90-99")) %>% 
      replace_na(list(val = 0)) %>%
      group_by(LRR.Name) %>% 
      top_n(-1) %>% 
      slice(1) %>%
      ungroup(),
    
    ggplot2::aes(x = 0, xend = val, y = LRR.Name, yend = LRR.Name),
    linetype = "dotted", size = 0.5, color = "gray80"
  ) +
  
  # reshape the data frame & get min/max category values so you can draw the segment (this is another geom) for Pastick scenarios - offset +0.15
  # 3 - do not include Pastick 00, Pastick 50, Pastick 90
  ggplot2::geom_segment(
    data = gather(a1b_area_lrr.dat_tibble, measure, val, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "GIPL - Baseline", "GIPL 50-59", "GIPL 90-99")) %>% 
      replace_na(list(val = 0)) %>%
      group_by(LRR.Name) %>% 
      summarise(start = range(val)[1], end = range(val)[2]) %>% 
      ungroup(),
    ggplot2::aes(x = start, xend = end, y = as.numeric(LRR.Name)+0.15, yend = as.numeric(LRR.Name)+0.15),
    color = "gray80", size = 0.5
  ) +
  
  # reshape the data frame & get min/max category values so you can draw the segment (this is another geom) for GIPL scenarios - offset -0.05
  # 5 - do not include GIPL 00, GIPL 50, GIPL 90
  ggplot2::geom_segment(
    data = gather(a1b_area_lrr.dat_tibble, measure, val, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Pastick - Baseline", "Pastick 50-59", "Pastick 90-99")) %>% 
      replace_na(list(val = 0)) %>%
      group_by(LRR.Name) %>% 
      summarise(start = range(val)[1], end = range(val)[2]) %>% 
      ungroup(),
    ggplot2::aes(x = start, xend = end, y = as.numeric(LRR.Name)-0.05, yend = as.numeric(LRR.Name)-0.05),
    color = "gray80", size = 0.5
  ) +
  
  # reshape the data frame & plot the points for Pastick - offset +0.15
  # 6 - do not include Pastick 00, Pastick 50, Pastick 90
  ggplot2::geom_point(
    data = gather(a1b_area_lrr.dat_tibble, measure, value, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "GIPL - Baseline", "GIPL 50-59", "GIPL 90-99")),
    ggplot2::aes(value, as.numeric(LRR.Name)+0.15, color = factor(measure), fill = factor(measure), shape = factor(measure), size = factor(measure)), 
  )+
  
  # extended the scale a bit + put axis on top; choose aesthetics that work for you
  scale_x_comma(position = "top", limits = c(0, 300000)) +
  scale_shape_manual(values = c(21, 21, 21, 21, 21, 21)) +
  scale_colour_manual(values = c("black", "black", "black", "black", "black", "black"), aesthetics = "colour") +
  scale_fill_manual(values = cols, aesthetics = "fill") +
  scale_size_manual(values = c(4,4,4,4,4,4)) +
  
  # reshape the data frame & plot the points for GIPL - offset -0.05
  # 8 - do not include GIPL 00, GIPL 50, GIPL 90
  ggplot2::geom_point(
    data = gather(a1b_area_lrr.dat_tibble, measure, value, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Pastick - Baseline","Pastick 50-59", "Pastick 90-99")),
    ggplot2::aes(value, as.numeric(LRR.Name)-0.05, color = factor(measure), fill = factor(measure), shape = factor(measure), size = factor(measure)), 
  )+
  
  # reshape the data frame & plot the baseline points in line with category label - offset -0.15
  # 9 - do not include STATSGO, gNATSGO, Yi
  ggplot2::geom_point(
    data = gather(a1b_area_lrr.dat_tibble, measure, value, -c("X","LRR.Name","LRR.Symbol", "Pastick - Baseline", "GIPL - Baseline", "Pastick 50-59", "Pastick 90-99", "GIPL 50-59", "GIPL 90-99")),
    ggplot2::aes(value, as.numeric(LRR.Name)-0.15, color = factor(measure), fill = factor(measure), shape = factor(measure), size = factor(measure)), 
  )+
  scale_shape_manual(values = c(22, 22, 22, 21, 21, 21, 25, 25, 25)) +
  scale_colour_manual(values = c("black", "black", "black","black", "black", "black","black", "black", "black"), aesthetics = "colour") +
  scale_fill_manual(values = c("#2b8cbe", "#74a9cf", "#bdc9e1", "#e6550d", "#fdae6b", "#fee6ce", "#969696", "#cccccc", "#f7f7f7"), aesthetics = "fill") +
  scale_size_manual(values = c(4,4,4,4,4,4,4,4,4)) +
  
  theme(axis.title.y=element_blank())+
  theme_ipsum_rc(base_family = "Arial", subtitle_family = if (.Platform$OS.type == "windows") "Roboto Condensed" else
    "Arial",caption_family = if (.Platform$OS.type == "windows") "Roboto Condensed" else
      "Arial",  grid = "X") +
  theme(legend.background = element_rect(fill="transparent",
                                         size=0.5, linetype="solid", 
                                         colour ="transparent"))+
  theme(legend.title=element_blank())+
  theme(legend.position = c(0.80, 0.65)) +
  theme(legend.key.size = unit(0.5, 'cm'))+
  theme(panel.border=element_rect(fill=NA),axis.title.y=element_blank())

# check output
p.mod

# generate jpg
jpeg("./03-support-files/temp/Gelisol Dumbell LRR Moderate Emission Test 27JUN2023.jpg",
     width=8*600,
     height=8*700,
     res=400,
     pointsize=8)

#quartz()
p.mod


dev.off()

#----------  High Emission Scenario LRR PLOT-------------------

#----------- Make table for plotting ----------------------------
dumbell_lyr_list = c(stat_rast_gelisol, gnat_rast_gelisol, baseline_gelisol$yi_2m_bin, baseline_gelisol$past00_1m_bin, baseline_gelisol$aalto_2m_bin, pastick_scen_gelisol$past50_A2_1m_bin, pastick_scen_gelisol$past90_A2_1m_bin, aalto_scen_gelisol$aalto50_RCP85_2m_bin, aalto_scen_gelisol$aalto70_RCP85_2m_bin)
dumbell_name_list = c("USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Pastick - Baseline", "Aalto - Baseline", "Pastick 50-59", "Pastick 90-99", "Aalto 50", "Aalto 70")
dumbell_table_name = "./02-output/b-tables/dumbell_A2_table_lrr.csv"

generate.custom.table.lrr(lyr_list = dumbell_lyr_list, name_list = dumbell_name_list, table_name = dumbell_table_name)

#---------- Set up Table for Plotting---------------------------

a2_area_lrr.dat = read.csv("./02-output/b-tables/dumbell_A2_table_lrr.csv")

# Make into Tibble (needed for some of the plotting code below - I think?)
a2_area_lrr.dat_tibble = as_tibble(a2_area_lrr.dat)
str(a2_area_lrr.dat_tibble)

# Make LRR_NAME a factor
a2_area_lrr.dat_tibble$LRR.Name = as.factor(a2_area_lrr.dat_tibble$LRR.Name)
str(a2_area_lrr.dat_tibble)

# Replace all NAs with 0
a2_area_lrr.dat_tibble[is.na(a2_area_lrr.dat_tibble)] <- 0

# Make colnames work
colnames(a2_area_lrr.dat_tibble)[4:12] = c("USDA - STATSGO", "USDA - gNATSGO","Yi et al - Baseline", "Pastick - Baseline", "Aalto - Baseline", "Pastick 50-59", "Pastick 90-99", "Aalto 50", "Aalto 70")

#define a color palette for the early, mid and late century scenarios
cols <- c("#2b8cbe", "#74a9cf", "#bdc9e1", "#2b8cbe", "#74a9cf", "#bdc9e1")

# reorder from highest Pastick Area to Lowest Pastick Area (doing this manually by looking at the data table for area_mlra.dat_tibble.interior)
lrr.levels = c('Northern Alaska', 'Interior Alaska', 'Western Alaska', 'Southern Alaska','Aleutian Alaska')
a2_area_lrr.dat_tibble$LRR.Name <- factor(a2_area_lrr.dat_tibble$LRR.Name, levels=lrr.levels)
# check that they are reordered
levels(a2_area_lrr.dat_tibble$LRR.Name)

p.high = ggplot2::ggplot() +
  # draw empty plot just to get order right
  # 1 do not include Pastick 00
  ggplot2::geom_segment(
    data = gather(a2_area_lrr.dat_tibble, measure, val, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Aalto - Baseline", "Pastick 50-59", "Pastick 90-99", "Aalto 50", "Aalto 70")) %>% 
      replace_na(list(val = 0)) %>%
      group_by(LRR.Name) %>% 
      top_n(-1) %>% 
      slice(1) %>%
      ungroup() %>%
      mutate(LRR.Name = fct_reorder(LRR.Name, desc(val))),
    ggplot2::aes(x = 0, xend = val, y = LRR.Name, yend = LRR.Name),
    linetype = "dotted", size = 0.5, color = "gray100"
  ) +
  
  annotate("text",
           x = 295000,
           y = 5.2,
           label = "High Emission Scenarios",
           family = "", fontface = "bold", size=5, hjust = 1) +
  
  # reshape the data frame & get min value so you can draw an eye-tracking line (this is one geom)
  # 2 - do not include STATSGO
  ggplot2::geom_segment(
    data = gather(a2_area_lrr.dat_tibble, measure, val, -c("X","LRR.Name","LRR.Symbol", "USDA - gNATSGO", "Yi et al - Baseline", "Pastick - Baseline", "Aalto - Baseline", "Pastick 50-59", "Pastick 90-99", "Aalto 50", "Aalto 70")) %>% 
      replace_na(list(val = 0)) %>%
      group_by(LRR.Name) %>% 
      top_n(-1) %>% 
      slice(1) %>%
      ungroup(),
    
    ggplot2::aes(x = 0, xend = val, y = LRR.Name, yend = LRR.Name),
    linetype = "dotted", size = 0.5, color = "gray80"
  ) +
  
  # reshape the data frame & get min/max category values so you can draw the segment (this is another geom) for Pastick scenarios - offset +0.15
  # 3 - do not include Pastick 00, Pastick 50, Pastick 90
  ggplot2::geom_segment(
    data = gather(a2_area_lrr.dat_tibble, measure, val, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Aalto - Baseline", "Aalto 50", "Aalto 70")) %>% 
      replace_na(list(val = 0)) %>%
      group_by(LRR.Name) %>% 
      summarise(start = range(val)[1], end = range(val)[2]) %>% 
      ungroup(),
    ggplot2::aes(x = start, xend = end, y = as.numeric(LRR.Name)+0.15, yend = as.numeric(LRR.Name)+0.15),
    color = "gray80", size = 0.5
  ) +
  
  # reshape the data frame & get min/max category values so you can draw the segment (this is another geom) for Aalto scenarios - offset +0.05
  # 4 - do not include Aalto - Baseline, Aalto 50, Aalto 70
  ggplot2::geom_segment(
    data = gather(a2_area_lrr.dat_tibble, measure, val, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Pastick - Baseline", "Pastick 50-59", "Pastick 90-99")) %>% 
      replace_na(list(val = 0)) %>%
      group_by(LRR.Name) %>% 
      summarise(start = range(val)[1], end = range(val)[2]) %>% 
      ungroup(),
    ggplot2::aes(x = start, xend = end, y = as.numeric(LRR.Name)+0.05, yend = as.numeric(LRR.Name)+0.05),
    color = "gray80", size = 0.5
  ) +

# reshape the data frame & plot the points for Pastick - offset +0.15
# 6 - do not include Pastick 00, Pastick 50, Pastick 90
ggplot2::geom_point(
  data = gather(a2_area_lrr.dat_tibble, measure, value, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Aalto - Baseline", "Aalto 50", "Aalto 70")),
  ggplot2::aes(value, as.numeric(LRR.Name)+0.15, color = factor(measure), fill = factor(measure), shape = factor(measure), size = factor(measure)), 
)+
  
  # extended the scale a bit + put axis on top; choose aesthetics that work for you
  scale_x_comma(position = "top", limits = c(0, 300000)) +
  scale_shape_manual(values = c(21, 21, 21, 21, 21, 21)) +
  scale_colour_manual(values = c("black", "black", "black", "black", "black", "black"), aesthetics = "colour") +
  scale_fill_manual(values = cols, aesthetics = "fill") +
  scale_size_manual(values = c(4,4,4,4,4,4)) +
  
  # reshape the data frame & plot the points for Aalto - offset +0.05
  # 7 - do not include Aalto Baseline, Aalto 50, Aalto 70
  ggplot2::geom_point(
    data = gather(a2_area_lrr.dat_tibble, measure, value, -c("X","LRR.Name","LRR.Symbol", "USDA - STATSGO", "USDA - gNATSGO", "Yi et al - Baseline", "Pastick - Baseline", "Pastick 50-59", "Pastick 90-99")),
    ggplot2::aes(value, as.numeric(LRR.Name)+0.05, color = factor(measure), fill = factor(measure), shape = factor(measure), size = factor(measure)), 
  )+
  
  # reshape the data frame & plot the baseline points in line with category label - offset -0.15
  # 9 - do not include STATSGO, gNATSGO, Yi
  ggplot2::geom_point(
    data = gather(a2_area_lrr.dat_tibble, measure, value, -c("X","LRR.Name","LRR.Symbol", "Pastick - Baseline", "Aalto - Baseline", "Pastick 50-59", "Pastick 90-99", "Aalto 50", "Aalto 70")),
    ggplot2::aes(value, as.numeric(LRR.Name)-0.15, color = factor(measure), fill = factor(measure), shape = factor(measure), size = factor(measure)), 
  )+
  scale_shape_manual(values = c(23, 23, 23, 21, 21, 21, 25, 25, 25)) +
  scale_colour_manual(values = c("black", "black", "black", "black", "black", "black","black", "black", "black"), aesthetics = "colour") +
  scale_fill_manual(values = c("#756bb1", "#bcbddc", "#efedf5", "#e6550d", "#fdae6b", "#fee6ce", "#969696", "#cccccc", "#f7f7f7"), aesthetics = "fill") +
  scale_size_manual(values = c(4,4,4,4,4,4,4,4,4)) +
  
  theme(axis.title.y=element_blank())+
  theme_ipsum_rc(base_family = "Arial", subtitle_family = if (.Platform$OS.type == "windows") "Roboto Condensed" else
    "Arial",caption_family = if (.Platform$OS.type == "windows") "Roboto Condensed" else
      "Arial",  grid = "X") +
  theme(legend.background = element_rect(fill="transparent",
                                         size=0.5, linetype="solid", 
                                         colour ="transparent"))+
  theme(legend.title=element_blank())+
  theme(legend.position = c(0.80, 0.65)) +
  theme(legend.key.size = unit(0.5, 'cm'))+
  theme(panel.border=element_rect(fill=NA),axis.title.y=element_blank())

# check output
p.high

# generate jpg
jpeg("./03-support-files/temp/Gelisol Dumbell LRR High Emission Test 27JUN2023.jpg",
     width=8*600,
     height=8*700,
     res=400,
     pointsize=8)

# quartz()
p.high


dev.off()


#----------  MODIFY PLOT MARGINS----------------

p.low_mod <- p.low +                    # Modify margins of first ggplot2 plot
  ggplot2::theme(#axis.text.x = ggplot2::element_blank(),
                 #axis.ticks.x = ggplot2::element_blank(),
                 #axis.title.x = ggplot2::element_blank(),
                 legend.position = "none",
                 # margins are listed in top, right, bottom, left
                 plot.margin = unit(c(0.5, 20, 0.5, 6.5), "pt"))

p.mod_mod <- p.mod +                    
  ggplot2::theme(axis.text.x = ggplot2::element_blank(),
                 axis.ticks.x = ggplot2::element_blank(),
                 axis.title.x = ggplot2::element_blank(),
                 legend.background = element_rect(fill = "white", size = 0.5, linetype = "solid", colour = "black"),
                 plot.margin = unit(c(0.5, 20, 0.5, 6.5), "pt"))
                 #plot.margin = unit(c(0, 5.5, 0, 5.5), "pt"))

p.high_mod <- p.high +                    # Modify margins of third ggplot2 plot
  ggplot2::theme(axis.text.x = ggplot2::element_blank(),
                 axis.ticks.x = ggplot2::element_blank(),
                 axis.title.x = ggplot2::element_blank(),
                 legend.position = "none",
                 #scale_x_discrete(position = "bottom"), 
                 plot.margin = unit(c(0.5, 20, 0.5, 6.5), "pt"))
                 #plot.margin = unit(c(0, 5.5, 0, 5.5), "pt"))

#---------- CREATE COMBINED PLOT!----------------
plot_grid(p.low_mod, p.mod_mod, p.high_mod, align = "v", nrow = 3, rel_heights = c(5/15, 5/15, 5/15))

# generate jpg
jpeg("./03-support-files/temp/All Gelisol Dumbell PLot by LRR 27JUN2023.jpg",
     width=8*600,
     height=8*700,
     res=400,
     pointsize=8)

# quartz()
plot_grid(p.low_mod, p.mod_mod, p.high_mod, align = "v", nrow = 3, rel_heights = c(5/15, 5/15, 5/15))


dev.off()


#---------- CREATE COMBINED PLOT! SKINNY ----------------
# generate jpg
jpeg("./02-output/a-figures/Figure 5 Dumbbell Plot by LRR.jpg",
     width=8*350,
     height=8*700,
     res=400,
     pointsize=8)

plot_grid(p.low_mod, p.mod_mod, p.high_mod, align = "v", nrow = 3, rel_heights = c(5/15, 5/15, 5/15))


dev.off()
