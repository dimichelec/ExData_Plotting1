
## Read and clean household power consumption data
dataFile <- "../exdata-data-household_power_consumption.zip"

## Ran this the first time:
#   dat <- read.table(unz(dataFile, "household_power_consumption.txt"), header=TRUE, sep=';', na.strings='?')
#   dat <- dat[ dat$Date == '1/2/2007' | dat$Date == '2/2/2007', ]
#
# After running once, found these rows in our date range:
#   66637 - 69516 (2880 count)
#   as a check, make sure: sum(dat$Global_active_power) = 3492.496
#   names(dat):
#    "Date"                  "Time"                  "Global_active_power"   "Global_reactive_power"
#    "Voltage"               "Global_intensity"      "Sub_metering_1"        "Sub_metering_2"       
#    "Sub_metering_3" 
#
# Instead, we can now use this loading script:
dat <- read.table(
    unz(dataFile, "household_power_consumption.txt"),
    header=TRUE, sep=';', na.strings='?', skip = 66636, nrows = 2880,
    col.names = c("Date","Time","Global_active_power","Global_reactive_power",
                  "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                  "Sub_metering_3"
    )
)
dat$DateTime = as.POSIXct(strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S"))
dat$Date = NULL
dat$Time = NULL



## Plot 3
x <- dat[ "DateTime" ]
y <- dat[ c("Sub_metering_1","Sub_metering_2","Sub_metering_3") ]
plot(x[,1], y[,1], xlab = "", ylab = "Energy sub metering", type = 'l', col='black', cex.axis=.75, cex.lab = .75)
lines(x[,1], y[,2], col="red")
lines(x[,1], y[,3], col="blue")
legend('topright', names(y), lty=1, col=c("black","red","blue"), cex=.75, y.intersp=.9)
dev.copy(png, "plot3.png", width=480, height=480)
dev.off()

