The raw data came from:

* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Note on duplicate column names:
There are 561 columns in the data.  But unique(colnames(data)) says there are only 471 unique names.  
It turns out that there are a bunch of duplicated columns.  They all have *bandsEnergy()* in the name.
Since there are 3 sets of repeated columns for each variable (fBodyAcc, fBodyAccJerk, fBodyGyro) it seems like 
-X, -Y, and -Z somehow got left off of thes ecolumn names in the raw data.

So the script modifies the column names to append -X, -Y, or -Z to the necessary values.
```303-316 Add -X
317-330 Add -Y
331-344 Add -Z

381-395 Add -X
396-409 Add -Y
410-423 Add -Z

461-474 Add -X
475-488 Add -Y
489-502 Add -Z
```

Files included:


| File                         | Purpose    |
|-----------------------------|-----------|
|activity_labels.txt  | List of enumerations for Activities in the "Y" data files|
|features.txt| List of columns in the "X" data files|
|features_info.txt| Discussion of the column values in the "X" data files |
|final_data1.txt| Results for the first part of the assignment|
|README.txt| Readme that accompanies the dataset |
|run_analysis.R| My script for this assignment |
|subject-activity-mean.txt| Results for the second part of the assginment|
|test/| Directory with test data |
|test/Inertial Signals| Contains raw sensor data files, not used for this assginment|
|test/subject_test.txt| Data file containing a subject id for each record in the other data files|
|test/X_test.txt| "X" data file, which contains the summarized sensor data for each measured activity|
|test/y_test.txt| "Y" data file, which contains the activity for each measurement in the "X" file |
|train/| Training dataset |
|train/Inertial Signals| Contains raw sensor data files, not used for this assginment |
|train/subject_train.txt| Data file containing a subject id for each record in the other data files|
|train/X_train.txt|  "X" data file, which contains the summarized sensor data for each measured activity|
|train/y_train.txt| "Y" data file, which contains the activity for each measurement in the "X" file|
