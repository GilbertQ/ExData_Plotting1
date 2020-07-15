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
png("plot1.png", width = 480, height = 480)
## Generating the graphic
hist(data_hcp$global_active_power,col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
## Closing the channel to save the file
dev.off()

