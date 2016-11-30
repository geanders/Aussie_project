setwd("/Users/Chloe/Desktop/Rprog/FinalProject_Rclass/shiny_app")
load("geo_aussie_data.Rdata")
load("river_map.Rdata")
load("river_mouthmap.Rdata")
library(dplyr)
geo_aussie_shiny <- geo_aussie_data %>% 
  mutate(sample_year = year(collection_date))

# points <-geo_aussie_data[ ,geo_aussie_data$sample_type &
                    # year(geo_aussie_data$collection_date)]
points <- geo_aussie_shiny %>% select(sample_type, sample_year, 
                                      Longitude, Latitude, Cu, As, 
                                      Hg, Pb,
                                      radionuclides)
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


RiverMap <- leaflet()%>%
    addProviderTiles("Stamen.Watercolor")%>%
    addPolylines(data=river_map)%>%
    addPolylines(data=river_mouthmap)%>%
    addCircleMarkers(data=points,popup=popup_info)
