library(reshape2)

# Download and unzip file
filename <- "getdata-projectfiles-UCI HAR Dataset.zip"
foldername <- "UCI HAR Dataset"

if (!file.exists(filename)) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL,filename,method="curl")
}
if (!file.exists(foldername)) {
  unzip(filename)
}

# Load Data
activity.names <- read.table("UCI HAR Dataset/activity_labels.txt")
activity.names[,2] <- as.character(activity.names[,2])
feature.names <- read.table("UCI HAR Dataset/features.txt")
feature.names[,2] <- as.character(feature.names[,2])

subject.train.labels <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject.test.labels <- read.table("UCI HAR Dataset/test/subject_test.txt")
train.data <- read.table("UCI HAR Dataset/train/X_train.txt")
test.data <- read.table("UCI HAR Dataset/test/X_test.txt")
activity.train.labels <- read.table("UCI HAR Dataset/train/y_train.txt")
activity.test.labels <- read.table("UCI HAR Dataset/test/y_test.txt")

# Merge the training and the test sets to create one data set
subject.labels <- rbind(subject.train.labels,subject.test.labels)
data <- rbind(train.data,test.data)
activity.labels <- rbind(activity.train.labels,activity.test.labels)

# Extract only the mean and standard deviation for each measurement
feature.position <- grep("*mean*|*std*",feature.names[,2])
data <- data[,feature.position]
data <- cbind(subject.labels,activity.labels,data)

# Add labels
# Use descriptive activity names to name the activities in the data set
# Appropriately label the data set with descriptive variable names
feature.names[,2] <- gsub("mean","Mean",feature.names[,2])
feature.names[,2] <- gsub("std","STD",feature.names[,2])
feature.names[,2] <- gsub("[()]","",feature.names[,2])
colnames(data) <- c("Subject","Activity",feature.names[feature.position,2])
data$Activity <- factor(data$Activity,levels=activity.names[,1],labels=activity.names[,2])

# create a tidy data set 
# with the average of each variable for each activity and each subject
data.melt <- melt(data, id = c("Subject","Activity"))
data.avg <- dcast(data.melt,Subject + Activity ~ variable, mean)
write.table(data.avg, "tidy.txt", row.names = FALSE)













