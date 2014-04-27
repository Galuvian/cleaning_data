This repo contains the course assignment for the Coursera "Getting and Cleaning Data" course.

The raw data came from:

* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


Run the script run_analysis.R to perform the assigned manipulations on the data.

To run the script:
* The script assumes the raw data is in the same directory as the script.  The raw data is already in this repo.
* The install.packages("reshape2") line is commented out.  If you don't have that package already installed, you should uncomment this line or just run it manually.  Keeping this line uncommented makes working in R Studio annoying.
* Just run the script


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
|test| Directory with test data |
|test/Inertial Signals| Contains raw sensor data files, not used for this assginment|
|test/subject_test.txt| Data file containing a subject id for each record in the other data files|
|test/X_test.txt| "X" data file, which contains the summarized sensor data for each measured activity|
|test/y_test.txt| "Y" data file, which contains the activity for each measurement in the "X" file |
|train| Training dataset |
|train/Inertial Signals| Contains raw sensor data files, not used for this assginment |
|train/subject_train.txt| Data file containing a subject id for each record in the other data files|
|train/X_train.txt|  "X" data file, which contains the summarized sensor data for each measured activity|
|train/y_train.txt| "Y" data file, which contains the activity for each measurement in the "X" file|
