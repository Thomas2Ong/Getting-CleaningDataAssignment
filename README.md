# Getting-CleaningDataAssignment

This is Getting and Cleaning Data Course Project. The project includes (1) R script, (2) README.md, and (3) codebook.md.

(1) R script
1-1 Downloand dataset from web, if not yet downloaded. If not downloaded, the script will create "rawData" directory for original data and "workData" directory for a copy of the dataset which the script will refer to for further workings.

1-2 Read train (X_train, y_train, subject_train) and test (X_test, y_test, subject_test).

1-3 Merge by row (rbind): x data (X_train, X_test), y data (y_train, y_test), and subject data (subject_train, subject_test), respectively.

1-4 Read "features.txt" and use the content (descriptions) to rename column names of x merged data.

1-5 From the x merged data, extract columns that with "mean" or "std" in header (column name).

1-6 Merge by column (cbind): x, y and subject merged data.

1-7 Read "activity_lables.txt" and use the content (description) to rename (using factor function) the data in Activity column. (From the current numbers (1 to 6) to description (WALKING, WALKING-UPSTAIRS, etc) 

1-8 Generate "tidy dataset" using melt and dcast functions. the "tidy dataset" consists of mean of each activity of each subject.

1-9 The "tidy dataset" is saved in the file "tidy_data.txt"