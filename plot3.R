
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

# open the plot devide, create the plot (as theoverlaping of three different plots) and close the connection
png("./plot3.png",width=480,height=480)
x <- strptime(paste(mydata$Date,mydata$Time),"%d/%m/%Y %H:%M:%S")
y1 = mydata$Sub_metering_1
y2 = mydata$Sub_metering_2
y3 = mydata$Sub_metering_3

x <- strptime(paste(mydata$Date,mydata$Time),"%d/%m/%Y %H:%M:%S")
y1 = mydata$Sub_metering_1
y2 = mydata$Sub_metering_2
y3 = mydata$Sub_metering_3

ylimits = range(c(mydata$Sub_metering_1, mydata$Sub_metering_2, mydata$Sub_metering_3))
plot(x, y1, xlab = "", ylab = "Energy sub metering", type = "l", ylim = ylimits, col = "black")
par(new=TRUE)
plot(x, y2, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "red")
par(new=TRUE)
plot(x, y3, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="y", border = "black", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
