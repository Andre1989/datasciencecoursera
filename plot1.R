Sys.setlocale("LC_TIME", "English") 
setwd("exdata_data_household_power_consumption")
#Sys.setlocale("LC_TIME", "Portuguese_Portugal")
usefulData = read.table("household_power_consumption.txt",skip=66637,nrows=2880,sep=";", col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage" ,"Global_intensity" ,"Sub_metering_1" ,"Sub_metering_2", "Sub_metering_3"))
usefulData$Date = as.character(usefulData$Date)
usefulData$Time = as.character(usefulData$Time)
DateTime = paste(usefulData$Date, usefulData$Time)
usefulData$DateTime = strptime(DateTime, format="%d/%m/%Y %H:%M:%S")
any(usefulData=="?")
png(file="plot1.png",bg =NA,width = 505, height = 505, units = "px",type =  "cairo")
with(usefulData,hist(Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power"))
dev.off()


