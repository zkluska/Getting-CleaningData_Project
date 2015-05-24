##Getting & Cleaning Data Coursera Course Project
##Presumes dplyr() package already installed
##
## Instructions:
## You should create one R script called run_analysis.R that does the following. 
##      1. Merges the training and the test sets to create one data set.
##      2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##      3. Uses descriptive activity names to name the activities in the data set
##      4. Appropriately labels the data set with descriptive variable names. 
##      5. From the data set in step 4, creates a second, independent tidy data set with the 
##              average of each variable for each activity and each subject.

##Load Packages
library(plyr)
library(dplyr)

## Download and extract raw dataset
 if (!file.exists("./wearable_tech.zip")){
        fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileurl,destfile="wearable_tech.zip")
        list.files()
        dateDownloaded <- date()
        dateDownloaded
 }
 if (!file.exists(".//UCI HAR Dataset")){
        unzip("wearable_tech.zip")
 }

##      1. Merges the training and the test sets to create one data set.
 x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
 x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
 x_test_train <-rbind(x_test,x_train)

##      2. Extracts only the measurements on the mean and standard deviation for each measurement.
 ## First get the correct Features (columns) from the merged dataset
 features <- read.table("UCI HAR Dataset/features.txt")                              ## read in column labels
 mean_col_labels <- filter(features,grepl("mean()",V2,fixed=TRUE))   ## isolate column labels for "mean()" features
 std_col_labels <- filter(features,grepl("std()",V2,fixed=TRUE))     ## isolate column labels for "std()" features
 mean_std_col_labels <- rbind(mean_col_labels,std_col_labels)        ## merge the two label data sets
 mean_std_col_labels_sorted <- arrange(mean_std_col_labels,V1)       ## sort the merged label data set

 ## Select only those columns from merged data set corresponding to mean() or std() labels
 mean_std_test_train <- select(x_test_train,mean_std_col_labels_sorted$V1)

##      3. Uses descriptive activity names to name the activities in the data set
 ## Merge the two Activity data sets into one
 y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
 y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
 activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
 y_test_train <-rbind(y_test,y_train)

 ## Replace  Activity values with descriptive activity names
 y_test_train_labeled <- mapvalues(y_test_train[,1],from = activity_labels[,1], 
             to = c("walking","walking_upstairs","walking_downstairs","sitting","standing","laying"))

 ## Add descriptive activity names to the main (x_test_train) dataset
 mean_std_test_train_activity <- mutate(mean_std_test_train,Activity=y_test_train_labeled)

##      4. Appropriately label the data set with descriptive variable names. 
 a <- rename(mean_std_test_train_activity, c("V1" = "tBodyAcc_mean_X"))
 a <- rename(a, c("V2" = "tBodyAcc_mean_Y"))
 a <- rename(a, c("V3" = "tBodyAcc_mean_Z"))
 a <- rename(a, c("V4" = "tBodyAcc_std_X"))
 a <- rename(a, c("V5" = "tBodyAcc_std_Y"))
 a <- rename(a, c("V6" = "tBodyAcc_std_Z"))
 a <- rename(a, c("V41" = "tGravityAcc_mean_X"))
 a <- rename(a, c("V42" = "tGravityAcc_mean_Y"))
 a <- rename(a, c("V43" = "tGravityAcc_mean_Z"))
 a <- rename(a, c("V44" = "tGravityAcc_std_X"))
 a <- rename(a, c("V45" = "tGravityAcc_std_Y"))
 a <- rename(a, c("V46" = "tGravityAcc_std_Z"))
 a <- rename(a, c("V81" = "tBodyAccJerk_mean_X"))
 a <- rename(a, c("V82" = "tBodyAccJerk_mean_Y"))
 a <- rename(a, c("V83" = "tBodyAccJerk_mean_Z"))
 a <- rename(a, c("V84" = "tBodyAccJerk_std_X"))
 a <- rename(a, c("V85" = "tBodyAccJerk_std_Y"))
 a <- rename(a, c("V86" = "tBodyAccJerk_std_Z"))
 a <- rename(a, c("V121" = "tBodyGyro_mean_X"))
 a <- rename(a, c("V122" = "tBodyGyro_mean_Y"))
 a <- rename(a, c("V123" = "tBodyGyro_mean_Z"))
 a <- rename(a, c("V124" = "tBodyGyro_std_X"))
 a <- rename(a, c("V125" = "tBodyGyro_std_Y"))
 a <- rename(a, c("V126" = "tBodyGyro_std_Z"))
 a <- rename(a, c("V161" = "tBodyGyroJerk_mean_X"))
 a <- rename(a, c("V162" = "tBodyGyroJerk_mean_Y"))
 a <- rename(a, c("V163" = "tBodyGyroJerk_mean_Z"))
 a <- rename(a, c("V164" = "tBodyGyroJerk_std_X"))
 a <- rename(a, c("V165" = "tBodyGyroJerk_std_Y"))
 a <- rename(a, c("V166" = "tBodyGyroJerk_std_Z"))
 a <- rename(a, c("V201" = "tBodyAccMag-mean"))
 a <- rename(a, c("V202" = "tBodyAccMag-std"))
 a <- rename(a, c("V214" = "tGravityAccMag-mean"))
 a <- rename(a, c("V215" = "tGravityAccMag-std"))
 a <- rename(a, c("V227" = "tBodyAccJerkMag-mean"))
 a <- rename(a, c("V228" = "tBodyAccJerkMag-std"))
 a <- rename(a, c("V240" = "tBodyGyroMag-mean"))
 a <- rename(a, c("V241" = "tBodyGyroMag-std"))
 a <- rename(a, c("V253" = "tBodyGyroJerkMag_mean"))
 a <- rename(a, c("V254" = "tBodyGyroJerkMag_std"))
 a <- rename(a, c("V266" = "fBodyAcc-mean()-X"))
 a <- rename(a, c("V267" = "fBodyAcc-mean()-Y"))
 a <- rename(a, c("V268" = "fBodyAcc-mean()-Z"))
 a <- rename(a, c("V269" = "fBodyAcc-std()-X"))
 a <- rename(a, c("V270" = "fBodyAcc-std()-Y"))
 a <- rename(a, c("V271" = "fBodyAcc-std()-Z"))
 a <- rename(a, c("V345" = "fBodyAccJerk-mean()-X"))
 a <- rename(a, c("V346" = "fBodyAccJerk-mean()-Y"))
 a <- rename(a, c("V347" = "fBodyAccJerk-mean()-Z"))
 a <- rename(a, c("V348" = "fBodyAccJerk-std()-X"))
 a <- rename(a, c("V349" = "fBodyAccJerk-std()-Y"))
 a <- rename(a, c("V350" = "fBodyAccJerk-std()-Z"))
 a <- rename(a, c("V424" = "fBodyGyro-mean()-X"))
 a <- rename(a, c("V425" = "fBodyGyro-mean()-Y"))
 a <- rename(a, c("V426" = "fBodyGyro-mean()-Z"))
 a <- rename(a, c("V427" = "fBodyGyro-std()-X"))
 a <- rename(a, c("V428" = "fBodyGyro-std()-Y"))
 a <- rename(a, c("V429" = "fBodyGyro-std()-Z"))
 a <- rename(a, c("V503" = "fBodyAccMag-mean()"))
 a <- rename(a, c("V504" = "fBodyAccMag-std()"))
 a <- rename(a, c("V516" = "fBodyBodyAccJerkMag-mean()"))
 a <- rename(a, c("V517" = "fBodyBodyAccJerkMag-std()"))
 a <- rename(a, c("V529" = "fBodyBodyGyroMag-mean()"))
 a <- rename(a, c("V530" = "fBodyBodyGyroMag-std()"))
 a <- rename(a, c("V542" = "fBodyBodyGyroJerkMag-mean()"))
 a <- rename(a, c("V543" = "fBodyBodyGyroJerkMag-std()"))
mean_std_test_train_activity_labeled <- a 


##      5. From the data set in step 4, creates a second, independent tidy data set with the 
##      average of each variable for each activity and each subject.


