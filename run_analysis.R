# GIven assignment in "Getting and Cleang Data" course
#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#     WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
#Appropriately labels the data set with descriptive variable names. 
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


# The following function can be used to read space bar separated data
#
# Function parameters: fileName - the name of the file to be hadled
#
# Return value is a data.frame containing the data from the file
#
readSpaceSepFileAsNum <- function(fileName) {
  #fileName <- fName
  dataAsCh = readChar(fileName, file.info(fileName)$size)
  dataAsCh <- gsub("  ", " ", dataAsCh)
  myConn <- textConnection(dataAsCh)
  dataF <- read.table(myConn, sep=" ", header=F)
  dataF <- as.data.frame(lapply(dataF, as.numeric))
  close(myConn)
  dataF <- dataF[,2:dim(dataF)[2]]
  return (dataF)
}


## Collect data from test folder - each file to data.frame
testSubj = read.csv("UCI HAR Dataset/test/subject_test.txt", col.names=c("id"), header=F)
testY = read.csv("UCI HAR Dataset/test/y_test.txt",sep=(" "), col.names=c("action"), header=F)
testX <- readSpaceSepFileAsNum("UCI HAR Dataset/test/X_test.txt")
testBodyAccX <- readSpaceSepFileAsNum("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
testBodyAccY <- readSpaceSepFileAsNum("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
testBodyAccZ <- readSpaceSepFileAsNum("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
testBodyGyroX <- readSpaceSepFileAsNum("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
testBodyGyroY <- readSpaceSepFileAsNum("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
testBodyGyroZ <- readSpaceSepFileAsNum("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
testTotalBodyAccX <- readSpaceSepFileAsNum("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
testTotalBodyAccY <- readSpaceSepFileAsNum("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
testTotalBodyAccZ <- readSpaceSepFileAsNum("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")

testData = cbind(testSubj, testY, testX, testBodyAccX, testBodyAccY, testBodyAccZ, testBodyGyroX, testBodyGyroY, testBodyGyroZ, testTotalBodyAccX, testTotalBodyAccY, testTotalBodyAccZ)

## Collect data from train folder - each file to data.frame
trainSubj = read.csv("UCI HAR Dataset/train/subject_train.txt", col.names=c("id"), header=F)
trainY = read.csv("UCI HAR Dataset/train/y_train.txt",sep=(" "), col.names=c("action"), header=F)
trainX <- readSpaceSepFileAsNum("UCI HAR Dataset/train/X_train.txt")
trainBodyAccX <- readSpaceSepFileAsNum("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
trainBodyAccY <- readSpaceSepFileAsNum("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
trainBodyAccZ <- readSpaceSepFileAsNum("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
trainBodyGyroX <- readSpaceSepFileAsNum("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
trainBodyGyroY <- readSpaceSepFileAsNum("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
trainBodyGyroZ <- readSpaceSepFileAsNum("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
trainTotalBodyAccX <- readSpaceSepFileAsNum("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
trainTotalBodyAccY <- readSpaceSepFileAsNum("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
trainTotalBodyAccZ <- readSpaceSepFileAsNum("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

trainData = cbind(trainSubj, trainY, trainX, trainBodyAccX, trainBodyAccY, trainBodyAccZ, trainBodyGyroX, trainBodyGyroY, trainBodyGyroZ, trainTotalBodyAccX, trainTotalBodyAccY, trainTotalBodyAccZ)

## Merge data by measurement
subj = rbind(trainSubj, testSubj)
y = rbind(trainY, testY)
x = rbind(trainX, testX)
bodyAccX = rbind(trainBodyAccX, testBodyAccX)
bodyAccY = rbind(trainBodyAccY, testBodyAccY)
bodyAccZ = rbind(trainBodyAccZ, testBodyAccZ)
bodyGyroX = rbind(trainBodyGyroX, testBodyGyroX)
bodyGyroY = rbind(trainBodyGyroY, testBodyGyroY)
bodyGyroZ = rbind(trainBodyGyroZ, testBodyGyroZ)
totalBodyAccX = rbind(trainTotalBodyAccX, testTotalBodyAccX)
totalBodyAccY = rbind(trainTotalBodyAccY, testTotalBodyAccY)
totalBodyAccZ = rbind(trainTotalBodyAccZ, testTotalBodyAccZ)

# this was required but not really needed
oneDataSet <- rbind(testData, trainData)

## Calculate means and stdevs rowvise
xMean <- rowMeans(x,na.rm=T)
xMean.colnames=c("xMean")
xSd <- apply(x, 1, sd, na.rm=TRUE)
xSd.colnames=c("xSd")
bodyAccXMean <- rowMeans(bodyAccX,na.rm=T)
bodyAccXMean.colnames=c("bodyAccXMean")
bodyAccXSd <- apply(bodyAccX, 1, sd, na.rm=TRUE)
bodyAccXSd.colnames=c("bodyAccXSd")
bodyAccYMean <- rowMeans(bodyAccY,na.rm=T)
bodyAccYMean.colnames=c("bodyAccYMean")
bodyAccYSd <- apply(bodyAccY, 1, sd, na.rm=TRUE)
bodyAccYSd.colnames=c("bodyAccYSd")
bodyAccZMean <- rowMeans(bodyAccZ,na.rm=T)
bodyAccZMean.colnames=c("bodyAccZMean")
bodyAccZSd <- apply(bodyAccZ, 1, sd, na.rm=TRUE)
bodyAccZSd.colnames=c("bodyAccZSd")
bodyGyroXMean <- rowMeans(bodyGyroX,na.rm=T)
bodyGyroXMean.colnames=c("bodyGyroXMean")
bodyGyroXSd <- apply(bodyGyroX, 1, sd, na.rm=TRUE)
bodyGyroXSd.colnames=c("bodyGyroXSd")
bodyGyroYMean <- rowMeans(bodyGyroY,na.rm=T)
bodyGyroYMean.colnames=c("bodyGyroYMean")
bodyGyroYSd <- apply(bodyGyroY, 1, sd, na.rm=TRUE)
bodyGyroYSd.colnames=c("bodyGyroYSd")
bodyGyroZMean <- rowMeans(bodyGyroZ,na.rm=T)
bodyGyroZMean.colnames=c("bodyGyroZMean")
bodyGyroZSd <- apply(bodyGyroZ, 1, sd, na.rm=TRUE)
bodyGyroZSd.colnames=c("bodyGyroZSd")
totalBodyAccXMean <- rowMeans(totalBodyAccX,na.rm=T)
totalBodyAccXMean.colnames=c("totalBodyAccXMean")
totalBodyAccXSd <- apply(totalBodyAccX, 1, sd, na.rm=TRUE)
totalBodyAccXSd.colnames=c("totalBodyAccXSd")
totalBodyAccXYean <- rowMeans(totalBodyAccY,na.rm=T)
totalBodyAccXYean.colnames=c("totalBodyAccYMean")
totalBodyAccYSd <- apply(totalBodyAccY, 1, sd, na.rm=TRUE)
totalBodyAccYSd.colnames=c("totalBodyAccYSd")
totalBodyAccZMean <- rowMeans(totalBodyAccZ,na.rm=T)
totalBodyAccZMean.colnames=c("totalBodyAccZMean")
totalBodyAccZSd <- apply(totalBodyAccZ, 1, sd, na.rm=TRUE)
totalBodyAccZSd.colnames=c("totalBodyAccZSd")

# Change the activity names in the oneDataSet from numbers to more readable strings
oneDataSet$action[oneDataSet$action == 1] <- "WALKING"
oneDataSet$action[oneDataSet$action == 2] <- "WALKING_UPSTAIRS"
oneDataSet$action[oneDataSet$action == 3] <- "WALKING_DOWNSTAIRS"
oneDataSet$action[oneDataSet$action == 4] <- "SITTING"
oneDataSet$action[oneDataSet$action == 5] <- "STANDING"
oneDataSet$action[oneDataSet$action == 6] <- "LAYING"

# combine all needed data to one data.frame
dataGathered <- oneDataSet[,1:2]
dataGathered <- cbind(dataGathered, xMean, bodyAccXMean, bodyAccYMean, bodyAccZMean)
dataGathered <- cbind(dataGathered, bodyGyroXMean, bodyGyroYMean, bodyGyroZMean)
dataGathered <- cbind(dataGathered, totalBodyAccXMean, totalBodyAccXYean, totalBodyAccZMean)

# handle it as table to make aggregation easy and finally write result to csv file
require(data.table)
tidyDataTable <- data.table(dataGathered)
tidyDataTable[,list(xMean=mean(xMean), bodyAccXMean=mean(bodyAccXMean), bodyAccYMean=mean(bodyAccYMean), bodyAccZMean=mean(bodyAccZMean), bodyGyroXMean=mean(bodyGyroXMean), bodyGyroYMean=mean(bodyGyroYMean), bodyGyroZMean=mean(bodyGyroZMean), totalBodyAccXMean=mean(totalBodyAccXMean), totalBodyAccXYean=mean(totalBodyAccXYean), totalBodyAccZMean=mean(totalBodyAccZMean)), by=list(id,action)]
tidyData <- data.frame(tidyDataTable)
write.csv(tidyData, "tidyData.csv")