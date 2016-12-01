setwd("/Users/Chloe/Desktop/Rprog/FinalProject_Rclass/shiny_app")
load("geo_aussie_data.Rdata")
load("river_map.Rdata")
load("river_mouthmap.Rdata")
library(dplyr)
geo_aussie_shiny <- geo_aussie_data %>% 
  mutate(sample_year = year(collection_date)) %>%
  select(sample_type, sample_year, Longitude, Latitude, Cu, As, 
         Hg, Pb, radionuclides)
points <- geo_aussie_shiny[geo_aussie_shiny$sample_type == "Terrestrial Animals" &
                             geo_aussie_shiny$sample_year == 2014, ]
popup_info <- points %>% paste0("<b>Copper:</b>  ", 
         points$Cu, "<br/>",
         "<b>Arsenic:</b>  ",
         points$As, "<br/>",
         "<b>Mercury:</b>  ",
         points$Hg, "<br/>",
         "<b>Lead:</b>  ",
         points$Pb, "<br/>",
         "<b>Radionuclides:</b>  ", 
         points$radionuclides)


leaflet()%>%
    addProviderTiles("Stamen.Watercolor")%>%
    addPolylines(data=river_map)%>%
    addPolylines(data=river_mouthmap, fillColor = "#0000FF")%>%
    addMarkers(data=points,popup=popup_info)


# what shiny has in it on 11/30/16 AM:
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
load("geo_aussie_data.Rdata")
load("river_map.Rdata")
load("river_mouthmap.Rdata")

shinyServer(function(input, output, session) {
  points <- eventReactive({
    geo_aussie_data[geo_aussie_data$sample_type == input$Substrate &
                      geo_aussie_data$collection_date == input$slider1, ]
  })
  popup_info <- eventReactive({
    paste0("<b>Copper:</b>  ", 
           points$Cu, "<br/>",
           "<b>Arsenic:</b>  ",
           points$As, "<br/>",
           "<b>Mercury:</b>  ",
           points$Hg, "<br/>",
           "<b>Lead:</b>  ",
           points$Pb, "<br/>",
           "<b>Radionuclides:</b>  ", 
           points$radionuclides)
  })
  
  output$RiverMap <- renderLeaflet({
    leaflet()%>%
      addProviderTiles("Stamen.Watercolor")%>%
      addPolylines(data=river_map)%>%
      addPolylines(data=river_mouthmap)#%>%
    # addCircleMarkers(data=points(),popup=popup_info())
  })
  
})
