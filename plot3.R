#plot3.R

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
y1_SM <- as.numeric(power_data_feb$Sub_metering_1)
y2_SM <- as.numeric(power_data_feb$Sub_metering_2)
y3_SM <- as.numeric(power_data_feb$Sub_metering_3)

# construct the plot of the time on the three sub meterings
plot (x_DT, y1_SM, type = "l", xlab = "", 
      ylab = "Energy Sub Metering", col ="black")
lines (x_DT, y2_SM, col = "red")
lines (x_DT, y3_SM, col = "blue")
legend("topright", lty = 1, cex = 0.5, col = c("black","blue", "red"), 
      legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      
# Copy the plot to a PNG file 
dev.copy(png, file = "plot3.png", width=480, height=480)  
dev.off()  
