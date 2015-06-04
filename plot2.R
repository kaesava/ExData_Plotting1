## plot2.R

## This R script can be used to read and process the 
## household_power_consumption.txt dataset and generate the plots for 
## plot2.png as required by the Coursera course

## Read the dataset

## There is a date column that will be read in as a string of length 10
## (104 bytes using object.size("11/11/1111"))
## There is a time column that will be read in as a string of length 8  
## (104 bytes using object.size("00:00:00"))
## There are 7 numerical columns @ 48 bytes per column = 336 Bytes
## Each record will therefore take 544 bytes
## 2,075,259 rows will therefore take 2075259 * 544 = 1128940896 Bytes 
## = 1102481 KB = 1076.642 MB = 1.0514 GB
## Using worst case scenario - i.e., tripling the estimate (for example, 
## when the data is sorted), 3.15422 GB
## My machine has 8GB of memory, so should be ok.
## I have tested the ability to load using grep (noting that the file is 
## ordered), however, since I have no memory concerns, I choose to load it
## fully and process it.

d<- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
        comment.char = "", quote = "",na.strings = "?", 
        colClasses = c("character", "character", "numeric", "numeric", 
        "numeric", "numeric", "numeric", "numeric", "numeric"), 
        nrows = 2075259, stringsAsFactors=FALSE)

## Create a new column withDate and Time cols joined and converted to Datetime
d$Date_Time <- strptime(paste(d$Date,d$Time), format="%d/%m/%Y %H:%M:%S")

## Subset the dataset to ensure the dataset only contains data for dates for 
## the 2 days of interest - 01-Feb-2007 and 02-Feb-2007
d<- subset(d, as.Date(Date, format='%d/%m/%Y') >= as.Date('2007-02-01') & 
             as.Date(Date, format='%d/%m/%Y') < as.Date('2007-02-03'))

## Open a graphics device (a PNG file in this instance of required dims)
png(filename="plot2.png", width=480, height = 480, units = "px")

## Set the main title, X-Axis title and bar colour as required
## But don't draw the plot yet (type="n")
plot(d$Date_Time, d$Global_active_power, 
     ylab="Global Active Power (kilowatts)", xlab="", type="n")
## Plot the line graph of Global_active_power (Y) by Datetime (X)
lines(d$Date_Time, d$Global_active_power)

## Close the PNG graphics device
dev.off()