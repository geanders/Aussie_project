# this version takes in clean_aussie_data (5060 obs), filters out the 4 results
# that don't have locations, converts the UTM coords into lat-long, and ends up
# with a dataset called geo_aussie_data. 
library(tidyverse)
library(rgdal)
library(sp)
library(maptools)
library(ggmap)
#
# peeling out the geospatial information for plotting
#geo_data <- select(clean_aussie_data, sample_id, easting, northing, zone)
# filter out a few NAs
geo_data <- subset(clean_aussie_data, easting != "" | northing != "")
# the geo_data is in UTM coordinates, need to convert to lat-long
# the lat-long conversion requires that the data be split between the UTM
# zones.  In this case, 52S and 53S.  From here on everything is split.
geo_data_52 <- subset(geo_data, zone == "52S")
geo_data_53 <- subset(geo_data, zone == "53S")
coords_52 <- cbind(Easting = as.numeric(as.character(geo_data_52$easting)),
                Northing = as.numeric(as.character(geo_data_52$northing)))
coords_53 <- cbind(Easting = as.numeric(as.character(geo_data_53$easting)),
                   Northing = as.numeric(as.character(geo_data_53$northing)))
# Create the SpatialPointsDataFrame
spatial_52 <- SpatialPointsDataFrame(coords_52, data = 
                                         data.frame(geo_data_52$entry_num), 
                                       proj4string = CRS("+init=epsg:32752"))
spatial_53 <- SpatialPointsDataFrame(coords_53, data = 
                                            data.frame(geo_data_53$entry_num), 
                                          proj4string = CRS("+init=epsg:32753"))

# Convert to Lat Long
# Convert from Eastings and Northings to Latitude and Longitude
spatial_52_ll <- spTransform(spatial_52, CRS("+init=epsg:4326"))
spatial_53_ll <- spTransform(spatial_53, CRS("+init=epsg:4326"))

# we also need to rename the columns 
colnames(spatial_52_ll@coords)[colnames(spatial_52_ll@coords) == "Easting"]<- "Longitude" 
colnames(spatial_52_ll@coords)[colnames(spatial_52_ll@coords) == "Northing"]<- "Latitude"
colnames(spatial_53_ll@coords)[colnames(spatial_53_ll@coords) == "Easting"]<- "Longitude" 
colnames(spatial_53_ll@coords)[colnames(spatial_53_ll@coords) == "Northing"]<- "Latitude"
#
#  re-merge the data
geo_data_52_ll <- as.data.frame(spatial_52_ll)
geo_data_52_ll <- rename(geo_data_52_ll, entry_num = geo_data_52.entry_num)
geo_data_53_ll <- as.data.frame(spatial_53_ll)
geo_data_53_ll <- rename(geo_data_53_ll, entry_num = geo_data_53.entry_num)

# recombine
geo_data_ll <- rbind(geo_data_52_ll, geo_data_53_ll)
#geo_data_ll$entry_num <- as.character(geo_data_ll$entry_num)
geo_aussie_data <- left_join(geo_data_ll, clean_aussie_data, by = "entry_num")

# drop no-longer-needed geospatial data
#geo_aussie_data <- select(-easting, -northing, -zone)

northern_terr <- get_map("Darwin", zoom = 7,
                     source = "stamen", maptype = "toner")
c <- ggmap(northern_terr, extent = "device") +
  geom_point(data = geo_data_ll,
             aes(x = Longitude, y = Latitude), 
             size = .5, color = "red", alpha = 0.25)
c

