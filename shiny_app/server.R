library(shiny)
library(tidyverse)
library("rgdal")
library("maptools")
library("ggplot2")
library("plyr")
library(broom)
library(foreign)
library("maptools")
library(leaflet)

# source("shiny mapping experiments.R")
# rivershape<-readShapeLines("CopyOfRiver Data/AUS_water_lines_dcw", 
                           # proj4string=CRS("+proj=longlat"))
# rivermouthshape<-readShapeLines("CopyOfRiver Data/AUS_water_areas_dcw.shp", 
                               # proj4string=CRS("+proj=longlat"))
# from another script file can execute the shiny app by using the runApp 
# command on the directory name : runApp("shiny_app")

#load(mapshapefile)
#load(dataframe)
shinyServer(function(input, output, session) {
 # points <- reactive({
   # dataframe[dataframe$sample_type == input$Substrate &
              #  dataframe$year == input$slider1]
  })
 # popup_info <- reactive({
#                       paste0("<b>Copper:</b>  ", 
          #             points$Cu, "<br/>",
           #            "<b>Arsenic:</b>  ",
            #           points$As, "<br/>",
             #          "<b>Mercury:</b>  ",
              #         points$Hg, "<br/>",
               #        "<b>Lead:</b>  ",
                #       points$Pb, "<br/>",
                 #      "<b>Radionuclides:</b>  ", 
                  #     points$Radionuclides)
# })
# output$RiverMap <- renderLeaflet({
  #  leaflet()%>%
   #   addProviderTiles("Stamen.Watercolor")%>%
    #  addPolylines(data=rivershape)%>%
     # addPolylines(data=rivermouthshape)%>%
      # addCircleMarkers(data=points, popup=popup_info)
    #})
   
#})
