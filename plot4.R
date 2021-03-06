library(dplyr)
## In case your system is not in English language
Sys.setlocale("LC_TIME",'en_GB.UTF-8')
## Downloading the zip file
filename <- "ElecPowCons.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,filename)
}

## Unzipping the file
if (!file.exists("household_power_consumption.txt")){
  unzip(filename)
}

## Loading the file into a dataframe
data_hcp <- read.csv("household_power_consumption.txt", sep=";")
## Subsetting the data frame for the dates indicated in the instructions
data_hcp <- filter(data_hcp, data_hcp$Date=="1/2/2007" | data_hcp$Date=="2/2/2007")
## Converting the needed column to numeric
data_hcp$global_active_power <- as.numeric(data_hcp$Global_active_power)
## Opening the channel to save the image
png("plot4.png", width = 480, height = 480)
## Building the column DateTime
data_hcp$Date <- as.Date(data_hcp$Date, format="%d/%m/%Y")
DateTime <- paste(as.Date(data_hcp$Date), data_hcp$Time)
data_hcp$DateTime <- as.POSIXct(DateTime)
## Preparing the graphics area
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
## Generating the graphics
with(data_hcp, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Energy Sub metering", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global_Reactive_Power",xlab="datetime")
})
## Closing the channel to save the file
dev.off()