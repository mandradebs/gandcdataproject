#Getting an cleaning data
#Course project

##Reading data

###Training set
training.Data <- read.table("UCI HAR Dataset/train/X_train.txt")
training.Labels <- read.table("UCI HAR Dataset/train/y_train.txt");names(training.Labels) = "Label"
training.subject <- read.table("UCI HAR Dataset/train/subject_train.txt");names(training.subject) = "Subject"
training <- cbind(training.Data,training.Labels,training.subject)#adding label and subject in last columns
###Test set
test.Data <- read.table("UCI HAR Dataset/test/X_test.txt")
test.Labels <- read.table("UCI HAR Dataset/test/y_test.txt");names(test.Labels) = "Label"
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt");names(test.subject) = "Subject"
test <- cbind(test.Data,test.Labels,test.subject)#adding label ans subject in last columns

###activity labels
activity.Labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity.Labels) = c("lid","Label")
###features
features <- read.table("UCI HAR Dataset/features.txt")
#variables that were estimated
est <- unlist(lapply(X = strsplit(x = as.character(features$V2),split = "-"),FUN = function(s) s[2]))
#Add new variable that containd only mean(), std(), max(),... for each row
features <- cbind(features,est)

##1.Merges the training and the test sets to create one data set
dat <- merge(training,test,all = TRUE)

##2.Extracts only the measurements on the mean and standard deviation for each measurement
mean_AND_std <- dat[,c(562:563,which(features$est %in% c("mean()","std()")))]

##3.Uses descriptive activity names to name the activities in the data set
mean_AND_std <- merge(activity.Labels,mean_AND_std,by.x = "lid",by.y = "Label")

##4.Appropriately labels the data set with descriptive variable names.
varsnames = as.character(features[which(features$est %in% c("mean()","std()")),2])
names(mean_AND_std) = c("labelid","Activity","Subject",varsnames)

##5.From the data set in step 4, creates a second, independent tidy data set with
##the average of each variable for each activity and each subject.
library(reshape2)
newdat <- melt(data = mean_AND_std,id.vars = c("Subject","Activity"),measure.vars = varsnames)
finalSet <- dcast(newdat,Subject + Activity ~ variable,mean)

write.table(finalSet,"finalSet.txt",row.names = FALSE)

