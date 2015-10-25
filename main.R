library(plyr)
library(dplyr)
library(reshape2)

if(!file.exists("./coursera_project")){dir.create("./coursera_project")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./coursera_project/Dataset.zip",method="curl")

unzip(zipfile="./coursera_project/Dataset.zip",exdir="./coursera_project")


# STEP 1: Merges the training and test sets to create one data set.
###################################################################

x_train <- read.table("./coursera_project/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./coursera_project/UCI HAR Dataset/train/y_train.txt")
subj_train <- read.table("./coursera_project/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./coursera_project/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./coursera_project/UCI HAR Dataset/test/y_test.txt")
subj_test <- read.table("./coursera_project/UCI HAR Dataset/test/subject_test.txt")

# create data sets
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subj_train, subj_test)

# STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#################################################################################################

features <- read.table("./coursera_project/UCI HAR Dataset/features.txt")

# get only rows with mean() or std() in their names
stats_features <- grep("-(mean|std)\\(\\)", features$V2)

# subset and rename
x_data <- x_data[, stats_features]
names(x_data) <- features[stats_features, "V2"]

# STEP 3: Uses descriptive activity names to name the activities in the data set
# STEP 4: Appropriately labels the data set with descriptive variable names.
################################################################################

#read in file
activities <- read.table("./coursera_project/UCI HAR Dataset/activity_labels.txt")

# update values with correct activities
y_data[, 1] <- activities[y_data[, 1], "V2"]
names(y_data) <- "activity"

# name column and combine data
names(subject_data) <- "subject"
full_data <- cbind(x_data, y_data, subject_data)


# STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
########################################################################################################################################################

means_data <- ddply(full_data, .(subject, activity), function(x) colMeans(x[, -(67:68)]))

write.table(means_data, "./coursera_project/UCI HAR Dataset/averages_data.txt", row.name=FALSE)
