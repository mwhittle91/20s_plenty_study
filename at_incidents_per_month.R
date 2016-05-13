head(zone_1_incidents$Date)
class(zone_1_incidents$Date)

library(lubridate)

# zone 1 histogram
y = year(at_z1$Date)
y = y - 2005
ym = y * 12
m = month(at_z1$Date)
ym = ym + m

intervention_date = 12* 5 + 9

ym = ym - intervention_date

at_z_1_hist <- hist(ym, breaks = seq(from = -69, to = 51, by = 6))


# zone 2 histogram
y = year(at_z2$Date)
y = y - 2005
ym = y * 12
m = month(at_z2$Date)
ym = ym + m

intervention_date = 12* 9 + 1

ym = ym - intervention_date

at_z_2_hist<- hist(ym, breaks = seq(from = -109, to = 12, by = 6))


# zone 3 histogram
y = year(at_z3$Date)
y = y - 2005
ym = y * 12
m = month(at_z3$Date)
ym = ym + m

intervention_date = 12* 9 + 7

ym = ym - intervention_date

at_z_3_hist <- hist(ym, breaks = seq(from = -115, to = 5, by = 6))

# zone 4 histogram
y = year(at_z4$Date)
y = y - 2005
ym = y * 12
m = month(at_z4$Date)
ym = ym + m

intervention_date = 12* 9 + 9

ym = ym - intervention_date

at_z_4_hist <- hist(ym, breaks = seq(from = -117, to = 3, by = 6))

# all zones 

# zone 4 histogram
y = year(Bristol_act_travel$Date)
y = y - 2005
ym = y * 12

max(ym)

at_all_hist<- hist(ym, breaks = seq(from = 0, to = 108, by = 12))

par(mfrow = c(2,2))
plot(at_z_1_hist, main = "Zone 1")
plot(at_z_2_hist, main = "Zone 2") 
plot(at_z_3_hist, main = "Zone 3")
plot(at_z_4_hist, main = "Zone 4")
