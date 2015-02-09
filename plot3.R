#assume the file has been dowloaded and unzipped into the working directory

data <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?", nrows = 2075259, stringsAsFactors = F)
data$Date <- strptime(data$Date, format = "%d/%m/%Y")
data$Date <- as.Date(data$Date)
data_sub <- subset(data, Date <=  "2007-02-02" & Date >= "2007-02-01")

weekdays <- weekdays(data_sub$Date, abbreviate = T)

first_thu <- min(which(weekdays == "Thu"))
first_fri <- min(which(weekdays == "Fri"))
first_sat <- max(which(weekdays == "Fri"))
x_ticks <- c(first_thu, first_fri, first_sat)


png("plot3.png")

plot(data_sub$Sub_metering_1 , type = "n", xaxt = "n", xlab= "", ylab = "Energy sub metering")
lines(data_sub$Sub_metering_1)
lines(data_sub$Sub_metering_2, col="red")
lines(data_sub$Sub_metering_3, col="blue")
axis(1, labels = c("Thu", "Fri", "Sat"), at = x_ticks)
legend("topright", xpd = T, legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col =c("black", "red", "blue"), lty = 1)

dev.off()