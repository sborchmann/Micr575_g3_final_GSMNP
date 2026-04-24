#cleaning visitation data

#using the file I edited first in excel
    #changed the format of the numbers

library(readr)
library(tidyverse)
library(lubridate)
library(dplyr)

#what happens if we use the raw original csv file
visit_og <- read_csv("GRSM_MICR_475/Data/Visitation by Month.csv")
View(visit_og)

#the csv file from GSMNP opens properly in excel. however, the visit values are stores as numbers BUT include commas, likely for human readability.
#easy fix: open excel, select numerical values and reselect number as the data type/format. 
  #then: redownload the csv file in the correct format to be opened by r studio
  #then: read_csv code should work now. Data cleaning can begin


visit_raw <- read_csv("GRSM_MICR_475/Data/Visit_by_month.csv")
View(visit_raw)

visit_long <- visit_raw |>
  pivot_longer(
    cols = c(JAN:DEC),
    names_to= "month",
    values_to= "attendance"
  )
View(visit_long)

#fix order:
visit_order <- visit_long |>
  relocate(month, attendance, .after = 1)
#rename percent column
visit_order <- visit_order |>
  rename(percent = Textbox4)
View(visit_order)

#combine month and year to make one column
  #had to match fncn and tolower so format matched
visit_date_clean <- visit_order |>
  mutate(
    month_num = match(tolower(month), tolower(month.abb)),
    date = make_date(Year, month_num, 1)
  )
View(visit_date_clean)
  
#creating csv to add to project files
write.csv(visit_date_clean,"visitation.csv")
  


