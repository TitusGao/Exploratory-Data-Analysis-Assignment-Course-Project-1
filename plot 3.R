## Loading and preprocessing the data

if (!file.exists('data')) {
    dir.create('data')
}

# Download file and unzip the archive to the current working directory
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile="./data/Power_consumption.zip", method = "curl")
unzip("./data/Power_consumption.zip", exdir="./data")

# Read first 5 rows to get headers
initial <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", nrows=5)

# Read 2900 rows that contain information on 2007-02-01 and 2007-02-02
hpc <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", skip=66630, 
                  nrows=2900, col.names=names(initial), na.strings=c("?"),
                  colClasses=c("character", "character","numeric","numeric","numeric","numeric",
                               "numeric","numeric","numeric"))

# Converting Date and Time variables to Date/Time format
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpc$Time <- strptime(paste(hpc$Date, hpc$Time), "%F %T")

# Subsetting loaded data for 2007-02-01 and 2007-02-02
hpc <- subset(hpc, hpc$Date %in% as.Date(c("2007-02-01","2007-02-02")))


## Creating plots
# Plot 3. Energy sub meterings
par(mfrow=c(1,1), mar=c(4,4,4,2))
plot(hpc$Time, hpc$Sub_metering_1, ylab="Energy sub metering", xlab="", type="l", col="black")
points(hpc$Time, hpc$Sub_metering_2, col="red", type="l")
points(hpc$Time, hpc$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(hpc[, 7:9]))

png("plot3.png", width=480, height=480)
par(mfrow=c(1,1), mar=c(4,4,4,2))
plot(hpc$Time, hpc$Sub_metering_1, ylab="Energy sub metering", xlab="", type="l", col="black")
points(hpc$Time, hpc$Sub_metering_2, col="red", type="l")
points(hpc$Time, hpc$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(hpc[, 7:9]))
dev.off()

