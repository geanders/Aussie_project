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

  
river<-tidy(rivershape)
 river<-filter(river,river$lat < -12 & river$lat > -13.7)
  river<-filter(river,river$long < 133.5 & river$long > 132.2)
  river$id<-as.double(river$id)
  
 #For the River mouth
rivermouthshape<-readShapeLines("AUS_water_areas_dcw.shp", proj4string=CRS("+proj=longlat"))
rivermouth<-tidy(rivermouthshape)
  rivermouth<-filter(rivermouth, rivermouth$lat < -12 & rivermouth$lat > -12.75)
  rivermouth<-filter(rivermouth, rivermouth$long < 133 & rivermouth$long > 132.4)


library(leaflet)
  leaflet()%>%
    addProviderTiles("Stamen.Watercolor")%>%
    addPolylines(data=rivershape)%>%
 addPolylines(data=rivermouthshape)%>%
     addMarkers(data=geo_data_ll)
  


  