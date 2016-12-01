library(shiny)
library(leaflet)
library(tidyverse)

# source("shiny mapping experiments.R")
# rivershape<-readShapeLines("CopyOfRiver Data/AUS_water_lines_dcw", 
                           # proj4string=CRS("+proj=longlat"))
# rivermouthshape<-readShapeLines("CopyOfRiver Data/AUS_water_areas_dcw.shp", 
                               # proj4string=CRS("+proj=longlat"))
# from another script file can execute the shiny app by using the runApp 
# command on the directory name : runApp("shiny_app")


# need to run the clean up script to generate clean_aussie_data
# need to run the river mapping emailed script to generate river and rivermouth data frames
load("geo_aussie_data.Rdata")
load("river_map.Rdata")
load("river_mouthmap.Rdata")
geo_aussie_shiny <- geo_aussie_data %>% 
  mutate(sample_year = year(collection_date)) %>%
  select(sample_type, sample_year, Longitude, Latitude, Cu, As, 
      Hg, Pb, radionuclides)

shinyServer(function(input, output, session) {
  filteredData <- reactive({
    geo_aussie_shiny[geo_aussie_shiny$sample_type == input$Substrate &
                      geo_aussie_shiny$sample_year >= input$slider1, ]
  })
# points <- filteredData 
# popup_info <- eventReactive({
                     # paste0("<b>Copper:</b>  ", 
                      # points$Cu, "<br/>",
                      #"<b>Arsenic:</b>  ",
                      #points$As, "<br/>",
                       #"<b>Mercury:</b>  ",
                       #points$Hg, "<br/>",
                       #"<b>Lead:</b>  ",
                       #points$Pb, "<br/>",
                       #"<b>Radionuclides:</b>  ", 
                       #points$radionuclides)
#})

output$RiverMap <- renderLeaflet({
    leaflet(geo_aussie_shiny)
})

observe({
  leafletProxy("RiverMap", data = filteredData()) %>%
 clearShapes() %>%
    addProviderTiles("Stamen.Watercolor")%>%
    addPolylines(data=river_map)%>%
    addPolylines(data=river_mouthmap) %>%
    addCircleMarkers(data=filteredData())
})

})
   

