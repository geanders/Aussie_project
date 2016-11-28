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


# need to run the clean up script to generate clean_aussie_data
# need to run the river mapping emailed script to generate river and rivermouth data frames
load(geo_aussie_data)
load(river)
load(rivermouth)
shinyServer(function(input, output, session) {
 points <- reactive({
   geo_aussie_data[geo_aussie_data$sample_type == input$Substrate &
              geo_aussie_data$collection_date == input$slider1]
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
