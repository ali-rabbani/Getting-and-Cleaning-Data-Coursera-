#Getting and Cleaning Data Course Project
#Aurthor: Muhammad Ali Rabbani

#This script 
#1 Merges the training and the test sets to create one data set.
#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#3 Uses descriptive activity names to name the activities in the data set
#4 Appropriately labels the data set with descriptive variable names. 
#5 From the data set in step 4, creates a second, independent tidy data set with the average 
#  of each variable for each activity and each subject.

#Downloading and Extracting Data
if(!dir.exists("data")){
  dir.create("data")
}

if(!file.exists("data/project_data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                destfile = "project_data.zip", method = "curl")
}

#extracting data
if(!dir.exists("data/UCI HAR Dataset")){
  unzip("project_data.zip")}

##Loading Data into R
library(dplyr)
library(reshape2)
#Getting activity labels

activity <- read.table("data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F)
activity.names <- activity[, 2]

#Getting feature names
features <- read.table("data/UCI HAR Dataset/features.txt", stringsAsFactors = F)
features.needed.i <- grep("mean|std", features[,2])
features.needed.n <- grep("mean|std", features[,2], value = T) 
features.needed.n <- gsub("-mean", "Mean", features.needed.n)
features.needed.n <- gsub("-std", "StD", features.needed.n)
features.needed.n <- gsub("[()-]", "", features.needed.n)


#Getting test data

testsubject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
testactivity <- read.table("data/UCI HAR Dataset/test/y_test.txt")
testdata <- read.table("data/UCI HAR Dataset/test/X_test.txt")[, features.needed.i]
test <- cbind(testsubject, testactivity, testdata)

#Getting train data

trainsubject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
trainactivity <- read.table("data/UCI HAR Dataset/train/y_train.txt")
traindata <- read.table("data/UCI HAR Dataset/train/X_train.txt")[, features.needed.i]
train <- cbind(trainsubject, trainactivity, traindata)

#merging both

alldata <- rbind(train, test)
colnames(alldata) <- c("Subject", "Activity", features.needed.n)

#Converiting subjects and activities into factors

alldata[,2] <- factor(alldata[,2], levels= activity[,1], labels = activity[,2])
alldata[,1] <- factor(alldata[,1])

#Getting mean of all variables per subject and activity

melted <- melt(alldata, id = c("Subject", "Activity"))
tidydatamean <- dcast(melted, Subject + Activity ~ variable, mean)

#Exporting the file
write.csv(tidydatamean, file = "tidydata.csv", row.names = F)
write.table(tidydatamean, file = "tidydata.txt", row.names = F)
