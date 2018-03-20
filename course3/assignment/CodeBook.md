# Course 3 - Getting and Cleaning Data Course Project
# Assignment

## Description of the assignment:
Using the following data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Perform the followin activities:
  * Merges the training and the test sets to create one data set.
  * Extracts only the measurements on the mean and standard deviation for each measurement.
  * Uses descriptive activity names to name the activities in the data set
  * Appropriately labels the data set with descriptive variable names.
  * From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Variables:
  * 30 participants
  * 6 tasks: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
  * 561 measurements using 3 axis gyros:
    BodyAcc-XYZ -- body acceleration
    tGravityAcc-XYZ -- gravity acceleration
    tBodyAccJerk-XYZ -- linear acceleration
    tBodyGyro-XYZ -- gyroscope acceleration
    tBodyGyroJerk-XYZ -- angular velocity
    tBodyAccMag -- magnitude of the body acceleration
    tGravityAccMag -- magnitude of the gravity acceleration
    tBodyAccJerkMag -- magnitured of the linear acceleration
    tBodyGyroMag -- magnitude of the gryoscope acceleration
    tBodyGyroJerkMag -- magnitude of the angular velocity
    
## Roadbook of the proposed solution:
The file run_analysis.R contains all required code to run this assignment.

The included functions are:
init(): initializes the required libraries by installing them if required and loading them
setDataFiles(): sets the temp directory and downloads the assignment data file
execute(): main function that performs sequentially all 5 steps of the assignment

It also contains 2 utility functions (loadFile, joinAll) as helpers to these functions.

And, at last, the call to run the whole thing.. should you want to run it... :-)
Enjoy!
