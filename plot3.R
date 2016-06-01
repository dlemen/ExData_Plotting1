## plot3.R
## Produces the sub metering chart

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

par(mfrow=c(1, 1))
png(file="plot3.png", width=480, height=480, bg="transparent")
plot(Sub_metering_1 ~ datetime, plotdf,
     xlab=NA, ylab="Energy sub metering", 
     type="n")

lines(Sub_metering_1 ~ datetime, plotdf, col="black")
lines(Sub_metering_2 ~ datetime, plotdf, col="red")
lines(Sub_metering_3 ~ datetime, plotdf, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1, 1, 1), col=c("black", "red", "blue"))

dev.off()

