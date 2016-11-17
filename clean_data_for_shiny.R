# cleaning data for the shiny app
# need to first run initial aussie cleanup, then run mapping experiments
library(dplyr)
library(stringr)

clean_geo <- geo_data %>% select(sample_id, wildlife_group, collection_date, easting, northing,
                    zone, u238, u234, th230, ra226, pb210, po210, th232, ra228, th228, ac227,
                    As, Cu, Hg, Pb) %>%
  mutate(u234 = str_replace(u234, "<", 0),
         th230 = str_replace(th230, "<", 0),
         ra226 = str_replace(ra226, "<", 0),
         pb210 = str_replace(pb210, "<", 0),
         th232 = str_replace(th232, "<", 0),
         po210 = str_replace(po210, "<", 0))

clean_geo <- clean_geo %>%  mutate(u234 = as.numeric(u234),
         th230 = as.numeric(th230),
         ra226 = as.numeric(ra226),
         pb210 = as.numeric(pb210),
         po210 = as.numeric(po210),
         th232 = as.numeric(th232))

clean_geo$radionuclides <- rowSums(clean_geo[, c("u238", "u234", "th230", "ra226","pb210", "po210", "th232", "ra228", "th228", "ac227")], na.rm = TRUE)

clean_geo <- clean_geo %>% select(sample_id, wildlife_group, collection_date, easting, northing,
                                  zone, As, Cu, Hg, Pb, radionuclides) %>%
mutate(As = str_replace(As, "<", 0),
       Cu = str_replace(Cu, "<", 0),
       Hg = str_replace(Hg, "<", 0),
       Pb = str_replace(Pb, "<", 0)) %>%
mutate(As = as.numeric(As),
         Cu = as.numeric(Cu),
         Hg = as.numeric(Hg),
         Pb = as.numeric(Pb)) %>%

test_geo <- clean_geo %>% mutate(sample_type = ifelse(wildlife_group %in% c("Terrestrial-Bird", "Terrestrial-Reptile",
                                                        "Terrestrial-Mammal"), "Terrestrial Animal", NA),
                                  sample_type = ifelse(wildlife_group %in% c("Terrestrial-Grasses and Herbs", 
                                                        "Terrestrial-Plant"), "Terrestrial Plant", sample_type),
                                   sample_type = ifelse(wildlife_group %in% "Terrestrial-Soil", "Terrestrial Soil", sample_type),
                                   sample_type = ifelse(wildlife_group %in% c("Freshwater-Bird", "Freshwater-Reptile"), 
                                                        "Freshwater Animals", sample_type),
                                   sample_type = ifelse(wildlife_group %in% "Freshwater-Fish", "Fish", sample_type),
                                   sample_type = ifelse(wildlife_group %in% "Freshwater-Mollusc", "Mollusc", sample_type),
                                   sample_type = ifelse(wildlife_group %in% "Freshwater-sediment", "Freshwater Sediment", sample_type),
                                   sample_type = ifelse(wildlife_group %in% "Freshwater-Vascular Plant", "Freshwater Plant", sample_type),
                                   sample_type = ifelse(wildlife_group %in% "Freshwater-Water", "Water", sample_type))
# need to get the distance from the mine, but have to make the data frame piped above
# geo_aussie_data
geo_shiny_data<-mutate(geo_aussie_data, distance = sqrt((Latitude - -12.6848)^2+(Longitude - 132.9107)^2))      





