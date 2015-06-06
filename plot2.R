# downloads zip file and unzips the downloaded file
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile="hpc.zip","internal")  
unzip("C:/Users/Serena/ExData_Plotting1/hpc.zip")

# reads subset of data
dat<-read.table("household_power_consumption.txt",nrows=100, sep=";",header =TRUE) # reads first 100 rows of data
classes<-sapply(dat,class) # figures out the class each column of data
start<-grep("\\b1/2/2007\\b",readLines("household_power_consumption.txt")) # reads text file until it finds row where the start date is
end<-grep("\\b3/2/2007\\b",readLines("household_power_consumption.txt")) # reads text file until it finds first row of data after the end data 2/2/2007 
numRows=end[1]-start[1] # number of rows of data we'll need to read
header<-read.table("household_power_consumption.txt", header=FALSE, sep=";",nrow=1) # reads the table for header names
data<-read.table("household_power_consumption.txt", header=FALSE, sep=";", skip=start[1]-1, nrows=numRows) # reads the table for the subset of data by skipping to the first row with dates 2/1/2007 and reading numRows of the data
colnames(data)<-unlist(header) # adds the header to the subset of data we just read

# formats the date and time of data since they are originally both factor classes.
data$Date<-as.Date(data$Date,format = "%d/%m/%Y")
data$datetime<-as.POSIXct(paste(data$Date, as.character(data$Time))) # adds a column to the data called datetime which has both the date and time in the string

png("plot2.png", width=480, height=480)
plot(data$datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
