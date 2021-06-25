# GetCleanData
Repo for the R course Getting and Cleaning Data
The file run_analysis first reads all the required data. Then, i creates one data.frame for the test set and one for the train set and renames the columns.

Both data.frames are bound and then the variables of interest (mean and std) are selected. In the column that indicates type of activity, a loop exchanges the numbers to 
the name of the activity.

Finally, a definite data.frame is created using the aggregate function to obtain a single mean for each subject-activity pair.
