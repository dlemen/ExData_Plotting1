## plot2.R
## Produces the Global Active Power time series

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

png(file="plot2.png", width=480, height=480, bg="transparent")
plot(Global_active_power ~ datetime, plotdf, xlab=NA, 
     ylab="Global Active Power (kilowatts)", 
     type="l")
dev.off()

