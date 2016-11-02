library(rgdal)
library(sp)
library(maptools)
#
# peeling out the geospatial information for plotting
geo_data <- select(clean_aussie_data, sample_id, easting, northing, zone)
# filter out a few NAs
geo_data <- subset(geo_data, easting != "" | northing != "")
#adding some id numbers (may not need these)
geo_data$entry_num <- 1:nrow(geo_data)
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
                                         data.frame(geo_data_52$sample_id,
                                        geo_data_52$entry_num), 
                                       proj4string = CRS("+init=epsg:32752"))
spatial_53 <- SpatialPointsDataFrame(coords_53, data = 
                                            data.frame(geo_data_53$sample_id,
                                                       geo_data_53$entry_num), 
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
# tried a number of things to re-merge the data, but gave up
#spatial_ll <- spRbind(test_spatial_52_ll, test_spatial_53_ll)
#some plots x and y bounds picked off google maps to give some room
y_bounds <- c(-15.5777440, -10.808605)
x_bounds <- c(128.915038, 134.184663)
plot_52 <- plot(spatial_52_ll, xlim = x_bounds, ylim = y_bounds )
plot_53 <- plot(spatial_53_ll, xlim = x_bounds, ylim = y_bounds, add=TRUE )
oz(add = TRUE)