#Created by Khoi Phan - pkhoi176@gmail.com

#The requirements:
#       1.Merges the training and the test sets to create one data set.
#       2.Extracts only the measurements on the mean and standard deviation for each measurement.
#       3.Uses descriptive activity names to name the activities in the data set.
#       4.Appropriately labels the data set with descriptive variable names.
#       5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#IMPORTANT NOTE: 
#       + PLACE THE SCRIPT IN THE EXTRACTED FOLDER OBTAINED FORM THE ZIP FILE.
#       + SINCE THE TWO FINAL DATA DONT NEED EVERY COLUMN IN THE RAW DATA SO I DON'T WIRTE THE SCRIPT AS THE ORDER OF THE REQUIREMENTS.
#       + THE NAME OF VARIABLES WILL BE THE NAME IN THE "features.txt" SINCE THE AUTHOR DID A GREAT JOB IN NAMING THE VARIABLES.

#FIRST STEP: PREPARATION

#Load the file contains information about column name and position (default = "features.txt")
library(data.table)
colInfo = read.table("features.txt", col.names = c("colidx", "description"))
#       The point is use "colClasses" in function read.table to skip unecessary columns so:
colIdx = rep("NULL", times = nrow(colInfo)) #Create a vector of nrow(colInfo) with each element has the value of "NULL"
colNames = gsub("\\(\\)","",colInfo[,2]) #Create variable hold the name of columns
replaceInfo = grep(pattern = "*.mean\\(\\).*|*.std\\(\\).*",x = colInfo$description) #Get the index of all columns that have "mean" or "std"
colIdx[replaceInfo] = NA #Since the value of each vector is number
#       Load raw vector data
rawTrain = read.table("train/X_train.txt",colClasses = colIdx, col.names = colNames)
rawTest = read.table("test/X_test.txt",colClasses = colIdx, col.names = colNames)
#       Load the subjects and set column name
subjectTrain = read.table("train/subject_train.txt",col.names = "subject")
subjectTest = read.table("test/subject_test.txt",col.names = "subject")
#       Load the activity label and change it to the name specify in "activity_labels.txt"
activityTrain = read.table("train/y_train.txt", col.names = "activity")
activityTest = read.table("test/y_test.txt", col.names = "activity")
activityLabels = read.table("activity_labels.txt", col.names = c("idx","labels"))

acLabelsTrain  = as.character(merge(activityTrain,activityLabels, by.x = "activity", by.y = "idx")[,2])
acLabelsTest  = as.character(merge(activityTest,activityLabels, by.x = "activity", by.y = "idx")[,2])

#       Remove unecessary variable
remove(list = c("activityTrain", "activityTest", "activityLabels", "colInfo", "colIdx", "colNames", "replaceInfo"))

#SECOND sTEP: CREATE THE FIRST DATASET

#Add collum to table
train = cbind(subjectTrain,acLabelsTrain,rawTrain)
setnames(train, c("acLabelsTrain"), c("activity"))
test = cbind(subjectTest,acLabelsTest,rawTest)
setnames(test, c("acLabelsTest"), c("activity"))
#Finally append test to train
wearableData = rbind(train, test)
#       Remove unecessary variable
remove(list = c("train", "test","rawTrain","rawTest", "subjectTest", "subjectTrain","acLabelsTest","acLabelsTrain"))

#THIRD sTEP: CREATE THE SECOND DATASET
wearableTidy = aggregate(wearableData[, 3:68], list(wearableData$subject,wearableData$activity), mean)
setnames(wearableTidy, c("Group.1","Group.2"), c("subject", "activity"))
wearableTidy = wearableTidy[order(wearableTidy$subject),]

#FINALLY, WE HAVE TWO DATASET THAT SATISFIED THE REQUIREMENT: wearableData AND wearableTidy
#TO SAVE THE DATASETS, RUN THESE LINES:
#write.table(wearableData, "wearableData.txt",row.names=FALSE)
write.table(wearableTidy, "wearableTidy.txt",row.names=FALSE)
