# Load Power Consumption Data, convert date field to date

all_pwr_data <- read.table("household_power_consumption.txt", header= TRUE, sep = ";")
all_pwr_data$Date <- as.Date(all_pwr_data$Date, format="%d/%m/%Y")

# Load subset data, concat date/time, convert to numeric

subDates <- subset(all_pwr_data, all_pwr_data$Date >= "2007-02-01" & all_pwr_data$Date <= "2007-02-02")

subDates$DateTime <- as.POSIXct(paste(subDates$Date, subDates$Time), format="%Y-%m-%d %H:%M:%S")

subDates$Sub_metering_1 <- as.numeric(gsub("\\?","",subDates$Sub_metering_1))
subDates$Sub_metering_2 <- as.numeric(gsub("\\?","",subDates$Sub_metering_2))
subDates$Sub_metering_3 <- as.numeric(gsub("\\?","",subDates$Sub_metering_3))

#Create plot and copy to png 

plot(subDates$DateTime, subDates$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(subDates$DateTime,subDates$Sub_metering_2,col="red")
lines(subDates$DateTime,subDates$Sub_metering_3,col="blue")

legend("topright", col=c("black","red","blue"), c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 "), lty=1, lwd=2 ,xjust=0, y.intersp=0.4)

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()




