## look at the incidents 3 months either side of the installation date for zone_1

# create dates to test agains
z_1_minus_3 <- seq(z_1_date, length = 2, by = "-3 months")[2]
z_1_plus_3 <- seq(z_1_date, length = 2, by = "+3 months")[2]

# find the required incidents
z_1_pre_3months <- subset(zone_1_incidents_pre,  z_1_minus_3 < zone_1_incidents_pre@data$Date)
z_1_post_3months <- subset(zone_1_incidents_pre,  z_1_plus_3 > zone_1_incidents_post@data$Date)

# how many incidents in each subset
z1_3months_before <- as.numeric(nrow(z_1_pre_3months))
z1_3months_after <- as.numeric(nrow(z_1_post_3months))
