library(dplyr)

## Read in entire table cuz I can
dt = read.table ("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

## Convert Date column to Date objects
dt$Date = as.Date(dt$Date, format="%d/%m/%Y")

## Convert table to tbl using dpylr package
df <- tbl_df(dt)

##" Filter the rows to fit within the date period
df2 <- filter (df, Date >= "2007-02-01" & Date <="2007-02-02")

## Convert the Time column to a time object using CHRON
library(chron)
x <- chron(times=df2$Time)
y1 <- df2$Sub_metering_1
y2 <- df2$Sub_metering_2
y3 <- df2$Sub_metering_3


## Find the index for midnight in the Times column
inx <- which (x == "00:00:00")

## Plot the 3 lines on the same plot
png("plot3.png")
plot (y1, ylab=" ", xlab= " ", ylim=c(0,40), xaxt="n", type="l")
par(new=T)
plot (y2, ylab=" ", xlab= " ", ylim=c(0,40), xaxt="n", type="l", col="red")
par(new=T)
plot (y3, ylab="Energy sub metering", xlab= " ", ylim=c(0,40), xaxt="n", type="l", col="blue")
par(new=F)

##Map midnight to the Thu, Fri and Sat on the axis
axis (1, at=c(inx, length(x)), labels = c("Thu", "Fri", "Sat"))

##Add the legend
legend ("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=2, lty=1)
dev.off() 