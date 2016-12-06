# Load Power Consumption Data, convert date field to date

all_pwr_data <- read.table("household_power_consumption.txt", header= TRUE, sep = ";")
all_pwr_data$Date <- as.Date(all_pwr_data$Date, format="%d/%m/%Y")

# Load subset data, concat date/time, convert to numeric

subDates <- subset(all_pwr_data, all_pwr_data$Date >= "2007-02-01" & all_pwr_data$Date <= "2007-02-02")

subDates$DateTime <- as.POSIXct(paste(subDates$Date, subDates$Time), format="%Y-%m-%d %H:%M:%S")
subDates$Global_active_power <- as.numeric(gsub("\\?","",subDates$Global_active_power))
subDates$Voltage <- as.numeric(gsub("\\?","",subDates$Voltage))
subDates$Sub_metering_1 <- as.numeric(gsub("\\?","",subDates$Sub_metering_1))
subDates$Sub_metering_2 <- as.numeric(gsub("\\?","",subDates$Sub_metering_2))
subDates$Sub_metering_3 <- as.numeric(gsub("\\?","",subDates$Sub_metering_3))

#Create 4 plots and copy to png 

par(mfrow=c(2,2))

#Plot 1
plot(subDates$DateTime, subDates$Global_active_power, type="l", xlab="", ylab="Global Active Power")
#Plot 2
plot(subDates$DateTime, subDates$Voltage, type="l", xlab="datetime", ylab="Voltage")
#Plot 3
plot(subDates$DateTime, subDates$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(subDates$DateTime,subDates$Sub_metering_2,col="red")
lines(subDates$DateTime,subDates$Sub_metering_3,col="blue")

legend("topright", col=c("black","red","blue"), c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 "), lty=c(1,1), bty="n", y.intersp = 0.2, cex=0.5)

#Plot 4
plot(subDates$DateTime, subDates$Global_reactive_power, type="l", xlab="datetime", ylab= "Global_reactive_power")

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()




