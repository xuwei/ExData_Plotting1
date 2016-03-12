library(dplyr)
library(data.table)
if (!exists("householdPowerConsumptionData")) {
  householdPowerConsumptionData <- fread("household_power_consumption.txt", na.strings = "?")
  householdPowerConsumptionData <- tbl_df(householdPowerConsumptionData)
  householdPowerConsumptionData <- mutate(householdPowerConsumptionData, DateTime = as.Date(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
  householdPowerConsumptionData <- filter(householdPowerConsumptionData, DateTime >= as.Date("01/02/2007", "%d/%m/%Y") & DateTime < as.Date("03/02/2007", "%d/%m/%Y"))
}