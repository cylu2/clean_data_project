# Getting and Cleaning Data Course Project

### Introduction

This project uses data from the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine
Learning Repository</a>, a popular repository for machine learning datasets. The data we are interested in was originally collected from the accelerometers from the 
Samsung Galaxy S smartphone for the study of *Human Activity Recognition Using Smartphones Dataset*.

The original data files can be found on the website:

* <b>Dataset Page</b>: <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">UCI HAR Data Page</a>

* <b>Dataset</b>: <a href="http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip">UCI HAR Dataset.zip</a> [58Mb]

* <b>Description</b>: The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% the test data. 

### Data Files

The data package contains the following files that will be used by the program to prepare a tidy dataset for further analysis.

| File Name              | Data                                 | Size     |
| :------------------------ |:-------------------------------------- | :---------- | 
| features.txt           | List of all features                 | 561x2    |
| activity_labels.txt    | Activity indices and names           | 6x2      |
| train/X_train.txt      | Training set                         | 7352x561 |
| train/y_train.txt      | Training labels                      | 7352x1   |
| train/subject_test.txt | Train subjects                       | 7352x1   |
| test/X_test.txt        | Test set                             | 2947x561 |
| test/y_test.txt        | Test labels                          | 2947x1   |
| test/subject_test.txt  | Test subjects                        | 2947x1   |

### Running the Code

In this project, the code *run_analysis.R* was built and tested using **RStudio** (Version 0.99.489).
Make sure the *dplyr* library is properly loaded when running the code. A text file named *tidyData.txt* will be generated by the 
program, which contains a tidy dataset of the mean values of selected features calculated for each subject and each activity. 
Please see *CodeBook.md* for more technical details of the program.