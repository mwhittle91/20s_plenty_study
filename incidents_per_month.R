head(zone_1_incidents$Date)
class(zone_1_incidents$Date)

library(lubridate)

# zone 1 histogram
y = year(zone_1_incidents$Date)
y = y - 2005
ym = y * 12
m = month(zone_1_incidents$Date)
ym = ym + m

intervention_date = 12* 5 + 9

ym = ym - intervention_date

hist(ym, breaks = seq(from = -69, to = 51, by = 6))


# zone 2 histogram
y = year(zone_2_incidents$Date)
y = y - 2005
ym = y * 12
m = month(zone_2_incidents$Date)
ym = ym + m

intervention_date = 12* 9 + 1

ym = ym - intervention_date

hist(ym, breaks = seq(from = -109, to = 12, by = 6))


# zone 3 histogram
y = year(zone_3_incidents$Date)
y = y - 2005
ym = y * 12
m = month(zone_3_incidents$Date)
ym = ym + m

intervention_date = 12* 9 + 7

ym = ym - intervention_date

hist(ym, breaks = seq(from = -115, to = 5, by = 6))

# zone 4 histogram
y = year(zone_4_incidents$Date)
y = y - 2005
ym = y * 12
m = month(zone_4_incidents$Date)
ym = ym + m

intervention_date = 12* 9 + 9

ym = ym - intervention_date

hist(ym, breaks = seq(from = -117, to = 3, by = 6))

# all zones 

# zone 4 histogram
y = year(incidents$Date)
y = y - 2005
ym = y * 12

max(ym)

hist(ym, breaks = seq(from = 0, to = 108, by = 12))






