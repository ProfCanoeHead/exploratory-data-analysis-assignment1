#R libraries used
library(data.table)
library(sqldf)
 
#check if /data exists, if not create
if (!file.exists("./data")){
  dir.create("./data")

#GETTING DATA
#download data from url, and save to temp.zip
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileDest <- "./data/temp.zip"
download.file(fileUrl,fileDest , method = "curl")

#unzip temp.zip to the /data directory
unzip(fileDest, exdir = "./Data")
file.remove("./data/temp.zip")

#load only required data
power_condf <- read.csv.sql("./data/household_power_consumption.txt", sep = ";",
                            header = TRUE,
                            sql = "select * from file where `Date` IN ('1/2/2007', '2/2/2007')")

timeseries <- strptime(paste(power_condf$Date, power_condf$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
}
#plot3
png("plot3.png", width=480, height=480)
par(mfrow = c(1,1))
plot(timeseries, power_condf$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sun metering")
lines(timeseries, power_condf$Sub_metering_2, col = "red")
lines(timeseries, power_condf$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()