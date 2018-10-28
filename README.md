# GettingandCleaningData
Purpose

Raw data from the Human Activity Recognition Using Smartphones Dataset is processed to extract the average means and standard deviations of each variable for a given subject and activity, returning a tidy data frame containing these values.

The script here pertains to peer-graded assignment in the Getting and Cleaning Data Course offered by Coursera/JHU and meets all requirements of the assignment.

Credit for the source data from the Human Activity Recognition Using Smartphones Dataset  goes to:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. Smartlab - Non Linear Complex Systems Laboratory DITEN - Universit? degli Studi di Genova. Via Opera Pia 11A, I-16145, Genoa, Italy. activityrecognition@smartlab.ws www.smartlab.ws

Data available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

With a full description here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script assumes the data will be found in the directory "./UCI HAR Dataset/" structured as it is in the linked archive. The script requires that the package "dplyr".

To use the script at the prompt, call source("~/run_analysis.R") correcting for file location, then run_analysis(). Assigning the ouput of the script to a data frame is recomended, since the resulting table is too large to simply read on screen.

Functionality

The script imports the test and training datasets (X_test.txt and X_train.txt) from the UCI HAR data and combines them into a single dataframe, with the columns named from the features.txt file provided in the archive.

Partial string matching using grep is used to identify the columns that include mean() and std() in their name. These columns of interest are then assigned to a new data frame.

The activity labels for each observation (provided in Y_test.txt and Y_train.txt) are converted from numeric vectors to factors with the corresponding text activity label (found in activity_labels.txt) using the mapvalues function from plyr, and this factor is added to the data frame containing all the mean and standard deviation observations. An additional column containing the subject id for each observation (read in from subjects_test.txt and subjects_train.txt) is also included.

This data frame is returned from the function.
