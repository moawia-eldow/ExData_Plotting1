# plot2.R

library(sqldf)

# read the data of household power consumption
f  <- file("household_power_consumption.txt")
power_data <- read.csv2(f, stringsAsFactors = FALSE, na.strings = "?")

# select the data on two dates
power_data_feb <- sqldf ("select * from power_data 
                          where Date = '1/2/2007' or Date = '2/2/2007' ")
power_data_feb$Global_active_power <- as.numeric(power_data_feb$Global_active_power)

# paste the date and time in one variable and converted to time
power_data_feb$Date_Time <- paste (power_data_feb$Date, power_data_feb$Time)
power_data_feb$Date_Time <- strptime(power_data_feb$Date_Time, "%d/%m/%Y %H:%M:%S")

x-DT <- as.POSIXct(power_data_feb$Date_Time)
y_GAP <- power_data_feb$Global_active_power

# construct the plot of the time on global active power
plot (x_DT, y_GAP , type = "l", xlab = "", 
      ylab = "Global Active Power (kilowatts)") 
      
# Copy the plot to a PNG file 
dev.copy(png, file = "plot2.png", width=480, height=480)  
dev.off()  
