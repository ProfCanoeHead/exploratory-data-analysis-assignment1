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
power_condf <- as.data.table(read.csv.sql("./data/household_power_consumption.txt", sep = ";",
                            header = TRUE,
                            sql = "select * from file where `Date` IN ('1/2/2007', '2/2/2007')"))
power_condf <- as.data.table(power_condf)
power_condf <- power_condf[, Date:= as.Date(Date, format = "%d/%m/%Y")]
}
#plot1
png("plot1.png", width=480, height=480)
par(mfrow = c(1,1))
with(power_condf, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
dev.off()