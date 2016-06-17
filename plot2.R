##download the file and unzip it
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")
unzip("./data/household_power_consumption.zip")

##download data for Feb1 and Feb2, create a table with Column Names
data <- read.table("household_power_consumption.txt", header=FALSE, sep=";", skip = grep("31/1/2007;23:59:00", readLines("./data/household_power_consumption.txt")), nrows=2880)
cols <- read.table("household_power_consumption.txt", header=TRUE, sep=";", nrows=1)

##Convert Data to time format, combine Time and Date to create new colume datetime, copy column names
data$V10 <- paste(data$V1, data$V2, sep=" ")
data$V10 <- strptime(data$V10, format="%d/%m/%Y %H:%M:%S")
data$V1 <- as.Date(data$V1, format="%d/%m/%Y")
data$V2 <- strptime(data$V2, format="%H:%M:%S")
names(data) <- c(names(cols),"datetime")

##Create plot for Plot 2  
png(file="plot2.png", bg = "transparent")
with(data, plot(datetime, Global_active_power, type="l", xlab=" ", ylab = "Global Active Power (kilowatts)"))
dev.off()