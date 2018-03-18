#setwd('/Users/lucavancaster/repos/Coursera/course3/week1')
#getwd()
#file.exist('')
#dir.crete('')
#list.files()
#download.file('')

#download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv',destfile = './data.csv',method = 'curl')
#dat <- read.csv('./data.csv', header = TRUE)

#head (dat$VAL)
#str(dat$VAL[dat$VAL=24])
#system('defaults write org.R-project.R force.LANG en_US.UTF-8')
#install.packages("rJava")
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile='data3_1.csv', method='curl')

dat <- read.csv('data3_1.csv')
library(dplyr)
select(dat, ACR==3)
quiz3.1<-filter(dat, ACR==3)
head(quiz3.1)

quiz3.1<-filter(dat, ACR==3 & AGS==6)
head(quiz3.1)
which(filter(dat, ACR==3 & AGS==6))
which(dat$ACR==3 & dat$AGS==6)

install.packages('jpeg')
library(jpeg)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg', destfile='instructor.jpg', method='curl')
j<-readJPEG(source='instructor.jpg', native = TRUE )
quantile(j, probs = c(0.3, 0.8))

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', destfile='data3_5.csv', method='curl')
datFin1 <- read.csv('data3_5.csv', header=TRUE, skip=4)
datFin1 <- rename(datFin1, CountryCode = X)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', destfile='data3_5B.csv', method='curl')
dat <- read.csv('data3_5B.csv', header=TRUE)

dat3<-inner_join(dat,datFin1, by="CountryCode" )

dat31 <-filter(dat3, Income.Group %in% c('High income: OECD') ) #, 'High income: nonOECD'
dim(dat3)
summary(dat31)
select(dat1, Income.Goup=='High income: OECD' )
names(dat31)
dat31['Income.Goup']
sum(as.numeric(dat31[, c(32)]))
mean(as.numeric(dat31[, c(32)]), na.rm=TRUE)
names(dat31)

quantile(as.numeric(dat3[, c(32)]), probs = c(0, 0.25, 0.5, 0.75, 1))

