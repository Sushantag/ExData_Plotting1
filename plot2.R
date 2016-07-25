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

#Plot 2
png("plot2.png",width=480,height=480)
plot(hpc$Date_Time, hpc$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
