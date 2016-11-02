setwd("/Users/Chloe/Desktop/")
getwd()
## interested in looking at the data spatially, 
library(dplyr)
library(tidyverse)
aussie_data <- read_csv("mmc1.csv")
small_aussie <- aussie_data %>% select(-`Family code`, -Location, -Zone, 
                                       -Datum, -Notes, -Reference, -Geocoding, 
                                       -`Scientific name`)
