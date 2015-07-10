# Getting and Cleaning Data Course Project
This repo is for the Getting and Cleaning Data Course in the Data Science Specialization Series.

The repo contains: 

* README.md : explain how the run_analysis.R code works
* CodeBook.md : describe the variables, the data, and any transformations or work performed to clean up the data
* run_analysis.R : R script that performs the data clean up if run
* tidy.txt : a tidy data set that is the output of the run_analysis.R script

The R script, `run_analysis.R` , does the following:

1. Download and unzip the dataset if it does not exist in the working directory, or it is not unzipped.
2. Load the common info files for activity and feature names  
3. Load the training and test datasets, including their respective subject labels, activity labels, and measured variables
4. Merge by row the training and test datasets to create one dataset for subject, one for activity, and one for variable
5. Extract only the mean and standard deviation variables from the variable dataset 
6. Merge by column the subject, activity, and extracted variables  
7. Add labels to subject and activity columns, and modify labels of variables columns
8. Convert activity column into factor to replace activity labels with appropriate activity names given by the info file
9. Use `reshape2` pakcage to create a tidy dataset with the average of each variable for each activity and each subject

The output of the code is the file `tidy.txt`


