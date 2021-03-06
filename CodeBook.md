## Basic Information

This code '*run_analysis.R*' cleans and analizes the data obtained from the website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data was originally collected from the accelerometers from the Samsung Galaxy S smartphone 
for the study of *Human Activity Recognition Using Smartphones Dataset*.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% the test data. <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">[RefLink]</a>

The dataset includes the following files that will be loaded when the code is executed:

| File Name              | Data                                 | Size     |
| :------------------------ |:-------------------------------------- | :---------- | 
| features.txt           | List of all features                 | 561 x 2    |
| activity_labels.txt    | Activity indices and names           | 6 x 2      |
| train/X_train.txt      | Training set                         | 7352 x 561 |
| train/y_train.txt      | Training labels                      | 7352 x 1   |
| train/subject_test.txt | Train subjects                       | 7352 x 1   |
| test/X_test.txt        | Test set                             | 2947 x 561 |
| test/y_test.txt        | Test labels                          | 2947 x 1   |
| test/subject_test.txt  | Test subjects                        | 2947 x 1   |

Important numbers are summarized here:

| Name                           | Number  | 
| :----------------------------- |:------- |
| subjects                       | 30      |
| features                       | 561     |
| features with mean() and std() | 66      |
| activities                     | 6       |
| training data                  | 7352    |
| test data                      | 2947    |
| total data                     | 10299   |


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
| tidyData.txt  | Tidy dataset of the means calculated for each activity and subject | 181 x 68     | 

## Variables 

##### * Activity Labels and Features

| Variable      | Content                                                                        |  
| :------------ | :----------------------------------------------------------------------------- |
|actLabel       | Data loaded from 'activity_labels.txt' with column names "Index" and "Name"    |
|features       | Data loaded from 'features.txt' with column names "Index" and "Name"           |
|featNames      | Feature names copied from features$Name                                        |

##### * Test Data Set

| Variable      | Content                                                                        |  
| :------------ | :----------------------------------------------------------------------------- |
| sbjTest       | Data loaded from 'test/subject_test.txt' with column name "SubjectIndex"       |
| xTest         | Data loaded from 'test/X_test.txt'                                             |
| yTest         | Data loaded from 'test/Y_test.txt' with column name "ActivityIndex"            |
| nTest         | Number of data in the test set                                                 |

##### * Training Data Set

| Variable      | Content                                                                        |  
| :------------ | :----------------------------------------------------------------------------- |
| sbjTrain      | Data loaded from 'train/subject_train.txt' with column name "SubjectIndex"     |
| xTrain        | Data loaded from 'train/X_train.txt'                                           |
| yTrain        | Data loaded from 'train/Y_train.txt' with column name "ActivityIndex"          |
| nTrain        | Number of data in the training set                                             |

##### * Combined Data Set

| Variable      | Content                                                                        |  
| :------------ | :----------------------------------------------------------------------------- |
| sbjAll        | A combined dataset of sbjTest and sbjTrain                                     |
| xAll          | A combined dataset of xTest and xTrain                                         |
| yAll          | A combined dataset of yTest and yTrain                                         |
| nAll          | Total number of the combined dataset = nTest + nTrain                          |
| bigData       | Single dataset containing sbjAll, xAll, and yAll                               |


##### * Subset of bigData with mean() and std() 

| Variable         | Content                                                                     |  
| :--------------- | :-------------------------------------------------------------------------- |
| meanFeatIndex    | Indices of the columns that contain Mean()                                  |
| stdFeatIndex     | Indices of the columns that contain Std()                                   |
| smallFeatIndex   | Indices of the columns that contain both Mean() and Std()                   |
| smallFeatNames   | Feature names of the columns that contain Mean() and Std()                  |
| smallData        | A subset of bigData that contain both Mean() and Std() columns              |

##### * Tidy Data

| Variable         | Content                                                                     |  
| :--------------- | :-------------------------------------------------------------------------- |
| cleanFeatNames   | Descriptive Feature Names                                                   |
| gpSmallData      | smallData grouped by Activity and Subject                                   |
| tidyData         | A tidy data set of gpSmallData that contains mean values for each variable grouped by Activities and Subjects|

## Data Transformation

In this code, the raw data is clean in the following steps:

1. Train, Test dataset, and Subject are merged into a single dataset (bigData) by first combining rows (Test and Train) and then columns (Subject, Y, X).
2. Use `grep(...)` to extract the columns with a feature name contains mean() or std(). Column Subject, Activities, and the extracted columns form a new dataset (smallData).
3. Use `gsub(...)` to replace the activity indices by the corresponding activity names, and replace the Activity column by the new name list.
4. The feature names selected in step 2 are transformed by removing symbols and capitalizing/modifying certain letters for improving readability.

  ```
  tmp <- gsub("^f", "freq", smallFeatNames, perl = TRUE)  # f -> freq  
  tmp <- gsub("^t", "time", tmp, perl = TRUE)             # t -> time
  tmp <- gsub("-(\\w)", "\\U\\1", tmp, perl = TRUE)       # Capitalize the first letter after '-'
  tmp <- gsub("\\(|\\)", "", tmp)                         # Remove parenthesis 
  tmp <- gsub("\\,", "\\.", tmp)                          # Replace ',' by '.' if has any
  ```

  Examples:

  | Old        | New                       |  
  | :--------------- | :-------------------|
  | tBodyAcc-mean()-X   | timeBodyAccMeanX |
  | fBodyAcc-mean()-X   | freqBodyAccMeanX |
  | fBodyBodyAccJerkMag-mean() | freqBodyBodyAccJerkMagMean |
5. The new feature names (cleanFeatNames) are used to name the columns in smallData.
6. To calculate the means for each activity and each subject, smallData is firsed grouped by Activity and Subject using `group_by(...)`. 
7. The final tidy data of means is generated by using `summarize_each(...)` with `funs(mean)`, and the resulting table is then written into file "tidyData.txt".

