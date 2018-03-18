
# function to set environment libraries & download if not present
init <- function() {
  if (!require('dplyr')) install.packages('dplyr')
  if (!require('reshape')) install.packages('reshape')
  if (!require('data.table')) install.packages('data.table')
  library(reshape)
  library(data.table)
  library(dplyr)
  # please update to your working directory (for win, use \\ as directory separator)
  setwd('~/repos/Coursera/course3/assignment')
}

# This function sets the temp directory and downloads the assignment data file
setDataFiles <- function() {
  if (file.exists('./data')) unlink('data', recursive=TRUE)
  dir.create('./data', showWarnings = FALSE)
  download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
                destfile='data/dataset.zip', method = 'curl')
  zipF <- list.files(path = "./", pattern = "dataset.zip", full.names = TRUE)
  a<-ldply(.data = zipF, .fun = unzip, exdir = './data')
}

# this is an utility function to load a file in a data.table
loadFile <- function(filename) {
  dat <- fread(paste0('data/',filename), sep = 'auto', header = FALSE)
  return(dat)
}

# this is an utility function to load and join data sets
joinAll <- function(){
  # join person and activities
  t1_1 <- loadFile('UCI HAR Dataset/train/subject_train.txt')
  t1_2 <- loadFile('UCI HAR Dataset/train/y_train.txt')
  t1_3 <- loadFile('UCI HAR Dataset/train/X_train.txt')
  train <- cbind(t1_1, t1_2, t1_3)
  t1_1 <- loadFile('UCI HAR Dataset/test/subject_test.txt')
  t1_2 <- loadFile('UCI HAR Dataset/test/y_test.txt')
  t1_3 <- loadFile('UCI HAR Dataset/test/X_test.txt')
  test <- cbind(t1_1, t1_2, t1_3)
  return (rbind(test, train))
}

# this is the main function orchestrating all assignment tasks
execute <- function() {
  init()
  setDataFiles()
  all <- joinAll()
  # Assignment point 2
  all <- copy(all[,1:8])
  
  # Assignment point 3
  labels <- t(loadFile('UCI HAR Dataset/activity_labels.txt'))[2,]
  all[, 2] <- sapply(all[, 2], function(x) return(labels[x]))
  
  # Assignment point 4
  feat <- loadFile('UCI HAR Dataset/features.txt')
  feat <- copy(feat[,'V2'][1:6])
  q<-as.vector(t(feat))
  names(all) <- c('person', 'activity', q)
  
  # Assignment point 5
  allBis <- copy(all)
  res <- NULL
  for (i in 1:6) {
    q<-melt(allBis[person==i], id=c(2), measure=c(3:8))
    res1 <- as.data.table(cast(q, activity ~ variable, mean))
    res1 <- cbind('person'=i, res1[1:6])
    if (i==1) res <- res1
    else res <- rbind(res, res1)
  }
  return (res)
}

print (execute())

