## Basic Information

This code '*run_analysis.R*' cleans and analizes the data obtained from the website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data was originally collected from the accelerometers from the Samsung Galaxy S smartphone 
for the study of Human Activity Recognition Using Smartphones Dataset.

The dataset includes the following files that will be loaded when the code is executed

| File Name              | Data                                 | Size     |
| :------------------------ |:-------------------------------------- | :---------- | 
| features.txt           | List of all features                 | 561x2    |
| activity_labels.txt    | Class labels with their activity name| 6x2      |
| train/X_train.txt      | Training set                         | 7352x561 |
| train/y_train.txt      | Training labels                      | 7352x1   |
| train/subject_test.txt | Train subjects                       | 7352x1   |
| test/X_test.txt        | Test set                             | 2947x561 |
| test/y_test.txt        | Test labels                          | 2947x1   |
| test/subject_test.txt  | Test subjects                        | 2947x1   |


The R library "*dplyr*" is required for running the code.

The code was developed and tested using **RStudio** (Version 0.99.489)

## Functions and Outputs

The code completes the following tasks:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the 
   average of each variable for each activity and each subject.

The output of the code are the clean data files:

| File Name                 | Data                                                                     | Size        |
| :------------------------ |:------------------------------------------------------------------------ | :---------- | 
| X_all.txt                 | Combines X_Test, X_train, with Labels                                    | 10299x562   |
| Y_all.txt                 | Combines Y_test, Y_train, with Labels                                    | 10299x2     |
| X_mean_std.txt            | Subset of X_all, contains only mean() and std() data                     | 10299x66    |
| acivity_subject_mean.txt  | Tidy data set of the means calculated for each activity and each subject | 16830x3     | 

## Variables 

##### Activity Labels and Features

| Variable      | Content                                                                        |  
| :------------ | :----------------------------------------------------------------------------- |
|actLabel       | Data loaded from 'activity_labels.txt' with column names "Index" and "Name"    |
|features       | Data loaded from 'features.txt' with column names "Index" and "Name"           |
|featNames      | Feature names copied from features$Name                                        |

##### Test Set

| Variable      | Content                                                                        |  
| :------------ | :----------------------------------------------------------------------------- |
| sbjTest       | Data loaded from 'test/subject_test.txt' with column name "SubjectIndex"       |
| xTest         | Data loaded from 'test/X_test.txt'                                             |
| yTest         | Data loaded from 'test/Y_test.txt' with column name "ActivityIndex"            |
| nTest         | Number of data in the test set                                                 |

##### Training Set

| Variable      | Content                                                                        |  
| :------------ | :----------------------------------------------------------------------------- |
| sbjTrain      | Data loaded from 'train/subject_train.txt' with column name "SubjectIndex"     |
| xTrain        | Data loaded from 'train/X_train.txt'                                           |
| yTrain        | Data loaded from 'train/Y_train.txt' with column name "ActivityIndex"          |
| nTrain        | Number of data in the training set                                             |

##### Combined Set

| Variable      | Content                                                                        |  
| :------------ | :----------------------------------------------------------------------------- |
| sbjAll        | A combined dataset of sbjTest and sbjTrain                                     |
| xAll          | A combined dataset of xTest and xTrain                                         |
| yAll          | A combined dataset of yTest and yTrain                                         |
| nAll          | Total number of the combined dataset = nTest + nTrain                          |

##### Subset of X with mean() and std() 

| Variable         | Content                                                                     |  
| :--------------- | :-------------------------------------------------------------------------- |
| meanFeatIndex    | Indices of the columns that contain Mean()                                  |
| stdFeatIndex     | Indices of the columns that contain Std()                                   |
| meanStdFeatIndex | Indices of the columns that contain both Mean() and Std()                   |
| meanStdFeatures  | Feature names of the columns that contain Mean() and Std()                  |
| meanStdX         | X data of the columns that contain both Mean() and Std()                    |

##### Tidy Data

| Variable         | Content                                                                     |  
| :--------------- | :-------------------------------------------------------------------------- |
| cleanFeatNames   | Descriptive Feature Names                                                   |
| gpXAll           | xAll data grouped by subject                                                |
| meanXAll         | A table of mean values for each activity and each subject                   | 
| tidyXAll         | A tidy data set of meanXAll that contains three columns: Activity, Subject, and Mean |


