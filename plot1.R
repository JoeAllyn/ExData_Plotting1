# Load Power Consumption Data, convert date field to date

all_pwr_data <- read.table("household_power_consumption.txt", header= TRUE, sep = ";")
all_pwr_data$Date <- as.Date(all_pwr_data$Date, format="%d/%m/%Y")

# Load subset data, concat date/time, convert to numeric

subDates <- subset(all_pwr_data, all_pwr_data$Date >= "2007-02-01" & all_pwr_data$Date <= "2007-02-02")

subDates$DateTime <- as.POSIXct(paste(subDates$Date, subDates$Time), format="%Y-%m-%d %H:%M:%S")

subDates$Global_active_power <- as.numeric(gsub("\\?","",subDates$Global_active_power))

#Create histogram and copy to png 

hist(subDates$Global_active_power, main= "Global Active Power", xlab = "Global Active Power (kilowatts)", col= "red")

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()




