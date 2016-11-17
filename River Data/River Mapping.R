library(tidyverse)
library("rgdal")
library("maptools")
library("ggplot2")
library("plyr")
library(broom)
library(foreign)
library("maptools")
library(leaflet)

###For the river lines
rivershape<-readShapeLines("River Data/AUS_water_lines_dcw", proj4string=CRS("+proj=longlat"))
<<<<<<< HEAD
ex_map<-rivershape[str_detect(rivershape@data$NAM, "ALLIGATOR"), ]


rivershape@bbox[1,1] <- 130
rivershape@bbox[1,2] <- 135
rivershape@bbox[2,1] <- -14
rivershape@bbox[2,2] <- -11
=======

>>>>>>> d3ceeefd0922a27ed9264c47bec9ddb2ecf88274
  
river<-tidy(rivershape)
 river<-filter(river,river$lat < -12 & river$lat > -13.7)
  river<-filter(river,river$long < 133.5 & river$long > 132.2)
  river$id<-as.double(river$id)
  
 #For the River mouth
rivermouthshape<-readShapeLines("River Data/AUS_water_areas_dcw.shp", proj4string=CRS("+proj=longlat"))
ex_mouthmap<-rivermouthshape[str_detect(rivermouthshape@data$NAM, "ALLIGATOR"), ]


rivermouthshape@bbox[1,1]<-130
rivermouthshape@bbox[1,2]<-135
rivermouthshape@bbox[2,1]<- -14
rivermouthshape@bbox[2,2]<- -11

rivermouth<-tidy(rivermouthshape)
  rivermouth<-filter(rivermouth, rivermouth$lat < -12 & rivermouth$lat > -12.75)
  rivermouth<-filter(rivermouth, rivermouth$long < 133 & rivermouth$long > 132.4)


library(leaflet)
  leaflet()%>%
    addProviderTiles("Stamen.Watercolor")%>%
  addPolylines(data=ex_map)%>%
 addPolylines(data=ex_mouthmap, fillColor = "#0000FF")%>%
     addCircleMarkers(data=geo_data_ll, radius=.1)
  


  