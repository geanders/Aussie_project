library(tidyverse)
aussie_data <- read_csv("mmc1.csv")

# initial bits of cleanup
# dropping some non-useful columns
clean_aussie_data <- select(aussie_data, -`Database ID`, `Composite count`, -`Family code`,
                            -Zone, -Datum, -Notes, -Reference, -Geocoding, 
                            -(contains("err")), -`Dry mass fraction`, -`Mussel age (y)`)

# renaming some columns to simplify R codes
# deliberately left bare element names capitalized, but shifted isotope names
clean_aussie_data <- clean_aussie_data %>%
  rename(sample_id = `Sample ID`, ecosystem = Ecosystem, sample_type = `Sample type`,
         common_name = `Common name`, sci_name = `Scientific name`, bush_group = `Bush food group`,
         wildlife_group = `Wildlife group`, compartment = Compartment, 
         composite_count = `Composite count`, sex = Sex, soil_depth = `Soil depth (cm)`,
         collection_date = `Collection date (day/month/year)`, location = Location,
         status = Status, easting = Easting, northing = Northing, u238 = `U-238`, 
         u234 = `U-234`, th230 = `Th-230`, ra226 = `Ra-226`, pb210 = `Pb-210`, 
         po210 = `Po-210`, th232 = `Th-232`, ra228 = `Ra-228`, th228 = `Th-228`,
         ac227 = `Ac-227`)

