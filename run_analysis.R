# Getting and Cleaning Data
# Course Project
# run_analysis.R should:
# 1. Merge the training and the test sets
# 2. Extract the measurements on the mean and standard deviation
# 3. Use descriptive activity names to name the activities
# 4. label the data set with descriptive variable names 
# 5. Create a second, independent tidy data set 
#    with the average of each variable for 
#    each activity and each subject.

# libraries to use
library(dplyr)

# download and unzip data files
zipfile <- "dataset.zip"
if (!file.exists(zipfile)) {
     fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
     download.file(fileURL, destfile = zipfile, method = "curl")
     list.files(zipfile)
     dateDownloaded <- date()
     dateDownloaded
}
unzip(zipfile)

# read in training files
train_X <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# read in test files
test_X <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# read in feature names
featureNames <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)

# read in activity names
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)

# set up training set, then delete read-in tables
train <- tbl_df(train_X)
train$activity <- train_y$V1
train$subject <- train_subject$V1
remove(train_X,train_y,train_subject)

# set up test set, then delete read-in tables
test <- tbl_df(test_X)
test$activity <- test_y$V1
test$subject <- test_subject$V1
remove(test_X,test_y,test_subject)

# merge the two sets
testAndTrain <- rbind(test, train)
remove(test, train)

# extract measurements on mean 
# and standard deviation
# The parenthesis \\( was added to grep 
# in order to exclude variables including
# "meanFreq" which is not a strict mean of the
# measured variables
varIndices <- sort(union(
     grep("mean\\(",featureNames$V2),
     grep("std",featureNames$V2)
     ))
meanStdSet <- select(testAndTrain,varIndices,subject,activity)
remove(testAndTrain)

# name the activites
# (note that this works because the 
# activity names were helpfully given 
# in sequential order)
meanStdSet$activity <- factor(meanStdSet$activity,
                             labels = activities$V2)

# add descriptive variable names
# (ditto note above, also because the variables are
# now in position 1:length(varIndices) in the
# data table)
names(meanStdSet)[1:length(varIndices)] <- featureNames$V2[varIndices]

# make a second data set 
# with avg of each variable 
# for each activity and subject
# (this possibly-still experimental method came from 
# http://stackoverflow.com/questions/22644804/how-can-i-use-dplyr-to-apply-a-function-to-all-non-group-by-columns )
summary <- meanStdSet %>% 
     group_by(subject,activity) %>% 
     summarise_each(funs(mean))

# write summary to a file using write.table
write.table(summary,"swissconfetti_getdata009_tidyset.txt",row.name = FALSE)
