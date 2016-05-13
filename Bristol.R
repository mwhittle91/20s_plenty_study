install.packages("rgdal")
install.packages("geojsonio")
library(rgdal)
library(geojsonio)


# Read in the incident data - requires read-stats19.R to be run first to create
# ac and ca
incidents <- merge(ac, ca)

# Eliminate any NA and null values, required to map coords
incidents_clean <- incidents[complete.cases(incidents),]

# Re assign incidents and create SPDF to hold data and ensure it uses WGS84 projection
incidents <- SpatialPointsDataFrame(incidents_clean[,c(4,5)], incidents_clean[,-c(4,5)])
proj4string(incidents) <- CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs")

# load the area of interest and ensure it  uses WGS84 projection
Bristol_area <- geojson_read(x = "data/Bristol/outline.geojson", what = "sp")
spTransform(Bristol_area, CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs"))

#load the 20mph roads for the UK and ensure it uses WGS84 projeciton 
UK_20mph_roads <-  geojson_read(x = "data/20.geojson", what = "sp")
spTransform(UK_20mph_roads, CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs"))

# clip to show the incidents of interest and roads of interest
Bristol_Incidents <- incidents[Bristol_area,]
Bristol_20mph_roads <- UK_20mph_roads[Bristol_area,]

## Begin to subset the data 

# find the zones that have been implemented and assign
zone_1 <- Bristol_area[Bristol_area@data$implement == 92010,]
spTransform(zone_1,CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs"))
zone_2 <- Bristol_area[Bristol_area@data$implement == 12014,]
spTransform(zone_2,CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs"))
zone_3 <- Bristol_area[Bristol_area@data$implement == 72014,]
spTransform(zone_2,CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs"))
zone_4 <- Bristol_area[Bristol_area@data$implement == 92014,]
spTransform(zone_2,CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs"))

#Find all the incidents within the set zone
zone_1_incidents <- incidents[zone_1,]
zone_2_incidents <- incidents[zone_2,]
zone_3_incidents <- incidents[zone_3,]
zone_4_incidents <- incidents[zone_4,]

#Find all the 20 mph roads in the set zone 
zone_1_20roads <- Bristol_20mph_roads[zone_1,]
zone_2_20roads <- Bristol_20mph_roads[zone_2,]
zone_3_20roads <- Bristol_20mph_roads[zone_3,]
zone_4_20roads <- Bristol_20mph_roads[zone_4,]

# Create a date to test the incidents against
z_1_date <- as.Date('2010-09-01')
z_2_date <- as.Date('2014-01-01')
z_3_date <- as.Date('2014-07-01')
z_4_date <- as.Date('2014-09-01')

# Find all the incidents before the 20mph implementation 
zone_1_incidents_pre <- subset(zone_1_incidents, z_1_date > zone_1_incidents@data$Date )
zone_2_incidents_pre <- subset(zone_2_incidents, z_2_date > zone_2_incidents@data$Date )
zone_3_incidents_pre <- subset(zone_3_incidents, z_3_date > zone_3_incidents@data$Date )
zone_4_incidents_pre <- subset(zone_4_incidents, z_4_date > zone_4_incidents@data$Date )

# Find all the incidents after the 20mph implementation 
zone_1_incidents_post <- subset(zone_1_incidents, z_1_date < zone_1_incidents@data$Date )
zone_2_incidents_post <- subset(zone_2_incidents, z_2_date < zone_2_incidents@data$Date )
zone_3_incidents_post <- subset(zone_3_incidents, z_3_date < zone_3_incidents@data$Date )
zone_4_incidents_post <- subset(zone_4_incidents, z_4_date < zone_4_incidents@data$Date )

# amalgamte the before and after data and zones of inteterst
before <- rbind(zone_4_incidents_pre, zone_3_incidents_pre, zone_2_incidents_pre, zone_1_incidents_pre)
after <- rbind(zone_4_incidents_post, zone_3_incidents_post, zone_2_incidents_post, zone_1_incidents_post)
zones <- rbind(zone_1, zone_2, zone_3, zone_4)

# plot the output
plot(Bristol_area)
plot(zones, col = "grey", add = TRUE)
plot(before, col = "red", add = TRUE)
plot(after, col = "blue", add = TRUE)

# Find the max and min date in the before data
b_max<- with(before, max(before@data$Date))
b_max_z1 <- with(zone_1_incidents_pre, max(zone_1_incidents_pre@data$Date))
b_max_z2 <- with(zone_2_incidents_pre, max(zone_2_incidents_pre@data$Date))
b_max_z3 <- with(zone_3_incidents_pre, max(zone_3_incidents_pre@data$Date))
b_max_z4 <- with(zone_4_incidents_pre, max(zone_4_incidents_pre@data$Date))

b_min <- with(before, min(before@data$Date))
b_min_z1 <- with(zone_1_incidents_pre, min(zone_1_incidents_pre@data$Date))
b_min_z2 <- with(zone_2_incidents_pre, min(zone_2_incidents_pre@data$Date))
b_min_z3 <- with(zone_3_incidents_pre, min(zone_3_incidents_pre@data$Date))
b_min_z4 <- with(zone_4_incidents_pre, min(zone_4_incidents_pre@data$Date))

# Find the max and min in the after data
a_max<- with(after, max(after@data$Date))
a_max_z1 <- with(zone_1_incidents_post, max(zone_1_incidents_post@data$Date))
a_max_z2 <- with(zone_2_incidents_post, max(zone_2_incidents_post@data$Date))
a_max_z3 <- with(zone_3_incidents_post, max(zone_3_incidents_post@data$Date))
a_max_z4 <- with(zone_4_incidents_post, max(zone_4_incidents_post@data$Date))

a_min <- with(after, min(after@data$Date))
a_min_z1 <- with(zone_1_incidents_post, min(zone_1_incidents_post@data$Date))
a_min_z2 <- with(zone_2_incidents_post, min(zone_2_incidents_post@data$Date))
a_min_z3 <- with(zone_3_incidents_post, min(zone_3_incidents_post@data$Date))
a_min_z4 <- with(zone_4_incidents_post, min(zone_4_incidents_post@data$Date))


# Find the difference between each set of dates
b_diff_date <-  b_max - b_min
b_diff_date_z1 <- b_max_z1 - b_min_z1
b_diff_date_z2 <- b_max_z2 - b_min_z2
b_diff_date_z3 <- b_max_z3 - b_min_z3
b_diff_date_z4 <- b_max_z4 - b_min_z4

a_diff_date <- a_max - a_min
a_diff_date_z1 <- a_max_z1 - a_min_z1
a_diff_date_z2 <- a_max_z2 - a_min_z2
a_diff_date_z3 <- a_max_z3 - a_min_z3
a_diff_date_z4 <- a_max_z4 - a_min_z4


#convert to numeric data
b_diff_date <- as.numeric(b_diff_date)
b_diff_date_z1 <- as.numeric(b_diff_date_z1)
b_diff_date_z2 <- as.numeric(b_diff_date_z2)
b_diff_date_z3 <- as.numeric(b_diff_date_z3)
b_diff_date_z4 <- as.numeric(b_diff_date_z4)

a_diff_date <- as.numeric(a_diff_date)
a_diff_date_z1 <- as.numeric(a_diff_date_z1)
a_diff_date_z2 <- as.numeric(a_diff_date_z2)
a_diff_date_z3 <- as.numeric(a_diff_date_z3)
a_diff_date_z4 <- as.numeric(a_diff_date_z4)

before_incidents <- as.numeric(nrow(before))
before_incidents_z1 <- as.numeric(nrow(zone_1_incidents_pre))
before_incidents_z2 <- as.numeric(nrow(zone_2_incidents_pre))
before_incidents_z3 <- as.numeric(nrow(zone_3_incidents_pre))
before_incidents_z4 <- as.numeric(nrow(zone_4_incidents_pre))

after_incidents <- as.numeric(nrow(after))
after_incidents_z1 <- as.numeric(nrow(zone_1_incidents_post))
after_incidents_z2 <- as.numeric(nrow(zone_2_incidents_post))
after_incidents_z3 <- as.numeric(nrow(zone_3_incidents_post))
after_incidents_z4 <- as.numeric(nrow(zone_4_incidents_post))

before_rate <- before_incidents/b_diff_date
before_rate_z1 <- before_incidents_z1/b_diff_date_z1
before_rate_z2 <- before_incidents_z1/b_diff_date_z2
before_rate_z3 <- before_incidents_z1/b_diff_date_z3
before_rate_z4 <- before_incidents_z1/b_diff_date_z4
b_rate <- c(before_rate_z4,before_rate_z3,before_rate_z2,before_rate_z1, before_rate)


after_rate <- after_incidents/a_diff_date
after_rate_z1 <- after_incidents_z1/a_diff_date_z1
after_rate_z2 <- after_incidents_z2/a_diff_date_z2
after_rate_z3 <- after_incidents_z3/a_diff_date_z3
after_rate_z4 <- after_incidents_z4/a_diff_date_z4
a_rate <- c(after_rate_z4,after_rate_z3,after_rate_z2,after_rate_z1, after_rate)

zone_labels = c("Z1", "Z2", "Z3", "Z4", "AllZs")
rates <- data.frame( b_rate, a_rate)
rates

barplot(as.matrix(rates), beside = TRUE, col = heat.colors(5), names.arg = c("before", "after"))
legend("topright", zone_labels, pch=15, col=heat.colors(5), bty="n")


