library(dplyr)
library(tidyverse)

#pulling tidied version of visiation data
visitation <- read.csv("visitation.csv")

#removing columns to keep the most relevant for this visualization + keeping only 2021-2025
#also attempting to change Year to character for graph color purpose (does not appear to be working for me)
reduced_vis <- visitation |>
  mutate(as_factor(visitation$Year)) |>
  filter(Year > 2020) |>
  select(c(2,3,4,5,8))

##########
#Q1) How does park visitation change throughout the year?
##########

month_order <- c("JAN","FEB","MAR","APR","MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC")

Q1 <- ggplot(data=reduced_vis, aes(x=factor(month, levels=month_order), y=attendance, group=Year)) +
  geom_line(aes(color=Year)) +
  labs(, x = "Month", y = "Attendance")

########
#Q2) How has park visitation changed in the past 5 years?
########

#Yearly visitation counts from 2021-2025 by year
Q2 <- ggplot(data=reduced_vis, aes(x=Year, y=AnnualTotal, fill=Year)) +
  geom_bar(stat="identity") +
  labs(title = "Visitation per Year", x = "Year", y = "Attendance")


#How has visitation changed in the past 5 years in monthly visitation? 
Q2A <- ggplot(data=reduced_vis, aes(x=factor(month, levels=month_order), y=attendance, fill=Year)) +
  geom_bar(position="dodge", stat="identity") +
  labs(title = "Monthly Visitation per Year", x = "Month", y = "Attendance")