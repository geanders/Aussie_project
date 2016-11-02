library(tidyverse)
library(lubridate)
library(stringr)
aussie_data <- read_csv("mmc1.csv")

# initial bits of cleanup
# dropping some non-useful columns - leaves 5060 obs. of 53 variables
clean_aussie_data <- select(aussie_data, -`Database ID`, `Composite count`,
                            -`Family code`, -Datum, -Notes, -Reference, -Geocoding, 
                            -(contains("err")), -`Dry mass fraction`, -`Mussel age (y)`)

# renaming some columns to simplify R codes
# deliberately left bare element names capitalized, but shifted isotope names
clean_aussie_data <- clean_aussie_data %>%
  rename(sample_id = `Sample ID`, ecosystem = Ecosystem, sample_type = `Sample type`,
         common_name = `Common name`, sci_name = `Scientific name`, bush_group = `Bush food group`,
         wildlife_group = `Wildlife group`, compartment = Compartment, 
         composite_count = `Composite count`, sex = Sex, soil_depth = `Soil depth (cm)`,
         collection_date = `Collection date (day/month/year)`, location = Location,
         status = Status, easting = Easting, northing = Northing, zone = Zone,
         u238 = `U-238`, u234 = `U-234`, th230 = `Th-230`, ra226 = `Ra-226`, 
         pb210 = `Pb-210`, po210 = `Po-210`, th232 = `Th-232`, ra228 = `Ra-228`, 
         th228 = `Th-228`, ac227 = `Ac-227`)
# original dataset uses wildlife_group only for a fine-grained division of 
# plant and animal samples.  Here I use ecosystem and sample_type to create 
# entries in wildlife_group for soil and sediment samples, as well as for fruits
# that were not counted in other types. Set the wildlife_group to a factor.
# 5060 entries, 53 variables
clean_aussie_data <- clean_aussie_data %>%
  mutate(wildlife_group = ifelse(is.na(wildlife_group), 
                                 paste0(ecosystem,"-",sample_type), wildlife_group ))
#
# set several values to factors: ecosystem, sample_type, wildlife_group
# convert collection_date to a date
clean_aussie_data$wildlife_group <- as.factor(clean_aussie_data$wildlife_group)
clean_aussie_data$ecosystem <- as.factor(clean_aussie_data$ecosystem)
clean_aussie_data$sample_type <- as.factor(clean_aussie_data$sample_type)
clean_aussie_data$collection_date <- dmy(clean_aussie_data$collection_date)