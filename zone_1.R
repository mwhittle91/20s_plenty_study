## look at the incidents 3 months either side of the installation date for zone_1

# create dates to test agains
z_1_minus_3 <- seq(z_1_date, length = 2, by = "-3 months")[2]
z_1_plus_3 <- seq(z_1_date, length = 2, by = "+3 months")[2]

# find the required incidents
z_1_pre_3months <- subset(zone_1_incidents_pre,  z_1_minus_3 < zone_1_incidents_pre@data$Date)
z_1_post_3months <- subset(zone_1_incidents_post,  z_1_plus_3 > zone_1_incidents_post@data$Date)

before_drop <- z_1_pre_3months[,-(10)]
after_drop <- z_1_post_3months[-(10)]
geojson_write(before_drop, geometry = "point", file = "before.geojson")
geojson_write(after_drop, geometry = "point", file = "after.geojson")


# how many incidents in each subset
z1_3months_before <- as.numeric(nrow(z_1_pre_3months))
z1_3months_after <- as.numeric(nrow(z_1_post_3months))
dat<- c((z1_3months_before/(as.numeric(z_1_date)-as.numeric(z_1_minus_3))), z1_3months_after/(as.numeric(z_1_plus_3)-as.numeric(z_1_date)))

par(mfrow = c(1,1))
barplot(dat,width = 1)


par(mfrow = c(1,2))
barplot(as.matrix(rates), beside = TRUE, col = heat.colors(5), names.arg = c("before", "after"))
barplot(as.matrix(at_rates), beside = TRUE, col = heat.colors(5), names.arg = c("before", "after"))
