# plot4.R

library(sqldf)

# read the data of household power consumption
f  <- file("household_power_consumption.txt")
power_data <- read.csv2(f, stringsAsFactors = FALSE, na.strings = "?")

# select the data on two dates
power_data_feb <- sqldf ("select * from power_data 
                          where Date = '1/2/2007' or Date = '2/2/2007' ")

# paste the date and time in one variable and converted to time
power_data_feb$Date_Time <- paste (power_data_feb$Date, power_data_feb$Time)
power_data_feb$Date_Time <- strptime(power_data_feb$Date_Time, "%d/%m/%Y %H:%M:%S")

x_DT <- as.POSIXct(power_data_feb$Date_Time)
y_GAP <- as.numeric(power_data_feb$Global_active_power)
y_GRP <- as.numeric(power_data_feb$Global_reactive_power)
y_Vol <- as.numeric(power_data_feb$Voltage)
y1_SM <- as.numeric(power_data_feb$Sub_metering_1)
y2_SM <- as.numeric(power_data_feb$Sub_metering_2)
y3_SM <- as.numeric(power_data_feb$Sub_metering_3)

par(mfrow=c(2,2)) 

# construct the first plot of the time on global active power
plot (x_DT, y_GAP , type = "l", xlab = "", 
      ylab = "Global Active Power (kilowatts)")

# construct the second plot of the time on voltage
plot (x_DT, y_Vol , type = "l", xlab = "datetime", 
      ylab = "Voltage")

# construct the third plot of the time on the three sub meterings
plot (x_DT, y1_SM, type = "l", xlab = "", 
      ylab = "Energy Sub Metering", col ="black")
lines (x_DT, y2_SM, col = "red")
lines (x_DT, y3_SM, col = "blue")
legend("topright", lty = 1, lwd = 1, bty = "n", cex = 0.5, 
       col = c("black","blue", "red"), 
      legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      
# construct the fourth plot of the time on global relative power
plot (x_DT, y_GRP , type = "l", xlab = "datetime", 
      ylab = "Global Relative Power")

# Copy the combined plots to a PNG file 
dev.copy(png, file = "plot4.png", width=480, height=480)  
dev.off()  
