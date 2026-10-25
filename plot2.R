## plot2.R - Global Active Power over time

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

png("plot2.png", width = 480, height = 480)
plot(power$DateTime, power$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n")
days <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"), tz = "GMT")
axis(1, at = as.numeric(days), labels = c("Thu", "Fri", "Sat"))

dev.off()