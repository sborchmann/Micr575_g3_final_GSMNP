library(dplyr)
library(tidyverse)
library(ggthemes)

#pulling tidied version of visiation data
visitation <- read.csv("visitation.csv")

#removing columns to keep the most relevant for this visualization + keeping only 2021-2025
#change Year to factor for graph color purpose

reduced_vis <- visitation |>
  mutate(as.factor(Year)) |>
  filter(Year > 2020) |>
  select(c(2,3,4,5,8))

#assigning year colors so graphs are easier to read
year_colors <- c("#ff4938","#008a25","#3d4ba6","#debb0d","#9b4ddb")

##########
#Q1) How does park visitation change throughout the year?
##########

month_order <- c("JAN","FEB","MAR","APR","MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC")

Q1 <- ggplot(data=reduced_vis, aes(x=factor(month, levels=month_order), y=attendance, group=Year, color=as.factor(Year))) +
  geom_line() +
  geom_point() +
  scale_color_manual(values=year_colors)
  labs(, x = "Month", y = "Attendance", fill = "Year") 



########
#Q2) How has park visitation changed in the past 5 years?
########

#Yearly visitation counts from 2021-2025 by year
Q2 <- ggplot(data=reduced_vis, aes(x=Year, y=AnnualTotal, fill=as.factor(Year))) +
  geom_bar(stat="identity") +
  scale_fill_manual(values=year_colors) +
  labs(title = "Visitation per Year", x = "Year", y = "Attendance", fill = "Year")


#How has visitation changed in the past 5 years in monthly visitation? 
Q2A <- ggplot(data=reduced_vis, aes(x=factor(month, levels=month_order), y=attendance, fill=as.factor(Year))) +
  geom_bar(position="dodge", stat="identity") +
  scale_fill_manual(values=year_colors) +
  labs(title = "Monthly Visitation per Year", x = "Month", y = "Attendance", fill = "Year")