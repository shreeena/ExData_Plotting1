url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile="hpc.zip","internal")
unzip("C:/Users/Serena/ExData_Plotting1/hpc.zip")
#dat<-read.table("household_power_consumption.txt",nrows=100, sep=";",header =TRUE)
classes<-sapply(dat,class)
#data<-fread("household_power_consumption.txt",sep=";", header=TRUE,colClasses=classes)

start<-grep("\\b1/2/2007\\b",readLines("household_power_consumption.txt"))
end<-grep("\\b3/2/2007\\b",readLines("household_power_consumption.txt"))

numRows=end[1]-start[1]
header<-read.table("household_power_consumption.txt", header=FALSE, sep=";",nrow=1)
data<-read.table("household_power_consumption.txt", header=FALSE, sep=";", skip=start[1]-1, nrows=numRows)
colnames(data)<-unlist(header)

data$Date<-as.Date(data$Date,format = "%d/%m/%Y")
data$Time<-format(strptime(data$Time,"%H:%M:%S"),"%H:%M:%S")

hist(data$Global_active_power,xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

