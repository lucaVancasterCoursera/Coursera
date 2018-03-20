# Course4 - Week1 - assignment 1
# script to produce plot1.png

# function to download and prepare the data
setupAndGetData <- function() {
  #setup
  if (!require('dplyr')) install.packages('dplyr')
  if (!require('plyr')) install.packages('dplyr')
  if (!require('reshape')) install.packages('reshape')
  if (!require('data.table')) install.packages('data.table')
  library(reshape)
  library(data.table)
  library(plyr)
  library(dplyr)
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

png(filename="figures/plot1.png")
hist(as.numeric(dat$globalActivePower), 
     main = 'Global Active Power',
     xlab = 'Global Active Power (in kilowatts)',
     col = 'red')
dev.off()

