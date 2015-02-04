data <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?", nrows = 2075259, stringsAsFactors = F)
data$Date <- strptime(data$Date, format = "%d/%m/%Y")
data$Date <- as.Date(data$Date)
data_sub <- subset(data, Date <=  "2007-02-02" & Date >= "2007-02-01")

weekdays <- weekdays(data_sub$Date, abbreviate = T)

first_thu <- min(which(weekdays == "Thu"))
first_fri <- min(which(weekdays == "Fri"))
first_sat <- max(which(weekdays == "Fri"))
x_ticks <- c(first_thu, first_fri, first_sat)


png("plot4.png")
par(mfrow=c(2,2))

#plot 1
plot(data_sub$Global_active_power , type = "n", xaxt = "n", xlab= "", ylab = "Global Active Power (kilowatts)")
lines(data_sub$Global_active_power)
axis(1, labels = c("Thu", "Fri", "Sat"), at = x_ticks)

#plot 2
plot(data_sub$Voltage , type = "n", xaxt = "n", ylab = "Voltage", xlab="datetime")
lines(data_sub$Voltage)
axis(1, labels = c("Thu", "Fri", "Sat"), at = x_ticks)

#plot 3
plot(data_sub$Sub_metering_1 , type = "n", xaxt = "n", xlab= "", ylab = "Energy sub metering")
lines(data_sub$Sub_metering_1)
lines(data_sub$Sub_metering_2, col="red")
lines(data_sub$Sub_metering_3, col="blue")
axis(1, labels = c("Thu", "Fri", "Sat"), at = x_ticks)
legend("topright", bty = "n", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col =c("black", "red", "blue"), lty = 1)

#plot 4
plot(data_sub$Global_reactive_power , type = "n", xaxt = "n", ylab = "Global_reactive_power", xlab="datetime")
lines(data_sub$Global_reactive_power)
axis(1, labels = c("Thu", "Fri", "Sat"), at = x_ticks)

dev.off()