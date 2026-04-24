#cleaning visitation data

#using the file I edited first in excel
    #changed the format of the numbers

library(readr)
library(tidyverse)
library(lubridate)
library(dplyr)

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
  


