library(data.table)

test_x_file <-  "test/X_test.txt"
test_y_file <-  "test/Y_test.txt"
test_subject_file <- "test/subject_test.txt"
train_x_file <- "train/X_train.txt"
train_y_file <- "train/Y_train.txt"
train_subject_file <- "train/subject_train.txt"


labels_file <- "activity_labels.txt"
column_names_file <- "features.txt"


#merge the files
#using fread would be preferred, but it doesn't seem happy with the double space at the beginning of the line
#so I'm falling back to read.table
test_x_data <- read.table(test_x_file)
test_y_data <- read.table(test_y_file)
test_subject_data <- read.table(test_subject_file)
train_x_data <- read.table(train_x_file)
train_y_data <- read.table(train_y_file)
train_subject_data <- read.table(train_subject_file)

x_data <- rbind(test_x_data, train_x_data)
y_data <- rbind(test_y_data, train_y_data)
subject_data <- rbind(test_subject_data, train_subject_data)
colnames(subject_data) <- c("subject")

#load the list of variables, attach as col names, and filter the cols
col_names <- read.table(column_names_file, stringsAsFactors=F)
colnames(col_names) <- c("id", "name")
colnames(x_data) <- col_names$name
mean_cols <- grep("mean|std", colnames(x_data), ignore.case=TRUE)
x_filtered <- x_data[,mean_cols]


#load activity names and convert the Y data to a factor using these labels
activity_names <- read.table(labels_file, stringsAsFactors=F)
activity <- factor(y_data$V1, labels=activity_names$V2)




#Could use the merge() function here, but there aren't any strong ID columns
# and we are given the assumption that row nums match up between files
# and cbind() is more efficient than having to match keys
final_data <- cbind(subject_data, activity, x_filtered)


#Write the final output back to a new file
write.table(final_data, "final_data1.txt")


###
###
#  This is Part 2, but it uses same data that has been loaded above
###
###

#From the merged data, find avg for each activity + subject for all columns
# (not just the mean/std cols that were filtered above)
full_data <- cbind(subject_data, activity, x_data)

install.packages("reshape2")
library(reshape2)

mymelt <- melt(full_data, id=c("subject", "activity"))
#The instructions say "each variable for each activity and each subject"
# but I'm doing subject + activty so that the records for a given subject are together
# for readability purposes only
mean_data <- dcast(mymelt, subject + activity ~ variable, mean, na.rm=TRUE)

write.table(mean_data, "subject-activity-mean.txt")
