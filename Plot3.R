getwd()
setwd("E:/Coursera/Data Science/Exploratory Data Analysis/Week 1/Project 1")
##Load data
if(!file.exists("household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}
##Read in table and arrange variables
energy <- read.table(file, header=T, sep=";")
energy$Date <- as.Date(energy$Date, format="%d/%m/%Y")
energy_1 <- energy[(energy$Date=="2007-02-01") | (energy$Date=="2007-02-02"),]
energy_1$Global_active_power <- as.numeric(as.character(energy_1$Global_active_power))
energy_1$Global_reactive_power <- as.numeric(as.character(energy_1$Global_reactive_power))
energy_1$Voltage <- as.numeric(as.character(energy_1$Voltage))
energy_1 <- transform(energy_1, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
energy_1$Sub_metering_1 <- as.numeric(as.character(energy_1$Sub_metering_1))
energy_1$Sub_metering_2 <- as.numeric(as.character(energy_1$Sub_metering_2))
energy_1$Sub_metering_3 <- as.numeric(as.character(energy_1$Sub_metering_3))
##Plot 3
plot3 <- function() {
  plot(energy_1$timestamp,energy_1$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(energy_1$timestamp,energy_1$Sub_metering_2,col="red")
  lines(energy_1$timestamp,energy_1$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
}
plot3()