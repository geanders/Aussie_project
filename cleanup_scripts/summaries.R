# simple summaries of wildlife_group and ecosystem
summary_wild <- summary(clean_aussie_data$wildlife_group)
summary_eco <- summary(clean_aussie_data$ecosystem)
#
# crude approximation of what's on site
# later this will be by georeference, right now just going by "location"
on_site <- clean_aussie_data %>%
  filter(str_detect(location, "[rR]anger") & !str_detect(location, "[sS]tation"))
#
# per the original paper, mining started in 1980, only a handful of samples from
# prior to 1983 so I lumped them with 1980s, though there are some NAs
#
aussie_1980s <- filter(clean_aussie_data, year(collection_date) %in% 1975:1989)
aussie_1990s <- filter(clean_aussie_data, year(collection_date) %in% 1990:1999)
aussie_2000s <- filter(clean_aussie_data, year(collection_date) %in% 2000:2009)
aussie_2010s <- filter(clean_aussie_data, year(collection_date) %in% 2010:2019)
