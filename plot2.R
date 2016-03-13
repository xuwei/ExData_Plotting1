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
plot(type = "o", pch = 20, cex = 0, householdPowerConsumptionData$DateTime, householdPowerConsumptionData$Global_active_power, xlab="",ylab="Global Active Power (kilowatts)")
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()