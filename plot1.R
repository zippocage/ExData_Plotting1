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
png(filename = "plot1.png", width = 480, height = 480)
hist(df$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off() ## Don't forget to close the PNG device!


