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

#submetering 1 plot
plot(type = "o", pch = 20, cex = 0, col = "black", householdPowerConsumptionData$DateTime, householdPowerConsumptionData$Sub_metering_1, xlab = "", ylab = "")

#submetering 2 plot
lines(type = "o", pch = 20, cex = 0, col = "red", householdPowerConsumptionData$DateTime, householdPowerConsumptionData$Sub_metering_2, xlab = "", ylab = "")

#submetering 3 plot
lines(type = "o", pch = 20, cex = 0, col = "blue", householdPowerConsumptionData$DateTime, householdPowerConsumptionData$Sub_metering_3, xlab = "", ylab = "")

#add legends
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lwd = 2, cex = 0.8, col = c("black", "red", "blue"), pch=c(NA,NA,NA))

# title for axes
title(main="", sub="", 
     xlab="", ylab="Energy sub metering")

dev.copy(png,file="plot3.png",width=480,height=480)
dev.off()