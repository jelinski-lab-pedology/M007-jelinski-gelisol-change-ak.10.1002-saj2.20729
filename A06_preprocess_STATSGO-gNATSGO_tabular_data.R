#---------- Pre-Process/Shape STATSGO Tabular data ----------

# subset the STATSGO component table to fields relevant for this analysis
comp_statsgo_small = subset(comp_statsgo, select=c("comppct_r", "compname", "compkind","drainagecl","taxclname","taxorder","taxsuborder", "taxgrtgroup","taxsubgrp","taxpartsize","taxtempregime","mukey","cokey"))
head(comp_statsgo_small)

# inspect and remove miscellaneous area components - note that this leaves comp_pct_r for some map units < 100, so eventually will re-weight (in a later script)
# trying to remove water here from statsgo comp table. have to search on compname. This worked in removing water. Changing to take out ANYTHING miscellaneous. Here is what you need to do to change back if you want: comp_statsgo_small_nowater = comp_statsgo_small[!grepl("water",comp_statsgo_small$compname),]. Justification for removing miscellaneous - 1) First of all, the miscellaneous areas don't have any classification. 2) you are masking with Pastick which is much more detailed and better than statsgo miscellaneous components.
# Here is what those miscellaneous areas are
unique(comp_statsgo_small$compkind)
unique(comp_statsgo_small$compname[comp_statsgo_small$compkind=="Miscellaneous area"])
# create list of the unique compnames for miscellaneous regardless of region (because many of these names are duplicated across regions: see here.
unique(comp_statsgo_small$compname)
# this splits compname into two parts, returning everything after the first space. decided to use str_split instead of str_extract
# str_extract(comp_statsgo_small$compname, "\\s+.+$")
str_split(comp_statsgo_small$compname, " ", n = 2, simplify = T)[,2]
# Now get unique just in that for miscellaneous areas only:
unique(str_split(comp_statsgo_small$compname, " ", n = 2, simplify = T)[,2][comp_statsgo_small$compkind=="Miscellaneous area"])
# The "land" that was returned there was "Urban land"
# so this basically contains "rock outcrop and rubbleland", "riverwash", "water", "dunes", "tidal flats", "cinderland and lava flows", "beaches, gravelly", "ice and permanent snowfields", "Urban Land", "cinder land"
comp_statsgo_small_nomisc = comp_statsgo_small[!grepl("Miscellaneous",comp_statsgo_small$compkind),]
head(comp_statsgo_small_nomisc)

# FINAL PROCESSING: Note - there is a single component record in the STATSGO tabular data where the "taxsuborder" field is incorrect. The component is a Gelisol (coded correctly in "taxorder" and a Historthel coded correctly in the "taxgrtgroup"), however the data for the suborder is "Aquepts" in the "taxsuborder" field. This cuases a very slight deviation between the derived STATSGO gelisol prevalence raster and the suborder sum to create a gelisols order prevalence raster. Here I am fixing that single entry before writing out the field. The component in question is 14278371.It is in row number 1050 of the comp_statsgo_small_nomisc table. 
comp_statsgo_small_nomisc[comp_statsgo_small_nomisc$cokey==14278371,"taxsuborder"] = "Orthels"
#OR
comp_statsgo_small_nomisc$taxsuborder[1050] = "Orthels"
  
# write.csv(comp_statsgo_small_nomisc, "comp_statsgo_small_nomisc.csv")


#---------- Pre-Process/Shape gNATSGO Tabular data----------

# subset the gNATSGO component table to fields relevant for this analysis
comp_gnatsgo_small = subset(comp_gnatsgo, select=c("comppct_r", "compname", "compkind","drainagecl","taxclname","taxorder","taxsuborder", "taxgrtgroup","taxsubgrp","taxpartsize","taxtempregime","mukey","cokey"))
head(comp_gnatsgo_small)
unique(comp_statsgo_small$compkind)

# inspect and remove miscellaneous area components - note that this leaves comp_pct_r for some map units < 100, so eventually will re-weight (in a later script)
unique(comp_gnatsgo_small$compkind)
unique(comp_gnatsgo_small$compname[comp_gnatsgo_small$compkind=="Miscellaneous area"])
# Want to basically have a list of the unique compnames for miscellaneous regardless of region (because many of these names are duplicated across regions: see here.
unique(comp_gnatsgo_small$compname)
# this splits compname into two parts, returning everything after the first space. decided to use str_split instead of str_extract
# str_extract(comp_statsgo_small$compname, "\\s+.+$")
str_split(comp_gnatsgo_small$compname, " ", n = 2, simplify = T)[,2]
# Now get unique just in that for miscellaneous areas only:
unique(str_split(comp_gnatsgo_small$compname, " ", n = 2, simplify = T)[,2][comp_gnatsgo_small$compkind=="Miscellaneous area"])
# The "land" that was returned there was "Urban land"
# so this basically contains "rock outcrop and rubbleland", "riverwash", "water", "dunes", "tidal flats", "cinderland and lava flows", "beaches, gravelly", "ice and permanent snowfields", "Urban Land", "cinder land"
comp_gnatsgo_small_nomisc = comp_gnatsgo_small[!grepl("Miscellaneous",comp_gnatsgo_small$compkind),]
head(comp_gnatsgo_small_nomisc)

# write.csv(comp_gnatsgo_small_nomisc, "comp_gnatsgo_small_nomisc.csv")
