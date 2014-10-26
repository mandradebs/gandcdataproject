Getting an cleanning data. Course project.
================

In order to applied to the analysis, you must run the file run_analysis.R assuming that the Samsung data is in your working directory (You can find it here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The script does the following: first, merges the training and the test sets to create one data set using the merge function. Of course, it was neccesary to read the txt files before, using the read.table command. After this, the script extracts only the measurements on the mean and standard deviation for each measurement, this is done subsetting only the variables that containt in its names the words "mean" and "std". Then, the next step was asign descriptive activity names to name the activities in the data set. Next, the variables was renamed to get the data set with descriptive variable names. Finally, using the reshape2 library, the script creates a second set with the average of each variable for each activity and each subject.


