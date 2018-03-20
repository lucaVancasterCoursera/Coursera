# Course4 - Week1 - assignment 2
# script to produce plot2.png

# function to download and prepare the data
setupAndGetData <- function() {
  #setup
  if (!require('dplyr')) install.packages('dplyr')
  if (!require('plyr')) install.packages('dplyr')
  if (!require('reshape')) install.packages('reshape')
  if (!require('data.table')) install.packages('data.table')
  if (!require('lubridate')) install.packages('lubridate')
  library(reshape)
  library(data.table)
  library(plyr)
  library(dplyr)
  library(lubridate)
  setwd("~/repos/Coursera/course4/week1")
  
  # Getting data
  if (file.exists('./data')) unlink('data', recursive=TRUE)
  dir.create('./figures', showWarnings = FALSE)
  dir.create('./data', showWarnings = FALSE)
  download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
                 destfile = 'dataset.zip', method = 'curl')

  zipF <- list.files(path = "./", pattern = "dataset.zip", full.names = TRUE)
  a<-ldply(.data = zipF, .fun = unzip, exdir = './data')
  
  # Loading data
  dat <- fread('data/household_power_consumption.txt', sep = 'auto', header = FALSE)
  ## We will only be using data from the dates 2007-02-01 and 2007-02-02
  dat <- filter(dat, dat$V1=="1/2/2007" | dat$V1=="2/2/2007")
  return(dat)
}

dat <- setupAndGetData()
labels <- c('date', 'time', 'globalActivePower', 'globalReactivePower', 'voltage', 'globalIntensity', 'subMetering1', 'subMetering2','subMetering3')
dat <- setNames(dat, labels)

dat <- cbind(dat, 'plot2'=strptime(paste(dat$date, dat$time),'%d/%m/%Y %H:%M:%S'))

png(filename="figures/plot3.png")
plot(dat$plot2, 
     dat$globalActivePower, 
     type='n',
     xlab = '',
     ylab = 'Energy sub metering',
     ylim=c(0,30))


lines(dat$plot2, dat$subMetering1, col='black') 
lines(dat$plot2, dat$subMetering2, col='red') 
lines(dat$plot2, dat$subMetering3, col='blue') 
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_1"), 
       lwd = 2, cex = 0.7, col = c("black", "blue", "red"),
       lty = c(1, 1, 1), pch = c(NA, NA, NA))

dev.off()

