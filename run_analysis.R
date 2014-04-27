read.table("features.txt") -> features 
read.table("activity_labels.txt") -> activityLabels
read.table("y_train.txt") -> Ytrain
read.table("y_test.txt") -> Ytest
read.table("X_train.txt") -> Xtrain
read.table("X_test.txt") -> Xtest
read.table("subject_train.txt") -> sbjtrain
read.table("subject_test.txt") -> sbjtest
##Read tables into R for cleanup

colnames(Xtest) <- features$V2  
colnames(Xtrain) <- features$V2
colnames(Ytest) <- "Activity"
colnames(Ytrain) <- "Activity"
colnames(sbjtest) <- "Subject"
colnames(sbjtrain) <- "Subject"
##Add column names to X, Y and Subject data frames. Found this easier to do before cleanup

selectFeatures <- c(grep("-mean()", features$V2), grep("-std()", features$V2))  
##Integer vector that selects features with strings indicating mean or standard deviation.

XtestSelect <- Xtest[,selectFeatures]
XtrainSelect <- Xtrain[,selectFeatures]
##Filter X data frames to only include mean and standard deviation columns

testAll <- cbind(sbjtest, Ytest, XtestSelect)
trainAll <- cbind(sbjtrain, Ytrain, XtrainSelect)
##Add Subject and Y(Activity) columns to filtered X Test and X Train data frames

AllData <- rbind(testAll, trainAll)
##Add Text and Train data frames together

labels <- activityLabels[AllData[,2], 2]
AllData[,2] <- labels
## Change "Activity" column from numbers to meaningful descriptions

ActivityMeans <- data.frame(row.names=sort(activityLabels[,2]))
## Create empty data frame for column means by Activity

for(i in 3:ncol(AllData)) {
  tapply(AllData[, i], AllData$Activity, FUN=mean) -> ActivityMeans[,i-2]
}
## Calculate means by activity column-by-column, adding results to data frame created above

SubjectMeans <- data.frame(row.names=as.factor(1:30))

for(i in 3:ncol(AllData)) {
  tapply(AllData[, i], AllData$Subject, FUN=mean) -> SubjectMeans[,i-2]
}
## Like activity but with subject as index

rbind(ActivityMeans, SubjectMeans) -> AccelMeans

colnames(AccelMeans) <- features$V2[selectFeatures]
## Add column names using select features