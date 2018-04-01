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

# assignment 4
filt <- subset(SCC, 
             grepl("comb", SCC.Level.One, ignore.case=TRUE) & 
             grepl("coal", SCC.Level.Four, ignore.case=TRUE))
DAT <- subset(DAT, DAT$SCC %in% filt$SCC)
dt <- data.table(DAT[,c('year','Emissions')])
dt <- dt[, sum(Emissions), by = year]
setnames(dt, c('Year', 'PM2.5'))

png(filename="plot_4.png")
par(pty="m", plt=c(0.1, 1, 0.1, 1), omd=c(0.1,0.9,0.1,0.9))
plot(dt$Year, dt$PM2.5, type = "n", xaxt = "n", yaxt="n", xlab="", ylab="", log = "x", col="blue")
mtext(side=3, text="Coal combustion: total emissions (PM2.5) per year", line=1.2, cex=1.5)
aty <- seq(par("yaxp")[1], par("yaxp")[2], (par("yaxp")[2] - par("yaxp")[1])/par("yaxp")[3])
axis(2, at=aty, labels=format(aty, scientific=FALSE), hadj=0.9, cex.axis=0.8, las=2)
axis(side = 1)
mtext(side=2, text="PM2.5 (in Tns)", line=4.5)
grid()
lines(dt$Year, dt$PM2.5, col="blue")
points(dt$Year, dt$PM2.5, col="red")
dev.off()