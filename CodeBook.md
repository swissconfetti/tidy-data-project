Description of data included in the “tidy” set
=================

Included in the summary file are average accelerometer and gyroscope measurements from smartphones for each of 30 subjects (numbered 1-30) performing each of six activities (walking, walking upstairs, walking downstairs, sitting, standing, laying).

These signals were used to estimate the following 33 variables for each activity:
  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions, so for each of these features, there are three separate variables

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

From these variables was estimated, for each subject and each instance of an activity, the mean value (-mean()) and standard deviation (-std()) of the variable. Other estimates are provided with the original data set but are not included in the tidy data (notably including an estimate called “-MeanFreq()” which I did NOT include in this analysis).

These mean and standard deviation measurements were subsequently averaged over all instances of an activity for a given subject (for example, if subject 2 was “sitting” 36 times, the variable tBodyAccMag-mean() gives the average of the estimated mean of the variable tBodyAccMag).

For more information on the source of these measurements, please refer to the text files accompanying the UCI HAR dataset, “features_info.txt” and “features.txt”. This dataset can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

