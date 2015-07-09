
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


# open the plot devide, create the plot and close the connection
png("./plot2.png",width=480,height=480)

x <- strptime(paste(mydata$Date, mydata$Time),"%d/%m/%Y %H:%M:%S")
y = mydata$Global_active_power
plot(x, y, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

dev.off()
