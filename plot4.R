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
png(file="plot4.png")
par(mfrow=c(2,2))

## Plot 4.1
plot(data$DateTime, data$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="s")

## Plot 4.2
plot(data$DateTime, data$Voltage, xlab="", type="s")

## Plot 4.3
plot(data$DateTime, data$Sub_metering_1, xlab="", ylab="Energy sub metering", type="s")
points(data$DateTime, data$Sub_metering_2, col="red", type="s")
points(data$DateTime, data$Sub_metering_3, col="blue", type="s")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(data[7:9]))

## Plot 4.4
plot(data$DateTime, data$Global_reactive_power, xlab="", type="s")

dev.off()