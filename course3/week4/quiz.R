download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv',
              destfile="data4_1.csv",
              method='curl')
dat1<-read.csv(file='data4_1.csv', header=TRUE)
head(dat1)
names(dat1)
grep('wgtp', names(dat1), value=TRUE)
s<-strsplit(names(dat1), 'wgtp')
s[123]

install.packages('stringr')
library('stringr')
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv',
              destfile='data4_2.csv',
              method='curl')
dat2 <- read.csv(file='data4_2.csv', header=TRUE, skip=4)
head(dat2$X.4,5)
rep<-function(x) str_replace_all(x, ',', '')
dat2$X.4<-sapply(dat2$X.4, rep)
mean(as.numeric(dat2$X.4[1:190]), na.rm = TRUE)

countryNames<-dat$Long.Name[1:190]
countryNames
grep('^United', countryNames,value = TRUE)
Sys.setlocale('LC_ALL','C')


download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv',
              destfile='data4_5A.csv',
              method='curl')
datGPR <- read.csv(file='data4_5A.csv', header=TRUE, skip=4)
head(datGPR, 10)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv',
              destfile='data4_5B.csv',
              method='curl')
dat5 <- read.csv(file='data4_5B.csv', header=TRUE)
head(dat5)
datGPR <- rename(datGPR, CountryCode = X)

dat51<-inner_join(dat5,datGPR, by="CountryCode" )
grep('June', strsplit(grep('[Ff]iscal year end', dat51$Special.Notes, value = TRUE), '; '), value = TRUE)

install.packages('quantmod')
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
head(sampleTimes, 10)
names(sampleTimes)
dd<-as.Date(sampleTimes, '%Y%m%d')
length(dd[format(dd, '%Y')==2012])
length(dd[format(dd, '%Y')==2012 & format(dd, '%a')=='Mon'])
format(dd, '%a')
