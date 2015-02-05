# plot1.R

library(sqldf)

# read the data of household power consumption
f  <- file("household_power_consumption.txt")
power_data <- read.csv2(f, stringsAsFactors = FALSE, na.strings = "?")

# select the data on two dates
power_data_feb <- sqldf ("select * from power_data 
                          where Date = '1/2/2007' or Date = '2/2/2007' ")

x_GAP <- as.numeric(power_data_feb$Global_active_power)

# constrct the histogram of global active power
hist (x_GAP, main = "Global Active Power", 
      xlab = "Global Active Power (kilowatts)", col ="red")

# Copy the plot to a PNG file 
dev.copy(png, file = "plot1.png", width=480, height=480)  
dev.off() 
