# Load Power Consumption Data, convert date field to date

all_pwr_data <- read.table("household_power_consumption.txt", header= TRUE, sep = ";")
all_pwr_data$Date <- as.Date(all_pwr_data$Date, format="%d/%m/%Y")

# Load subset data, concat date/time, convert to numeric

subDates <- subset(all_pwr_data, all_pwr_data$Date >= "2007-02-01" & all_pwr_data$Date <= "2007-02-02")

subDates$DateTime <- as.POSIXct(paste(subDates$Date, subDates$Time), format="%Y-%m-%d %H:%M:%S")

subDates$Global_active_power <- as.numeric(gsub("\\?","",subDates$Global_active_power))

#Create plot and copy to png 

with(subDates, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()




