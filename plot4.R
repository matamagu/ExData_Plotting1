#Get all data. Took little time on my laptop.. But loaded after ~ 1 minute
all_data <- read.table("household_power_consumption.txt",header=T,sep=";",colClasses=c("character","character","double","double","double","double","double","double","numeric"),na.strings="?")
#Format the data
all_data$Date <- as.Date(all_data$Date , "%d/%m/%Y")
all_data$Time <- paste(all_data$Date, all_data$Time, sep=" ")
all_data$Time <- strptime(all_data$Time, "%Y-%m-%d %H:%M:%S")

#Get the subset for required date
sub_set <- subset(all_data,Time$year==107 & Time$mon==1 & (Time$mday==1 | Time$mday==2))

env <- par()

#Open file device
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

#Plot
plot(x=(sub_set$Time),y=sub_set$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")

plot(x=(sub_set$Time),y=sub_set$Voltage,type="l",ylab="Voltage",xlab="datetime")

plot(x=(sub_set$Time),y=sub_set$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(x=(sub_set$Time),y=sub_set$Sub_metering_2,col="red")
lines(x=(sub_set$Time),y=sub_set$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="l",col=c("black","red","blue"),lwd=2,cex=0.4)

plot(sub_set$Time, sub_set$Global_reactive_power, type = "l", main = "", xlab = "datetime")

#Close file device
par(env)
dev.off()