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
y <- df2$Global_active_power

## Plot the time series with no X axis
png("plot2.png")
plot (y, ylab="Global Active Power (kilowatts)", xlab=" ", xaxt="n", type="l")

## Find the index for midnight in the Times column
inx <- which (x == "00:00:00")

##Map midnight to the Thu, Fri and Sat on the axis
axis (1, at=c(inx, length(x)), labels = c("Thu", "Fri", "Sat"))
dev.off()