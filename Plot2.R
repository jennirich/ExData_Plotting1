setwd('C:/Rrepos/Rdata/EDA')
getwd()

#****************************************************************************************************
#GETTING THE DATA (Plotting the data starts at line 60)
#modify this to make the download work

#download the dataset
urlFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(urlFile, destfile = 'C:/Rrepos/Rdata/EDA/household_power_consumption.zip')

#unzip the dataset
unzip('C:/Rrepos/Rdata/EDA/household_power_consumption.zip', unzip = "internal")

#****************************************************************************************************
#READING THE DATA
data02 <- read.table('C:/Rrepos/Rdata/EDA/household_power_consumption.txt', sep = ";", header = T, na.strings = '?')

#getting column names
data0colnames<- colnames(data02)

#taking a subset of the data that has the rows of interest
data <- data02[66600:69600,]
colnames(data) <- data0colnames
rownames(data) <- NULL

#changing date and time from factor to character
data$Date <- as.character(data$Date)
data$Time <- as.character(data$Time)
str(data)

#selecting the first day data
dataA <- grepl('1/2/2007', data$Date)
dataD1 <- data[dataA,]

#selecting the second day data
dataB <- grepl('2/2/2007', data$Date)
dataD2 <- data[dataB,]

#combining the two days to get the full data set
dataF <- rbind(dataD1, dataD2)
rownames(dataF) <- NULL
str(dataF)
head(dataF)
tail(dataF)

#creating a date-time vector for graphing and making it a POSIXct vector
data1 <- paste(dataF$Date, dataF$Time, sep = ' ')
data2 <-strptime(data1, format = '%d/%m/%Y %H:%M:%S')

#adding the date-time vector to the final data set and renaming it
dataF <- cbind(dataF, data2)
str(dataF)
colnames(dataF)[colnames(dataF) == 'data2'] <- 'dateTime'

#data2 <- as.Date(data1, format = '%d/%m/%Y %H:%M:%S')
str(dataF)

#****************************************************************************************************
#PLOTTING THE DATA

#making plot 2
png('plot2.png', width = 480, height = 480, res = 100)
par(mfrow = c(1,1), mar = (c(4,4,2,1)), family = 'sans', font = 2)
plot(dataF$Global_active_power ~ dataF$dateTime, xlab = "", 
     ylab = '', type = 'n', cex.axis = 0.75, 
     font.axis = 2, par(font = 2))
lines(dataF$Global_active_power ~ dataF$dateTime)
mtext('Global Active Power (kilowatts)', side = 2, line = 2.5, cex = 0.75)
dev.off()

#checking on device
dev.cur()
dev.set(2)
