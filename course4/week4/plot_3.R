if (!require('dplyr')) install.packages('dplyr')
if (!require('plyr')) install.packages('plyr')
if (!require('data.table')) install.packages('data.table')
if (!require('ggplot2')) install.packages('ggplot2')
if (!require('gridExtra')) install.packages('gridExtra')
library(dplyr)
library(plyr)
library(data.table)
library(ggplot2)
library(gridExtra)  

# 𝚏𝚒𝚙𝚜: A five-digit number (represented as a string) indicating the U.S. county
# 𝚂𝙲𝙲: The name of the source as indicated by a digit string (see source code classification table)
# 𝙿𝚘𝚕𝚕𝚞𝚝𝚊𝚗𝚝: A string indicating the pollutant
# 𝙴𝚖𝚒𝚜𝚜𝚒𝚘𝚗𝚜: Amount of PM2.5 emitted, in tons
# 𝚝𝚢𝚙𝚎: The type of source (point, non-point, on-road, or non-road)
# 𝚢𝚎𝚊𝚛: The year of emissions recorded

setwd("~/repos/Coursera/course4/week4")
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip',
              destfile = 'dataset.zip',
              method = 'curl')
if (file.exists('./data')) unlink('data', recursive=TRUE)
dir.create('./data')
zipF <- list.files(path = "./", pattern = "dataset.zip", full.names = TRUE)
a<-ldply(.data = zipF, .fun = unzip, exdir = './data')


DAT <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# assignment 3

fips <- '24510'
DAT <- subset(DAT, DAT$fips=='24510')
dt <- data.table(DAT[,c('year', 'type','Emissions')])
setnames(dt, c('Year', 'Type', 'PM2.5')) 

png(filename="plot_3.png")
dt1 <- subset(dt, dt$Type=='POINT')
dt1 <- dt1[, sum(PM2.5), by = list(Year, Type)]
names(dt1)[names(dt1) == "V1"] = "PM2.5"
qP1 <- qplot(dt1$Year,dt1$PM2.5, data=dt1, color='red') + geom_line() + ylab('PM2.5 (in Tns)') + xlab('POINT') + theme(legend.position="none")

dt2 <- subset(dt, dt$Type=='NONPOINT')
dt2 <- dt2[, sum(PM2.5), by = list(Year, Type)]
names(dt2)[names(dt2) == "V1"] = "PM2.5"
qP2 <- qplot(dt2$Year,dt2$PM2.5, data=dt2, color='red') + geom_line() + ylab('PM2.5 (in Tns)') + xlab('NONPOINT') + theme(legend.position="none")

dt3 <- subset(dt, dt$Type=='ON-ROAD')
dt3 <- dt3[, sum(PM2.5), by = list(Year, Type)]
names(dt3)[names(dt3) == "V1"] = "PM2.5"
qP3 <- qplot(dt3$Year,dt3$PM2.5, data=dt3, color='red') + geom_line() + ylab('PM2.5 (in Tns)') + xlab('ON-ROAD') + theme(legend.position="none")

dt4 <- subset(dt, dt$Type=='NON-ROAD')
dt4 <- dt4[, sum(PM2.5), by = list(Year, Type)]
names(dt4)[names(dt4) == "V1"] = "PM2.5"
qP4 <- qplot(dt4$Year,dt4$PM2.5, data=dt4, color='red') + geom_line() + ylab('PM2.5 (in Tns)') + xlab('NON-ROAD') + theme(legend.position="none")

grid.arrange(qP1, qP2, qP3, qP4, ncol=2, top = "Baltimore,MD - Emissions 1999-2008")
dev.off()
