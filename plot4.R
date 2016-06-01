## plot4.R
## Produces the four charts

if (!exists("plotdf")) {
    datafile <- "../data/household_power_consumption.txt"
    print("Loading data...")
    df <- read.table(datafile, head=TRUE, sep=";", na.strings="?", 
                     colClasses=c("character", "character", "numeric", "numeric",
                                  "numeric", "numeric", "numeric", "numeric",
                                  "numeric"))
    print("Converting dates...")
    df$Date <- as.Date(strptime(df$Date, "%d/%m/%Y"))
    startDate <- as.Date("2007-02-01")
    endDate <- as.Date("2007-02-02")
    
    print("Subsetting data...")
    plotdf <- subset(df, Date >= startDate & Date <= endDate)
    
    print("Merging date and time...")
    plotdf$datetime <- as.POSIXct(paste(plotdf$Date, plotdf$Time))
}

print("Generating plot...")

png(file="plot4.png", width=480, height=480, bg="transparent")

## Set up the 2x2 layout...
par(mfrow=c(2, 2), mar=c(5, 4, 1, 1))

## plot 1...
plot(Global_active_power ~ datetime, plotdf, ylab="Global Active Power", xlab="", type="l")

## plot 2...
plot(Voltage ~ datetime, plotdf, ylab="Voltage", type="l")

## plot 3...
plot(Sub_metering_1 ~ datetime, plotdf,
     xlab=NA, ylab="Energy sub metering", 
     type="n")
## TODO: Fix the axis labels.
lines(Sub_metering_1 ~ datetime, plotdf, col="black")
lines(Sub_metering_2 ~ datetime, plotdf, col="red")
lines(Sub_metering_3 ~ datetime, plotdf, col="blue")
legend("topright", cex=0.8, bty="n", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1, 1, 1), col=c("black", "red", "blue"))

## plot 4...
plot(Global_reactive_power ~ datetime, plotdf, ylab="Global Reactive Power", type="l")

dev.off()

