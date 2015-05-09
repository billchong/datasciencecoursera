library(dplyr)

## Read in entire table cuz I can
dt = read.table ("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

## Convert Date column to Date objects
dt$Date = as.Date(dt$Date, format="%d/%m/%Y")

## Convert table to tbl format using dpylr package
df <- tbl_df(dt)

##" Filter the rows to fit to get rows within the date period
df2 <- filter (df, Date >= "2007-02-01" & Date <="2007-02-02")

## Convert the Time column to a time object using CHRON
library(chron)
x <- chron(times=df2$Time)
## Find the index for midnight in the Times column
inx <- which (x == "00:00:00")

###################################################################
## Initialize y-axes for all the plots
###################################################################

y11 <- df2$Global_active_power
y12 <- df2$Voltage

y211 <- df2$Sub_metering_1
y212 <- df2$Sub_metering_2
y213 <- df2$Sub_metering_3

y22 <- df2$Global_reactive_power

## Create 2 x 2 grid of plots

png("plot4.png")
par (mfrow = c(2,2))

#######################################################################
## Plot the 1,1 plot
#######################################################################

plot (y11, ylab="Global Active Power (kilowatts)", xlab=" ", xaxt="n", type="l")
##Map midnight to the Thu, Fri and Sat on the axis
axis (1, at=c(inx, length(x)), labels = c("Thu", "Fri", "Sat"))

#######################################################################
## Plot the 1,2 plot
#######################################################################
plot (y12, ylab="Voltage", xlab="datetime", xaxt="n", type="l")
##Map midnight to the Thu, Fri and Sat on the axis
axis (1, at=c(inx, length(x)), labels = c("Thu", "Fri", "Sat"))

#######################################################################
## Plot the 2,1 plot
#######################################################################

plot (y211, ylab=" ", xlab= " ", ylim=c(0,38), xaxt="n", type="l")
par(new=T)
plot (y212, ylab=" ", xlab= " ", ylim=c(0,38), xaxt="n", type="l", col="red")
par(new=T)
plot (y213, ylab="Energy sub metering", xlab= " ", ylim=c(0,38), xaxt="n", type="l", col="blue")
par(new=F)
##Map midnight to the Thu, Fri and Sat on the axis
axis (1, at=c(inx, length(x)), labels = c("Thu", "Fri", "Sat"))

#######################################################################
## Plot the 2,2 plot
#######################################################################

plot (y22, ylab="Global_reactive_power", xlab="datetime", ylim=c(0,0.5), xaxt="n", type="l")
##Map midnight to the Thu, Fri and Sat on the axis
axis (1, at=c(inx, length(x)), labels = c("Thu", "Fri", "Sat"))
dev.off()