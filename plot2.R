library(sqldf)

## This piece of code gets the data, reads, only the specified dates and also transforms the date column
## into 'Date'-class variables.
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="household_power_consumption.zip")
unzip("household_power_consumption.zip")
data <- read.csv2.sql(file="household_power_consumption.txt", header=TRUE, sql="select * from file where Date='1/2/2007' or Date='2/2/2007'")
data$DateTime<- paste(data$Date, data$Time, sep=" ")
data$DateTime<- strptime(data$DateTime, format="%d/%m/%Y %T")

## This piece of code plots the graph and creates a copy of it into a .PNG file
png(file="plot2.png")
plot(data$DateTime, data$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="s")
dev.off()