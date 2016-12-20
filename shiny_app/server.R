library(shiny)
library(leaflet)
library(tidyverse)
library(lubridate)
library(shinythemes)

load("geo_aussie_data.Rdata")
load("river_map.Rdata")
load("river_mouthmap.Rdata")
load("rangerpoint.Rdata")

geo_aussie_shiny <- geo_aussie_data %>% 
  mutate(sample_year = year(collection_date)) %>%
  select(sample_type, sample_year, Longitude, Latitude, Cu, As, 
         Hg, Pb, radionuclides) %>%
  group_by(Longitude, Latitude, sample_type, sample_year) %>%
  summarize(Cu = max(Cu, na.rm = TRUE), 
            As = max(As, na.rm = TRUE),
            Hg = max(Hg, na.rm = TRUE), 
            Pb = max(Pb, na.rm = TRUE), 
            radionuclides = max(radionuclides, na.rm = TRUE)) %>%
  ungroup(Longitude, Latitude, sample_type, sample_year)

shinyServer(function(input, output, session) {
  

  filteredData <- reactive({
    
   if (input$Substrate == "All" & input$checkbox == TRUE) {
     geo_aussie_shiny
   } else if (input$Substrate == "All" & input$checkbox == FALSE) {
      geo_aussie_shiny %>% filter(sample_year == input$slider1)
   } else if (input$Substrate != "All" & input$checkbox == TRUE) {
      geo_aussie_shiny %>% filter(sample_type == input$Substrate)
   } else if (input$Substrate != "All" & input$checkbox == FALSE) {
      geo_aussie_shiny %>% filter(sample_type == input$Substrate & 
                                  sample_year == input$slider1)
   }
  })
  
  
  popups <- reactive({
    paste0("<b>Copper (mg/kg -1):</b>  ", 
                         filteredData()$Cu, "<br/>",
                         "<b>Arsenic (mg/kg -1):</b>  ",
                         filteredData()$As, "<br/>",
                         "<b>Mercury (mg/kg -1):</b>  ",
                         filteredData()$Hg, "<br/>",
                         "<b>Lead (mg/kg -1):</b>  ",
                         filteredData()$Pb, "<br/>",
                         "<b>Radionuclides(Bq):</b>  ", 
                         filteredData()$radionuclides)
  })
  
  output$RiverMap <- renderLeaflet({
    leaflet(geo_aussie_shiny) %>%
      addProviderTiles("Stamen.Watercolor")%>%
      setView(132.9107, -12.6848, zoom = 7) %>%
      addPolylines(data=river_map)%>%
      addPolylines(data=river_mouthmap) %>%
      addCircles(data = rangerpoint, color = "violetred1",  fillColor = "red", fillOpacity = 1)
  })

  observeEvent({
    input$Substrate
    input$slider1
    }, {
    leafletProxy("RiverMap", data = filteredData()) %>%
      clearMarkers() %>%
        addCircles(popup=rangerpoint) %>%
      addMarkers(data = filteredData(), lat = ~ Latitude, lng = ~ Longitude, 
                 popup = popups())
      
  })
  
})

