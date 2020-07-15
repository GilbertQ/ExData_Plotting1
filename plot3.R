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
png("plot3.png", width = 480, height = 480)
## Building the column DateTime
data_hcp$Date <- as.Date(data_hcp$Date, format="%d/%m/%Y")
DateTime <- paste(as.Date(data_hcp$Date), data_hcp$Time)
data_hcp$DateTime <- as.POSIXct(DateTime)
## Generating the graphic
with(data_hcp, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
})
## Adding information to the graphic
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Closing the channel to save the file
dev.off()
