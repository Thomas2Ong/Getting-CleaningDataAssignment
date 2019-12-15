## run_analysis.R

## 1. Download data from web
rawDatHTML <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
rawDatDir <- "./rawData"
rawfileDir <- file.path(rawDatDir, "rawFile.zip")
workDatDir <- "./workData"

if (!file.exists(rawDatDir)) {
        dir.create(rawDatDir)
        download.file(url=rawDatHTML, destfile=rawfileDir)
}
if (!file.exists(workDatDir)) {
        dir.create(workDatDir)
        unzip(zipfile=rawfileDir, exdir=workDatDir)
}


## 2. Read Train & Test Data
## 2-1 Train Data
XtrainDat <- read.table("./workData/UCI HAR Dataset/train/X_train.txt")
YtrainDat <- read.table("./workData/UCI HAR Dataset/train/Y_train.txt")
SubTrainDat <- read.table("./workData/UCI HAR Dataset/train/subject_train.txt")


## 2-2 Test Data
XtestDat <- read.table("./workData/UCI HAR Dataset/test/X_test.txt")
YtestDat <- read.table("./workData/UCI HAR Dataset/test/Y_test.txt")
SubTestDat <- read.table("./workData/UCI HAR Dataset/test/subject_test.txt")


## 3. Merge Data using rbind
Xdat <- rbind(XtrainDat, XtestDat)
Ydat <- rbind(YtrainDat, YtestDat)
SubDat <- rbind(SubTrainDat, SubTestDat)


## 4. Read "features.txt" and rename Xdat
featuresDat <- read.table("./workData/UCI HAR Dataset/features.txt")
featuresDat <- select(featuresDat, "V2")
featuresDat <- rename(featuresDat, "features" = "V2")
names(Xdat) <- as.character(featuresDat$features)  ## change column names


## 5. Extract columns with "mean" & "std"
Xdat <- Xdat[, grep("mean|std", names(Xdat))]


## 6. Merge columns of SubDat, Ydat, Xdat
allDat <- cbind(SubDat, Ydat, Xdat)
names(allDat)[1:2] <- c("Subject", "Activity")


## 7. Rename Activity from number to word description
##      1 WALKING
##      2 WALKING_UPSTAIRS
##      3 WALKING_DOWNSTAIRS
##      4 SITTING
##      5 STANDING
##      6 LAYING
activityLabel <- read.table("./workData/UCI HAR Dataset/activity_labels.txt")
allDat$Activity <- factor(allDat$Activity, levels=activityLabel[,1], labels=activityLabel[,2])


## 8. Tidy data
meltedDat <- melt(allDat, id=c("Subject", "Activity"))
tidyDat <- dcast(meltedDat, Subject+Activity ~ variable, mean)


## 9. Write table
write.table(tidyData, "./tidy_data.txt", row.names=FALSE, quote=FALSE)





