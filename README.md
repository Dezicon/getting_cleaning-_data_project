This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, 
does the following:

Loads all the text files.

Chooses files that are neccessary for analysis

Names columns of train ad test dataset using features file

Loads the activity and subject data for each dataset, and merges those columns with the dataset

Merges the two datasets

Converts the activity numbers into activity names

Chooses only those columns which reflect a mean or standard deviation

Creates a tidy dataset that consists of the average (mean) value of each variable for each activity and subject.

The end result is shown in the file tidy_data.txt