library(dplyr)

## Read in entire table cuz I can
dt = read.table ("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

## Convert Date column to Date objects
dt$Date = as.Date(dt$Date, format="%d/%m/%Y")

## Convert table to tbl using dpylr package
df <- tbl_df(dt)

##" Filter the rows to fit within the date period
df2 <- filter (df, Date >= "2007-02-01" & Date <="2007-02-02")
png ("plot1.png")
hist(df2$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", 
     ylab="Frequency")
dev.off()
