## plot3.R - Energy sub metering over time

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

png("plot3.png", width = 480, height = 480)
plot(power$DateTime, power$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n")
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), format = "%a")
lines(power$DateTime, power$Sub_metering_2, col = "red")
lines(power$DateTime, power$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
