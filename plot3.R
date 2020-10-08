#
# Loading and preparing the data we need for this project.
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
# Code for the 3rd graphic -----------------------------------------------------------
#

plot(epComsumption$DateTime, epComsumption$Sub_metering_1, 
     type = "l", xlab = " ", ylab = "Energy sub metering")
par(new=TRUE)
plot(epComsumption$DateTime, epComsumption$Sub_metering_2, 
     type = "l", col = "red",axes = FALSE,ylim = c(0,30), xlab =  " ", ylab = " ")
par(new=TRUE)
plot(epComsumption$DateTime, epComsumption$Sub_metering_3, 
     type = "l", col= "blue", ylim = c(0,30),axes = FALSE, xlab = " ", ylab = " ")
legend("topright",lty = 1, 
       col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       y.intersp = 0.2,x.intersp = .5)
dev.copy(png, file = "plot3.png",width=480, height=480)
dev.off()
