# Preparazione Dataset

Sys.setlocale("LC_TIME", "English")

dataset <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")
data <- subset(dataset, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

Datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(Datetime)

# Grafico 1

hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
     col = "red")  

dev.copy(png, file = "plot1.png")  
dev.off()