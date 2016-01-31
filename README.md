# Getting and Cleaning Data Course Project

The data was originally collected from the accelerometers from the Samsung Galaxy S smartphone 
for the study of *Human Activity Recognition Using Smartphones Dataset*.

The original data files can be downloaded from the website:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

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


In this project, the code *run_analysis.R* was built and tested using **RStudio** (Version 0.99.489).
Make sure the *dplyr* library is properly loaded when running the code.