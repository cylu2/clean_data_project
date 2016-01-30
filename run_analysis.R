
# -----------------------------------------------------------------------------------
#
#  FILE : run_analysis.R
#
#  This code loads data from the following files and completes the tasks listed below:
# 
#  "activity_labels.txt", "features.txt", 
#  "test/subject_test.txt", "test/X_test.txt", "test/Y_test.txt"
#  "train/subject_train.txt", "train/X_train.txt", "train/Y_train.txt"
# 
#  1. Merges the training and the test sets to create one data set.
#  2. Extracts only the measurements on the mean and standard deviation for each measurement.
#  3. Uses descriptive activity names to name the activities in the data set
#  4. Appropriately labels the data set with descriptive variable names.
#  5. From the data set in step 4, creates a second, independent tidy data set with the 
#     average of each variable for each activity and each subject.
#
# -----------------------------------------------------------------------------------

    ## Load Library

    library(dplyr)

# -----------------------------------------------------------------------------------    

    ## Change Working Directory Path if Necessary

    # setwd("./UCI HAR Dataset/")

# -----------------------------------------------------------------------------------    
    
    ## Labels and Features
    
    actLabel <- read.table("activity_labels.txt", col.names = c("Index", "Name"))
    features <- read.table("features.txt", col.names = c("Index", "Name"))
    featNames <- features$Name

# -----------------------------------------------------------------------------------    
    
    ## Test Data Set
    
    # Subject    
    sbjTest <- read.table("test/subject_test.txt", col.names = "Subject")
    
    # Data-X (Measurements)    
    xTest <- read.table("test/X_test.txt")
    
    # Data-Y (Activities)
    yTest <- read.table("test/Y_test.txt", col.names = "Activity")

    # Number of Data
    nTest <- nrow(subTest)   
    
# -----------------------------------------------------------------------------------

    ## Training Data Set

    # Subject        
    sbjTrain <- read.table("train/subject_train.txt", col.names = "Subject")
    
    # Data-X (Measurements)        
    xTrain <- read.table("train/X_train.txt")
    
    # Data-Y (Activities)    
    yTrain <- read.table("train/Y_train.txt", col.names = "Activity")

    # Number of Data        
    nTrain <- nrow(subTrain)

# -----------------------------------------------------------------------------------    
    
    ## Combine Training and Test Data  (TASK #1)
    
    # Subject     
    sbjAll <- rbind(sbjTest, sbjTrain)
    
    # Data-X (Measurements)      
    xAll <- rbind(xTrain, xTest)  
    
    # Data-Y (Activities)      
    yAll <- rbind(yTrain, yTest)  
    
    # One Big Dataset
    bigData <- cbind(sbjAll, yAll, xAll)
    
    # Number of Rows in Data     
    nAll <- nTest + nTrain
    
# -----------------------------------------------------------------------------------    
    
    ## Extract Measurements on Mean and Std  (TASK #2)
    
    # Find Indices of "Mean"
    meanFeatIndex <- grep("mean\\(\\)", features$Name) 
    
    # Find Indices of "Std"
    stdFeatIndex <- grep("std\\(\\)", features$Name)     
    
    # Combine and Sort Indices
    smallFeatIndex <- sort(c(meanFeatIndex, stdFeatIndex))
    
    # Subset of Feature Names
    smallFeatNames <- features$Name[smallFeatIndex]
    
    # Subset of bigData
    smallData <- bigData[, c(1, 2, smallFeatIndex + 2)]
    
# -----------------------------------------------------------------------------------    
    
    ## Name Activities (TASK #3)
    
    # Create a new character list
    
    activity <- as.character(smallData$Activity)
    
    # Replace Activity Index by the corresponding Activity Name
    
    for (i in 1:6)  {
        
        activity <- gsub(as.character(i), actLabel$Name[i], activity)
    }
    
    # Overwrite Data$Activity by New Activity Names

    smallData$Activity <- activity

# -----------------------------------------------------------------------------------    
    
    ## Make Labels (TASK #4)
    
    # Rules: 
    # Replace the first letter in the name 't' by 'time'
    # Replace the first letter in the name 'f' by 'freq'
    # Remove "-", "(", ")" and capitalize the first letter after "-"
    # Replace "," by "."
    # Use make.names() to create valid variable names.

    tmp <- gsub("^f", "freq", smallFeatNames, perl = TRUE)    
    tmp <- gsub("^t", "time", tmp, perl = TRUE)    
    tmp <- gsub("-(\\w)", "\\U\\1", tmp, perl = TRUE)
    tmp <- gsub("\\(|\\)", "", tmp)
    tmp <- gsub("\\,", "\\.", tmp)
    cleanFeatNames <- c(names(smallData)[1:2], tmp)
    names(smallData) <- make.names(cleanFeatNames, unique = TRUE, allow_ = TRUE)
    
# -----------------------------------------------------------------------------------

    ## Tidy Data Set of the Mean for Each Activity and Subject (TASK #5)

    # Group Data by Subject
    gpSmallData <- group_by(smallData, Activity, Subject)
    
    # Summarize and Compute the Mean for Each measurement
    tidyData <- summarize_each(gpSmallData, funs(mean))
    
    # Write Table
    write.table(tidyData,"tidyData.txt", row.name = FALSE)

# -----------------------------------------------------------------------------------
    
