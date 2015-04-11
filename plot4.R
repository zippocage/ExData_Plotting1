library(tidyr)
library(dplyr)

# load data
df <- read.table(file = "household_power_consumption.txt", 
                 header = TRUE, sep = ";", na.strings = "?", 
                 stringsAsFactors = FALSE)

# convert date and time to full date time column
df <- mutate(df, timestamp = paste(Date, Time, sep = " "))
df$timestamp <- strptime(df$timestamp, "%d/%m/%Y %H:%M:%S")

# drop original columns
df <- select(df, -Date, -Time)

# We will only be using data from the dates 2007-02-01 and 2007-02-02
df <- df[as.Date(df$timestamp) %in% as.Date(c("2007-02-01", "2007-02-02")),]


# time to plot
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

# first plot
plot(x = df$timestamp, y = df$Global_active_power, type = "l",
     main = "", xlab= "", 
     ylab = "Global Active Power (kilowatts)")

# second plot
plot(x = df$timestamp, y = df$Voltage, type = "l",
     main = "", ylab= "Voltage", 
     xlab = "datetime")

# third plot
plot(x = df$timestamp, y = df$Sub_metering_1, 
     type = "l", 
     col = "black",
     main = "", xlab= "", 
     ylab = "Energy sub metering")

lines(x = df$timestamp, y = df$Sub_metering_2
      ,col="red")

lines(x = df$timestamp, y = df$Sub_metering_3
      ,col="blue")

legend("topright", lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# fourth plot
plot(x = df$timestamp, y = df$Global_reactive_power, type = "l",
     main = "", ylab= "Global_reactive_power", 
     xlab = "datetime")


dev.off() ## Don't forget to close the PNG device!