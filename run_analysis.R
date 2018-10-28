run_analysis <- function() {

# Download the dataset.
filename <- "CourseraGetandCleanData.zip"

# Checking if archive already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}

# Checking if folder exists and unzip
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load activities labels and features
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
# Grep men and std from "features"
statsFeatures <- features[grep("mean|std", features[,2]), ]


#load for data for test and train, and select the needed features
XtrainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
XtrainDataStats <- XtrainData[, as.numeric(statsFeatures[,1])]

YtrainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

XtestData <- read.table("./UCI HAR Dataset/test/X_test.txt")
XtestDataStats <- XtestData[, as.numeric(statsFeatures[,1])]

YtestLabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Combine test and train data with labels
combineTrain <- cbind(trainSubject, YtrainLabel, XtrainDataStats)
combineTest <- cbind(testSubject, YtestLabel, XtestDataStats)

# Merge the datasets, combineTrain and combineTest into one dataset.
mergeddata <- rbind(combineTrain, combineTest)

# Clean the labels names then rename with descriptive variable names
statsFeatures[,2]<- gsub("-","_", features_need[,2])
statsFeatures[,2]<- gsub("[()]","", features_need[,2]) #need to add [ ]
colnames(mergeddata) <- c("subject", "activity", statsFeatures[,2])

# Use descriptive activity names to name the activities in the data set
mergeddata$activity <- factor(mergeddata$activity, levels = activities[, 1], labels = activities[, 2])

# Creates a tidy data set with the mean of each variable for each activity and each subject.
datasummary <-aggregate(mergeddata[, 3:ncol(mergeddata)], by=list(mergeddata$subject,mergeddata$activity), FUN=mean, na.rm=TRUE)
colnames(datasummary) [1:2]<- c("subject", "activity")
write.table(datasummary, file="datasummary.txt", row.names = FALSE)
}









