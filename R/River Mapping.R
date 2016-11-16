library(tidyverse)
library("rgdal")
library("maptools")
library("ggplot2")
library("plyr")
library(broom)
library(foreign)
library("maptools")

###For the river lines
<<<<<<< HEAD:River Data/River Mapping.R
rivershape<-readShapeLines("AUS_water_lines_dcw", proj4string=CRS("+proj=longlat"))
rivershape@coords$<-
river<-tidy(rivershape)
=======
river<-readShapeLines("River Data/AUS_water_lines_dcw", proj4string=CRS("+proj=longlat"))
river<-tidy(river)
>>>>>>> eec441f363f26d54c622e73d8062544962218971:R/River Mapping.R
 river<-filter(river,river$lat < -12 & river$lat > -13.7)
  river<-filter(river,river$long < 133.5 & river$long > 132.2)
  river$id<-as.double(river$id)
  
 #For the River mouth
<<<<<<< HEAD:River Data/River Mapping.R
rivermouthshape<-readShapeLines("AUS_water_areas_dcw.shp", proj4string=CRS("+proj=longlat"))
rivermouth<-tidy(rivermouthshape)
=======
rivermouth<-readShapeLines("River Data/AUS_water_areas_dcw.shp", proj4string=CRS("+proj=longlat"))
rivermouth<-tidy(rivermouth)
>>>>>>> eec441f363f26d54c622e73d8062544962218971:R/River Mapping.R
  rivermouth<-filter(rivermouth, rivermouth$lat < -12 & rivermouth$lat > -12.75)
  rivermouth<-filter(rivermouth, rivermouth$long < 133 & rivermouth$long > 132.4)


library(leaflet)
  leaflet()%>%
    addProviderTiles("Stamen.Watercolor")%>%
    addPolylines(data=rivershape)%>%
 addPolylines(data=rivermouthshape)%>%
     addMarkers(data=geo_data_ll)
  


  