
############################################
# PLACE THIS FILE IN THE WORKING DIRECTORY #
############################################

# if you already have the dataset in ./dataFolder you can skip the first two blocks and run the cobe after require(sqldf)

# create a folder where download data
if (!file.exists("./dataFolder")) {
     dir.create("./dataFolder")
}

# download data and unzip it 
 fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
 download.file(fileUrl, destfile = "./dataFolder/household_power_consumption.zip", method = "wget")
 unzip(zipfile = "./dataFolder/household_power_consumption.zip", exdir = "./dataFolder")


require(sqldf)

# read all the data and then select the piece of data that we are interested in 
mydataAux <- read.csv(file = "./dataFolder/household_power_consumption.txt", 
                       header = TRUE, sep = ";", na.string = "?")  
mydates <- c("1/2/2007","2/2/2007")
mydata <- mydataAux[mydataAux$Date %in% mydates, ]

# open the plot devide, set a 2x2 matrix to contain the plot output, create the plots, 
# close the connection and reset the output format to 1x1 matrix
png("./plot4.png", width=480, height=480)
par(mfrow = c(2, 2))

# top left plot
x <- strptime(paste(mydata$Date,mydata$Time),"%d/%m/%Y %H:%M:%S")
y1 <- mydata$Global_active_power
plot(x, y1, xlab = "", ylab = "Global Active Power", type = "l")

# top right plot
y2 <- mydata$Voltage
plot(x, y2, xlab = "datatime", ylab = "Voltage", type = "l")

# bottom left plot
y31 = mydata$Sub_metering_1
y32 = mydata$Sub_metering_2
y33 = mydata$Sub_metering_3
ylimits = range(c(mydata$Sub_metering_1, mydata$Sub_metering_2, mydata$Sub_metering_3))
plot(x, y31, xlab = "", ylab = "Energy sub metering", type = "l", ylim = ylimits, col = "black")
par(new=TRUE)
plot(x, y32, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "red")
par(new=TRUE)
plot(x, y33, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# bottom right plot
y4 <- mydata$Global_reactive_power
plot(x, y4, xlab = "datatime", ylab = "Global_reactive_power", type = "l")

dev.off()


par(mfrow = c(1, 1))

