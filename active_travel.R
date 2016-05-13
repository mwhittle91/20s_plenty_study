act_travel <- subset(Bristol_Incidents , incidents@data$Casualty_Type == 'Cyclist' | incidents@data$Casualty_Type == 'Pedestrian')

Bristol_act_travel <- act_travel[Bristol_area,]
plot(Bristol_act_travel)
plot(Bristol_area, add = TRUE)


at_z1 <- Bristol_act_travel[zone_1,]
at_z2 <- Bristol_act_travel[zone_2,]
at_z3 <- Bristol_act_travel[zone_3,]
at_z4 <- Bristol_act_travel[zone_4,]


# Find all the incidents before the 20mph implementation 
at_zone_1_incidents_pre <- subset(at_z1, z_1_date > at_z1@data$Date )
at_zone_2_incidents_pre <- subset(at_z2, z_2_date > at_z2@data$Date )
at_zone_3_incidents_pre <- subset(at_z3, z_3_date > at_z3@data$Date )
at_zone_4_incidents_pre <- subset(at_z4, z_4_date > at_z4@data$Date )

# Find all the incidents after the 20mph implementation 
at_zone_1_incidents_post <- subset(at_z1, z_1_date < at_z1@data$Date )
at_zone_2_incidents_post <- subset(at_z2, z_2_date < at_z2@data$Date )
at_zone_3_incidents_post <- subset(at_z3, z_3_date < at_z3@data$Date )
at_zone_4_incidents_post <- subset(at_z4, z_4_date < at_z4@data$Date )

# amalgamte the before and after data and zones of inteterst
at_before <- rbind(at_zone_4_incidents_pre, at_zone_3_incidents_pre, at_zone_2_incidents_pre, at_zone_1_incidents_pre)
at_after <- rbind(at_zone_4_incidents_post, at_zone_3_incidents_post, at_zone_2_incidents_post, at_zone_1_incidents_post)


# plot the output
plot(Bristol_area)
plot(zones, col = "grey", add = TRUE)
plot(at_before, col = "red", add = TRUE)
plot(at_after, col = "blue", add = TRUE)

# Find the max and min date in the before data
at_b_max<- with(at_before, max(at_before@data$Date))
at_b_max_z1 <- with(at_zone_1_incidents_pre, max(at_zone_1_incidents_pre@data$Date))
at_b_max_z2 <- with(at_zone_2_incidents_pre, max(at_zone_2_incidents_pre@data$Date))
at_b_max_z3 <- with(at_zone_3_incidents_pre, max(at_zone_3_incidents_pre@data$Date))
at_b_max_z4 <- with(at_zone_4_incidents_pre, max(at_zone_4_incidents_pre@data$Date))

at_b_min <- with(at_before, min(at_before@data$Date))
at_b_min_z1 <- with(at_zone_1_incidents_pre, min(at_zone_1_incidents_pre@data$Date))
at_b_min_z2 <- with(at_zone_2_incidents_pre, min(at_zone_2_incidents_pre@data$Date))
at_b_min_z3 <- with(at_zone_3_incidents_pre, min(at_zone_3_incidents_pre@data$Date))
at_b_min_z4 <- with(at_zone_4_incidents_pre, min(at_zone_4_incidents_pre@data$Date))

# Find the max and min in the after data
at_a_max<- with(at_after, max(at_after@data$Date))
at_a_max_z1 <- with(at_zone_1_incidents_post, max(at_zone_1_incidents_post@data$Date))
at_a_max_z2 <- with(at_zone_2_incidents_post, max(at_zone_2_incidents_post@data$Date))
at_a_max_z3 <- with(at_zone_3_incidents_post, max(at_zone_3_incidents_post@data$Date))
at_a_max_z4 <- with(at_zone_4_incidents_post, max(at_zone_4_incidents_post@data$Date))

at_a_min <- with(at_after, min(after@data$Date))
at_a_min_z1 <- with(at_zone_1_incidents_post, min(at_zone_1_incidents_post@data$Date))
at_a_min_z2 <- with(at_zone_2_incidents_post, min(at_zone_2_incidents_post@data$Date))
at_a_min_z3 <- with(at_zone_3_incidents_post, min(at_zone_3_incidents_post@data$Date))
at_a_min_z4 <- with(at_zone_4_incidents_post, min(at_zone_4_incidents_post@data$Date))


# Find the difference between each set of dates
at_b_diff_date <-  at_b_max - at_b_min
at_b_diff_date_z1 <- at_b_max_z1 - at_b_min_z1
at_b_diff_date_z2 <- at_b_max_z2 - at_b_min_z2
at_b_diff_date_z3 <- at_b_max_z3 - at_b_min_z3
at_b_diff_date_z4 <- at_b_max_z4 - at_b_min_z4

at_a_diff_date <- at_a_max - at_a_min
at_a_diff_date_z1 <- at_a_max_z1 - at_a_min_z1
at_a_diff_date_z2 <- at_a_max_z2 - at_a_min_z2
at_a_diff_date_z3 <- at_a_max_z3 - at_a_min_z3
at_a_diff_date_z4 <- at_a_max_z4 - at_a_min_z4


#convert to numeric data
at_b_diff_date <- as.numeric(at_b_diff_date)
at_b_diff_date_z1 <- as.numeric(at_b_diff_date_z1)
at_b_diff_date_z2 <- as.numeric(at_b_diff_date_z2)
at_b_diff_date_z3 <- as.numeric(at_b_diff_date_z3)
at_b_diff_date_z4 <- as.numeric(at_b_diff_date_z4)

at_a_diff_date <- as.numeric(at_a_diff_date)
at_a_diff_date_z1 <- as.numeric(at_a_diff_date_z1)
at_a_diff_date_z2 <- as.numeric(at_a_diff_date_z2)
at_a_diff_date_z3 <- as.numeric(at_a_diff_date_z3)
at_a_diff_date_z4 <- as.numeric(at_a_diff_date_z4)

at_before_incidents <- as.numeric(nrow(at_before))
at_before_incidents_z1 <- as.numeric(nrow(at_zone_1_incidents_pre))
at_before_incidents_z2 <- as.numeric(nrow(at_zone_2_incidents_pre))
at_before_incidents_z3 <- as.numeric(nrow(at_zone_3_incidents_pre))
at_before_incidents_z4 <- as.numeric(nrow(at_zone_4_incidents_pre))

at_after_incidents <- as.numeric(nrow(at_after))
at_after_incidents_z1 <- as.numeric(nrow(at_zone_1_incidents_post))
at_after_incidents_z2 <- as.numeric(nrow(at_zone_2_incidents_post))
at_after_incidents_z3 <- as.numeric(nrow(at_zone_3_incidents_post))
at_after_incidents_z4 <- as.numeric(nrow(at_zone_4_incidents_post))

at_before_rate <- at_before_incidents/at_b_diff_date
at_before_rate_z1 <- at_before_incidents_z1/at_b_diff_date_z1
at_before_rate_z2 <- at_before_incidents_z1/at_b_diff_date_z2
at_before_rate_z3 <- at_before_incidents_z1/at_b_diff_date_z3
at_before_rate_z4 <- at_before_incidents_z1/at_b_diff_date_z4
at_b_rate <- c(at_before_rate_z4,at_before_rate_z3,at_before_rate_z2,at_before_rate_z1, at_before_rate)


at_after_rate <- at_after_incidents/at_a_diff_date
at_after_rate_z1 <- at_after_incidents_z1/at_a_diff_date_z1
at_after_rate_z2 <- at_after_incidents_z2/at_a_diff_date_z2
at_after_rate_z3 <- at_after_incidents_z3/at_a_diff_date_z3
at_after_rate_z4 <- at_after_incidents_z4/at_a_diff_date_z4
at_a_rate <- c(at_after_rate_z4,at_after_rate_z3,at_after_rate_z2,at_after_rate_z1, at_after_rate)

zone_labels = c("Z1", "Z2", "Z3", "Z4", "AllZs")
at_rates <- data.frame( at_b_rate, at_a_rate)
at_rates

act_travel_plot <- barplot(as.matrix(at_rates), beside = TRUE, col = heat.colors(5), names.arg = c("before", "after"))
legend("topright", zone_labels, pch=15, col=heat.colors(5), bty="n")


