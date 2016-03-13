# load libraries 
library(dplyr)
library(data.table)
library(datasets)
library(lubridate)

# check if the data object we use for graphing exists, if not, read from data file and filter 
# out the subset we need
if (!exists("householdPowerConsumptionData")) {
  householdPowerConsumptionData <- fread("household_power_consumption.txt", na.strings = "?")
  householdPowerConsumptionData <- tbl_df(householdPowerConsumptionData)
  householdPowerConsumptionData <- mutate(householdPowerConsumptionData, DateTime = fast_strptime(paste(Date, Time, sep = " "), format = "%d/%m/%Y %H:%M:%S"))
  householdPowerConsumptionData <- filter(householdPowerConsumptionData, DateTime >= fast_strptime("01/02/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S") & DateTime < fast_strptime("03/02/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S"))
}

# build the graph 
frame()

par(mfrow = c(1,1))

hist(householdPowerConsumptionData$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()