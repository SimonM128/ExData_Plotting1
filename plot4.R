## plot4.R - 2x2 panel of plots

zipfile <- "household_power_consumption.zip"
txtfile <- "household_power_consumption.txt"
if (!file.exists(txtfile)) {
        if (!file.exists(zipfile)) {
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                              zipfile, mode = "wb")
        }
        unzip(zipfile)
}

power <- read.table(txtfile, header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
power <- power[power$Date %in% c("1/2/2007", "2/2/2007"), ]
power$DateTime <- as.POSIXct(strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S"))

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

days <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))

plot(power$DateTime, power$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", xaxt = "n")
axis.POSIXct(1, at = days, format = "%a")

plot(power$DateTime, power$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", xaxt = "n")
axis.POSIXct(1, at = days, format = "%a")

plot(power$DateTime, power$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n")
axis.POSIXct(1, at = days, format = "%a")
lines(power$DateTime, power$Sub_metering_2, col = "red")
lines(power$DateTime, power$Sub_metering_3, col = "blue")
legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(power$DateTime, power$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n")
axis.POSIXct(1, at = days, format = "%a")

dev.off()
