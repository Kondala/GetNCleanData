setwd("C:/_2_1_Skills/DataScience/_3_Getting_Cleaning_Data/project/UCI HAR Dataset")

##################################################################################################################################
# Step 1:  Read the training and test data sets and merge them
#          Also, provide column headers from the features.txt file.
##################################################################################################################################

#read and combine train data
train_x <- read.table("./train/X_train.txt", sep = "", header = FALSE)
train_y <- read.table("./train/y_train.txt", sep = "", header = FALSE)
train_subject <- read.table("./train/subject_train.txt", sep = "", header = FALSE)
train <- cbind(train_subject, train_y, train_x)

#read and combine test data
test_x <- read.table("./test/X_test.txt", sep = "", header = FALSE)  
test_y <- read.table("./test/y_test.txt", sep = "", header = FALSE)  
test_subject <- read.table("./test/subject_test.txt", sep = "", header = FALSE)
test <- cbind(test_subject, test_y, test_x)

# merge train and test datasets
all_data <- rbind(train, test)

#construct column headers and assign them to the dataset
features_table <- read.table("./features.txt", sep = "", as.is = T, header = FALSE)
column_headers <- c("subject_id", "activity_id", features_table$V2)   #second column of features_table contains the column headers; Prefix two additional column names (subject_id and activity_id)
colnames(all_data) <- column_headers

##################################################################################################################################
# Step 3:  Provide descriptive activity names for the activity_id's in the dataset
#          Obviously, we do this by joining the dataset with the activity_labels reference data
#          This step can easily be done after throwing away the columns that are not mean & std dev related.  
#          But, I happen to do this before the 2nd requirement.
##################################################################################################################################

#read the activity labels
activity_labels <- read.table("./activity_labels.txt", sep = "", as.is = T, header = FALSE)
colnames(activity_labels) <- c("activity_id", "activity_label")

#merge the main dataset with activity labels
all_data_with_act_labels <- merge(activity_labels, all_data,  by = "activity_id")

##################################################################################################################################
# Step 2:  Extract only measurements on the mean and standard deviation for each measurement
#          These columns are identified by grepping for "mean" and "std()" in the column headers
#          But, of course, we still need the activity_id, activity_label and subject_id columns
##################################################################################################################################

new_col_hdr <- colnames(all_data_with_act_labels)
library(dplyr)
# mean_std_data is the pruned dataset that has just the mean and std columns
mean_std_data <- all_data_with_act_labels[,new_col_hdr[grepl("activity_id",new_col_hdr) |grepl("activity_label",new_col_hdr) |grepl("subject_id",new_col_hdr) |grepl("mean[^Ff]",new_col_hdr) | grepl("std()",new_col_hdr)]]

##################################################################################################################################
# Step 4:  Provide descriptive labels for the variables (columns)
#          I choose to do this by doing a find-replace on the column headers
#          I start with the original column headers and progressively make them descriptive
#          It's possible to improve on the descriptiveness of the column headers
##################################################################################################################################

ch <- colnames(mean_std_data)
ch1 <- gsub("tBodyAcc", "Total Body Acceleration ",ch)
ch2 <- gsub("tBodyGyro", "Total Body Gyro ",ch1)
ch3 <- gsub("fBodyAcc", "Frequency Body Acceleration ",ch2)
ch4 <- gsub("-mean()", " Mean ",ch3)     #how do i match a parenthesis?
ch5 <- gsub("-std()", " Std Dev ",ch4)
ch6 <- gsub("tGravityAcc", "Total Gravity Acceleration ",ch5)
ch7 <- gsub("fBodyBodyGyroMag", "Frequency Body Body Gyro Mag ",ch6)
ch8 <- gsub("fBodyGyro", "Frequency Body Gyro ",ch7)
ch9 <- gsub("fBodyBodyAccJerkMag", "Frequency Body Body Acceleration Jerk Mag ",ch8)
ch10 <- gsub("fBodyBodyGyroJerkMag", "Frequency Body Body Gyro Jerk Mag ",ch9)

# assign the descriptive column headers to mean_std_data  dataframe
colnames(mean_std_data) <- ch10

##################################################################################################################################
# Step 5:  Create a second, independent tidy data set with the averages of each variable for each (activity, subject) combination
#          Note: the activity_label is included in the group by in order to keep the descriptive activity labels in the final 
#          dataset.  Since activity_id and activity_label are 1:1, there is no difference to the grouping process.
##################################################################################################################################

data_with_means <- mean_std_data %>% group_by(activity_id,activity_label,subject_id) %>% summarise_each(funs(mean))
write.table(data_with_means, 'data_with_means.txt', sep="\t", row.names=F)


