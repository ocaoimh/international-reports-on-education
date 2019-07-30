# This script to to take the spreadsheet with the data on the international reports and generate some data displays

## STEP 1  load library - ggplot is a graphing library
library(ggplot2)
library(readr)

## STEP 2
# Import the data and set your working directory to the default one. This makes it easier when saving. 

setwd("~/Documents/LancasterResearch/Springer-Encylopedia/July 2019/springer-july-v2")

int_reports_list <- read_csv("int-reports-list.csv")

#load the dataset into the viewer
View(int_reports_list)

## STEP 3
# We'll  'floor' dates to down to a decade. We'll also add an extra colmumn with the new dates
int_reports_list$floordate <- floor(int_reports_list$Year / 10) * 10

# table with no. reports per decade
reportByDecade <- table(int_reports_list$floordate)

# 1950 1960 1970 1980 1990 2000 2010 2020 
# 1    1    3    4   13   22   23    4 

# table with no. reports per year
reportByYear <- table(int_reports_list$Year)

# 1959 1964 1970 1972 1980 1988 1989 1990 1992 1993 1994 1995 1996 1997 
# 1    1    2    1    1    2    1    2    1    1    1    3    1    2 
# 1998 1999 2000 2001 2002 2003 2005 2006 2007 2008 2009 2010 2011 2012 
# 1    1    1    2    2    4    1    5    2    3    2    2    4    3 
# 2013 2014 2015 2016 2017 2018 2019 2020 2021 2024 
# 2    2    4    1    1    3    1    2    1    1 

# quick barplot by decade
barplot(reportByDecade,
        xlab= reportByDecade,
        ylab= "number of reports",
        main = "International educational reports published from 1959 to 2024 by decade")

# quick barplot by year
barplot(reportByYear,
        xlab= reportByYear,
        ylab= "number of reports",
        main = "International educational reports published from 1959 to 2024")




# create vector with dates and freq
year <- c("1950s", "1960s", "1970s", "1980s", "1990s", "2000s,", "2010s", "2020s") 
number  <- c(1,1,2,3,13,22,23,4)

# combine into data frame
report.data1950.2029 <- data.frame(year, number)


# create vectors without incomplete data for the decade 2020 to 2029
Year <- c("1950s", "1960s", "1970s", "1980s", "1990s", "2000s,", "2010s") 
Number  <- c(1,1,3,4,13,22,25) # !! UPDATED THIS TO 25 on last minute addition of timms 2011 and 2019 

# combine vectors into a data frame
report.data1950.2019 <- data.frame(Year, Number)



# make a nice bar chart with all reports from 1959 to 2024
ggplot(data = report.data1950.2029, aes(year, number)) +geom_bar(stat ="identity")+ 
  geom_text(aes(label=number), vjust=1.4, color="white", size=.5)+
  theme_minimal()

# make a nice bar chart with all reports from 1959 to 2019 (That's 60  years of reports by the way)

# make a nice bar chart with all reports from 1959 to 2024
ggplot(data = report.data1950.2019, aes(Year, Number)) +geom_bar(stat ="identity", fill="steelblue")+ 
  geom_text(aes(label=Number), vjust=1.4, color="white", size=2.5)+
  theme_minimal()







