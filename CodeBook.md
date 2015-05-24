CodeBook.md

2 sections here:
1) Data Transforamtion Steps: (also included as comments in-line code (run_analysis.R)
2) Column/Data Descriptions: A subset of below described columns are in the Tidy Data Set, specifically the MEAN() of every variable, by Subject, by Activity.
-----------------------------------------------------------

1) Data Tranformation Steps:

## Download and extract raw dataset
##      1. Merges the training and the test sets to create one data set.
##      2. Extracts only the measurements on the mean and standard deviation for each measurement.
 ## First get the correct Features (columns) from the merged dataset
 ## read in column labels
 ## isolate column labels for "mean()" features
 ## isolate column labels for "std()" features
 ## merge the two label data sets
 ## sort the merged label data set

 ## Select only those columns from merged data set corresponding to mean() or std() labels
 

##      3. Uses descriptive activity names to name the activities in the data set
 ## Merge the two Activity data sets into one
 
 ## Replace  Activity values with descriptive activity names
 
 ## Add descriptive activity names (new column) to the main (x_test_train) dataset
 
##      4. Appropriately label the data set with descriptive variable names. 
 ## had to re-label the Activity Type column as was overrode w/ "NA" by previous line

##      5. From the data set in step 4, creates a second, independent tidy data set with the 
##      average of each variable for each activity and each subject.
 ## Merge the training and test SUBJECT datasets to create one data set
 
 ## Add a Subject identifier column to the main (mean_std_test_train_activity) dataset
 
 ##Group the dataset by Subject & Activity
 
 ##Calculate the Mean of every variable (but the 2 being grouped_by) per the groupings
 
 ##Write the Tidy dataset

------------------------------------------------------------------------
2) Column/Data Descriptions

A subset of below described columns are in the Tidy Data Set, specifically the MEAN() of every variable, by Subject, by Activity.

The below  originated from the documentation associated w/ data analyzed from this website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
