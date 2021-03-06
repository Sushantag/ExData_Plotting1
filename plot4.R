#Read just two lines to extract the header
header <- read.table("household_power_consumption.txt", header = T, sep = ";", nrows = 2, na.strings = "?")

#Read the lines relevant to 1-Feb-2007 to 2-Feb-2007
hpc <- read.table("household_power_consumption.txt", header = F, sep = ";", skip = 66637, nrows = 2880, na.strings = "?")

#assign header to hpc data frame
names(hpc) <- names(header)

#delete header data frame
rm(header)

#combine Date and Time Columns and convert to R date and time format
hpc$Date_Time <- paste(hpc$Date, hpc$Time, sep = " ")
hpc$Date_Time <- strptime(hpc$Date_Time, "%d/%m/%Y %H:%M:%S")

#Plot 4
png("plot4.png",width=480,height=480)
par(mfcol = c(2,2))

#Global Active Power Plot
plot(hpc$Date_Time, hpc$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

#Sub-metering plot
plot(hpc$Date_Time, hpc$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(hpc$Date_Time, hpc$Sub_metering_1)
lines(hpc$Date_Time, hpc$Sub_metering_2, col="red")
lines(hpc$Date_Time, hpc$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), bty = "n", cex = 0.8)

#Voltage Plot
plot(hpc$Date_Time, hpc$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

#Reactive Power Plot
plot(hpc$Date_Time, hpc$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")

dev.off()
