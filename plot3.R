# Preparazione Dataset

Sys.setlocale("LC_TIME", "English")

dataset <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")
data <- subset(dataset, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

Datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(Datetime)

# Grafico 3


# Creazione del grafico senza etichette automatiche sull'asse x
with(data, 
     plot(Datetime, Sub_metering_1, 
          type="l", 
          ylab="Energy sub metering", 
          xlab="", 
          xaxt="n"
     ) # Disattiva l'asse x predefinito
)

lines(data$Datetime, data$Sub_metering_2, col = "red")
lines(data$Datetime, data$Sub_metering_3, col = "blue")

# Personalizzazione dell'asse x con le etichette corrette
axis(1, 
     at=seq(min(data$Datetime), max(data$Datetime) + 86400 , by="day"), 
     labels=strftime(seq(min(data$Datetime), max(data$Datetime) + 86400, by="day"), "%a"))

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"), lty = 1)

dev.copy(png, file = "plot3.png")  
dev.off()
