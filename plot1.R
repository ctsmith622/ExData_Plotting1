#assume the file as been dowloaded and unzipped into the working directory

data <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?", nrows = 2075259, stringsAsFactors = F)
data$Date <- strptime(data$Date, format = "%d/%m/%Y")
data$Date <- as.Date(data$Date)
data_sub <- subset(data, Date <=  "2007-02-02" & Date >= "2007-02-01")


png("plot1.png")
hist(data_sub$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()
