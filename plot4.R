# Preparazione Dataset

Sys.setlocale("LC_TIME", "English")

dataset <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")
data <- subset(dataset, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

Datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(Datetime)

# Grafico 4

par(mfrow = c(2, 2))
with(data, {
  plot(Datetime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
  axis(1, 
       at=seq(min(data$Datetime), max(data$Datetime) + 86400 , by="day"), 
       labels=strftime(seq(min(data$Datetime), max(data$Datetime) + 86400, by="day"), "%a"))
  
  plot(Datetime, Voltage, type="l", ylab="Voltage", xlab="datetime", xaxt="n")
  axis(1, 
       at=seq(min(data$Datetime), max(data$Datetime) + 86400 , by="day"), 
       labels=strftime(seq(min(data$Datetime), max(data$Datetime) + 86400, by="day"), "%a"))
  
  plot(Datetime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", xaxt="n")
  lines(data$Datetime, data$Sub_metering_2, col = "red")
  lines(data$Datetime, data$Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black","red","blue"), cex = 0.8, lty = 1 , bty = "n")
  
  axis(1, 
       at=seq(min(data$Datetime), max(data$Datetime) + 86400 , by="day"), 
       labels=strftime(seq(min(data$Datetime), max(data$Datetime) + 86400, by="day"), "%a"))
  
  plot(Datetime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", xaxt="n")
  axis(1, 
       at=seq(min(data$Datetime), max(data$Datetime) + 86400 , by="day"), 
       labels=strftime(seq(min(data$Datetime), max(data$Datetime) + 86400, by="day"), "%a"))
  
})

dev.copy(png, file = "Plot4.png")  
dev.off()