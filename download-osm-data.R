install.packages("osmplotr")
install.packages("tmap")
install.packages("rgdal")
install.packages("sp")
install.packages("mapview")
install.packages("geojsonio")
library(osmplotr)
library(tmap)
library(sp)
library(geojsonio)

?osmplotr
b = bb("UK")
class(b)
#b = as.vector(b)
#class(b)
h = extract_osm_objects(key = "highway", bbox =  b, extra_pairs = c("maxspeed", "20"))
h60 = extract_osm_objects(key = "highway", bbox =  b, extra_pairs = c("maxspeed", "60"))
summary(h)
h = h$obj
plot(h60$obj)
plot(h)
mapview::mapview(h)

geojson_write(h, file = "data/UK-20mphzones.geojson")

