## plot1.R - Histogram of Global Active Power

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

png("plot1.png", width = 480, height = 480)
hist(power$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()