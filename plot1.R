## plot1.R
## Produces the Global Active Power histogram

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
png(file="plot1.png", width=480, height=480, bg="transparent")
hist(plotdf$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
