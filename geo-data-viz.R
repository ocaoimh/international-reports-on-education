#=================
# INSTALL PACKAGES
#=================
library(tidyverse)
library(rvest)
library(magrittr)
library(ggmap)
library(stringr)
library(readxl)

#============
# DATA TABLE FOR COUNTRIES
#============
setwd("~/Documents/LancasterResearch/Springer-Encylopedia/July 2019/geo-viz")

countries_1960s <- read_excel("countries_1960s.xlsx")
View(countries_1960s)

countries_2010s <- read_excel("countries_2010s.xlsx")
View(countries_2010s)

#==============
# GET WORLD MAP
#==============

map.world <- map_data("world")

# INSPECT - make names categorical variables
as.factor(countries_1960s$country) %>% levels()
as.factor(countries_2010s$country) %>% levels()


# # INSPECT
# countries_1960s$country <- recode(countries_1960s$country
#                                    ,'United States' = 'USA'
#                                    ,'England' = 'UK'
                                    # )


# INSPECT
print(countries_1960s)

#================================
# JOIN
# - join the 'countries_1960s' data 
#   to the world map
#================================

# LEFT JOIN

map.world_ilsr60s <- left_join(map.world, countries_1960s, by = c('region' = 'country'))

head(map.world_ilsr60s)

map.world_ilsr2010s <- left_join(map.world, countries_2010s, by = c('region' = 'country'))

head(map.world_ilsr2010s)

#===================================================
# CREATE FLAG
# - in the map, we're going to highlight
#   the countries with high 'talent competitiveness'
# - Here, we'll create a flag that will
#   indicate whether or not we want to 
#   "fill in" a particular country 
#   on the map
#===================================================

map.world_ilsr60s <- map.world_ilsr60s %>% mutate(fill_flg = ifelse(is.na(rank),F,T))

head(map.world_ilsr60s)

map.world_ilsr2010s <- map.world_ilsr2010s %>% mutate(fill_flg = ifelse(is.na(rank),F,T))


#=======
# MAP 1960s
#=======

ggplot() +
  geom_polygon(data = map.world_ilsr60s, aes(x = long, y = lat, group = group, fill = fill_flg), color = "#E5E5E5") +
  scale_fill_manual(values = c("#B7B7B7","steelblue")) +
  labs(title = 'Countries participating in test-based international reports'
       ,subtitle = "1959-1969") +
  labs(fill = 'rank'
       ,color = 'region'
       ,title = 'Countries participating in test-based international reports'
       ,x = NULL
       ,y = NULL) +
  
  theme(text = element_text(family = "Gill Sans", color = "#444444")
        ,panel.background = element_rect(fill = "#FFFFFF")
        ,plot.background = element_rect(fill = "#FFFFFF")
        ,panel.grid = element_blank()
        ,plot.title = element_text(size = 15)
        ,plot.subtitle = element_text(size = 10)
        ,axis.text = element_blank()
        ,axis.title = element_blank()
        ,axis.ticks = element_blank()
        ,legend.position = c(.18,.36)
  )

#=======
# MAP 2010s
#=======

ggplot() +
  geom_polygon(data = map.world_ilsr2010s, aes(x = long, y = lat, group = group, fill = fill_flg), color = "#E5E5E5") +
  scale_fill_manual(values = c("#B7B7B7","steelblue")) +
  labs(title = 'Countries participating in test-based international reports"'
       ,subtitle = "2010-2019") +
  labs(fill = 'rank'
       ,color = 'region'
       ,title = 'Countries participating in test-based international reports'
       ,x = NULL
       ,y = NULL) +
  
  theme(text = element_text(family = "Gill Sans", color = "#444444")
        ,panel.background = element_rect(fill = "#FFFFFF")
        ,plot.background = element_rect(fill = "#FFFFFF")
        ,panel.grid = element_blank()
        ,plot.title = element_text(size = 15)
        ,plot.subtitle = element_text(size = 10)
        ,axis.text = element_blank()
        ,axis.title = element_blank()
        ,axis.ticks = element_blank()
        ,legend.position = c(.18,.36)
  )

