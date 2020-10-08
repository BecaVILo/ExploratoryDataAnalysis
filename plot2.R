#
# Loading and preparing the data that we need for this project.
#

ElectricPower1 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,stringsAsFactors = FALSE)
ElectricPower <- ElectricPower1[(ElectricPower1$Date == "1/2/2007" | ElectricPower1$Date == "2/2/2007" ),]

DateTime <- paste(ElectricPower$Date, ElectricPower$Time, sep = " ")
DateTime <- as.POSIXlt(DateTime, format = "%d/%m/%Y %H:%M:%S")

epComsumption <- cbind(DateTime, ElectricPower[,3:9])
as.numeric(epComsumption[,2:8])

col_num <- names(epComsumption)[2:8]
epComsumption[col_num] <- sapply(epComsumption[col_num], as.numeric)

#
# Code for the 2nd graphic -----------------------------------------------------------
#

par(mfrow = c(1,1), mar = c(4,4,2,2))
with(epComsumption, plot(DateTime,Global_active_power, 
                         type = "l", 
                         xlab = " ",
                         ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png")
dev.off()
