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
col_names <- read.table(column_names_file, stringsAsFactors=FALSE)
colnames(col_names) <- c("id", "name")

#Need to do some cleanup here, there are duplicate column names
# This seems a messy way to do it...
# See my codebook for discussion on this
c1 <- col_names$name[1:302]
c2 <- paste(col_names$name[303:316],rep("-X",14))
c3 <- paste(col_names$name[317:330],rep("-Y",14))
c4 <- paste(col_names$name[331:344],rep("-Z",14))
c5 <- col_names$name[345:380]
c6 <- paste(col_names$name[381:395],rep("-X",14))
c7 <- paste(col_names$name[396:409],rep("-Y",14))
c8 <- paste(col_names$name[410:423],rep("-Z",14))
c9 <- col_names$name[424:460]
c10 <- paste(col_names$name[461:474],rep("-X",14))
c11 <- paste(col_names$name[475:488],rep("-Y",14))
c12 <- paste(col_names$name[489:502],rep("-Z",14))
c13 <- col_names$name[503:561]
new_col_names <- c(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13)

#Update the column names in the 
colnames(x_data) <- new_col_names
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

#uncomment if you get errors
#install.packages("reshape2")
library(reshape2)

mymelt <- melt(full_data, id=c("subject", "activity"))
#The instructions say "each variable for each activity and each subject"
# but I'm doing subject + activty so that the records for a given subject are together
# for readability purposes only
mean_data <- dcast(mymelt, subject + activity ~ variable, mean, na.rm=TRUE)

write.table(mean_data, "subject-activity-mean.txt")
