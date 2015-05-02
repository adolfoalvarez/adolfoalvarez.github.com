# This code generates the choropleth map of R users meetup groups
library(rvest)
library(dplyr)
r_users <- read_html("http://r-users-group.meetup.com/all/")