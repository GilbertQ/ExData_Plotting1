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
png("plot2.png", width = 480, height = 480)
## Building the column DateTime
data_hcp$Date <- as.Date(data_hcp$Date, format="%d/%m/%Y")
DateTime <- paste(as.Date(data_hcp$Date), data_hcp$Time)
data_hcp$DateTime <- as.POSIXct(DateTime)
## Generating the graphic
with(data_hcp, {
  plot(Global_active_power~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
})
## Closing the channel to save the file
dev.off()