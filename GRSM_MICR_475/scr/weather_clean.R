library(dplyr)
library(lubridate)

#Precipitation
files <- list.files(path = "Data/NEON_precip-throughfall", full.names = TRUE)
precip <- do.call(rbind, lapply(files, read.csv))

#Format date times

precip$startDateTime <- format(as.Date(precip$startDateTime), "%Y-%m")

#Average for each month
precip <- precip %>%
  group_by(startDateTime) %>%
  summarise(mean_value = mean(precipBulk, na.rm = TRUE))

colnames(precip) <- c("month", "precip")

#Temperature
files <- list.files(path = "Data/NEON_temp-bio", full.names = TRUE)
temp <- do.call(rbind, lapply(files, read.csv))

#Format date times

temp$startDateTime <- format(as.Date(temp$startDateTime), "%Y-%m")

#Average for each month
temp <- temp %>%
  group_by(startDateTime) %>%
  summarise(across(starts_with("bioTempM"), 
                   mean, na.rm = TRUE))

colnames(temp) <- c("month", "mean_temp", "min_temp", "max_temp")

#combine data sets
weather <- left_join(precip, temp, by = "month")

write.csv(weather, "output/weather.csv")
