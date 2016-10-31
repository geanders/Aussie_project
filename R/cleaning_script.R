> setwd("/Users/Chloe/Desktop/")
> getwd()
[1] "/Users/Chloe/Desktop"
> library(dplyr)
library(tidyverse)
aussie_data <- read_csv("mmc1.csv")
small_aussie <- aussie_data %>% select(-`Family code`, -Location, -Zone, 
                                       -Datum, -Notes, -Reference, -Geocoding, 
                                       -`Scientific name`)