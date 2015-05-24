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

 ## Add descriptive activity names (new column) to the main (x_test_train) dataset
 mean_std_test_train_activity <- mutate(mean_std_test_train,Activity=y_test_train_labeled)

##      4. Appropriately label the data set with descriptive variable names. 
 names(mean_std_test_train_activity) <- mean_std_col_labels_sorted$V2
 names(mean_std_test_train_activity)[67] <- "Activity"   ## had to re-label the Activity Type column as was overrode w/ "NA" by previous line

##      5. From the data set in step 4, creates a second, independent tidy data set with the 
##      average of each variable for each activity and each subject.
 ## Merge the training and test SUBJECT datasets to create one data set
 subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
 subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
 subject_test_train <-rbind(subject_test,subject_train)        

 ## Add a Subject identifier column to the main (mean_std_test_train_activity) dataset
 mean_std_test_train_activity <- mutate(mean_std_test_train_activity,Subject=subject_test_train[,1])

 ##Group the dataset by Subject & Activity
 Grouped <-group_by(mean_std_test_train_activity,Subject,Activity)

 ##Calculate the Mean of every variable (but the 2 being grouped_by) per the groupings
 Grouped_Mean <- summarise_each(Grouped,funs(mean))

 ##Write the Tidy dataset
 write.table(Grouped_Mean, file = "Tidy_Data.txt", row.name=FALSE)
