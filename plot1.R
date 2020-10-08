#
# Loading the data we need and take only the columns that we need for this project
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
# Code for the 1st graphic -----------------------------------------------------------
#

with(epComsumption, hist(Global_active_power, 
                         col = "red", 
                         xlab = "Global Active Power (kilowatts)", 
                         main = "Global Active Power"))
dev.copy(png, file = "plot1.png",width=480, height=480)
dev.off()
