if (!require('dplyr')) install.packages('dplyr')
if (!require('plyr')) install.packages('plyr')
if (!require('data.table')) install.packages('data.table')
if (!require('ggplot2')) install.packages('ggplot2')
if (!require('gridExtra')) install.packages('gridExtra')
if (!require('Hmisc')) install.packages('Hmisc')
library(dplyr)
library(plyr)
library(data.table)
library(ggplot2)
library(gridExtra)
library(Hmisc)

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

# assignment 4
fips <- c('24510', '06037')
filt <- subset(SCC, 
             grepl("vehicle", SCC.Level.Two, ignore.case=TRUE))
DAT <- subset(DAT, DAT$SCC %in% filt$SCC & (DAT$fips =='24510' | DAT$fips =='06037'))
dt <- data.table(DAT[,c('year','fips','Emissions')])
dt <- dt[, sum(Emissions), by = c('year', 'fips')]
setnames(dt, c('Year', 'fips', 'PM2.5'))

png(width = 1024, height= 800, filename="plot_6.png")
dt1 <- subset(dt, dt$fips=='24510')
dt1 <- dt1[, sum(PM2.5), by = Year]
names(dt1)[names(dt1) == "V1"] = "PM2.5"
qP1 <- qplot(dt1$Year,dt1$PM2.5, data=dt1, color='red') + geom_line() + ylab('PM2.5 (in Tns)') + xlab('Baltimore City, MD') + theme(legend.position="none") + geom_smooth(method = "lm", se = TRUE)

dt2 <- subset(dt, dt$fips=='06037')
dt2 <- dt2[, sum(PM2.5), by = list(Year, Type)]
names(dt2)[names(dt2) == "V1"] = "PM2.5"
qP2 <- qplot(dt2$Year,dt2$PM2.5, data=dt2, color='red') + geom_line() + ylab('PM2.5 (in Tns)') + xlab('Los Angeles county, CA') + theme(legend.position="none") + geom_smooth(method = "lm", se = TRUE)

grid.arrange(qP1, qP2, ncol=2, top = "Baltimore,MD vs Los Angeles county, CA - Emissions 1999-2008")

dev.off()
