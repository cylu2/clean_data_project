
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

    ## Load Data Sets

    setwd("./UCI HAR Dataset/")

# -----------------------------------------------------------------------------------    
    
    ## Labels and Features
    
    actLabel <- read.table("activity_labels.txt", col.names = c("Index", "Name"))
    features <- read.table("features.txt", col.names = c("Index", "Name"))
    featNames <- features$Name

# -----------------------------------------------------------------------------------    
    
    ## Test Data Set
    
    # Subject    
    sbjTest <- read.table("test/subject_test.txt", col.names = "SubjectIndex")
    
    # Data-X (Measurements)    
    xTest <- read.table("test/X_test.txt")
    
    # Data-Y (Activities)
    yTest <- read.table("test/Y_test.txt", col.names = "ActivityIndex")

    # Number of Data
    nTest <- nrow(subTest)   
    
# -----------------------------------------------------------------------------------

    ## Training Data Set

    # Subject        
    sbjTrain <- read.table("train/subject_train.txt", col.names = "SubjectIndex")
    
    # Data-X (Measurements)        
    xTrain <- read.table("train/X_train.txt")
    
    # Data-Y (Activities)    
    yTrain <- read.table("train/Y_train.txt", col.names = "ActivityIndex")

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
    
    # Number of Data     
    nAll <- nTest + nTrain
    
    write.csv(yAll,"Y_all.csv")    
    
# -----------------------------------------------------------------------------------    
    
    ## Extract Measurements on Mean and Std  (TASK #2)
    
    # Find Indices of "Mean"
    meanFeatIndex <- grep("mean\\(\\)", features$Name) 
    
    # Find Indices of "Std"
    stdFeatIndex <- grep("std\\(\\)", features$Name)     
    
    # Combine and Sort Indices
    meanStdFeatIndex <- sort(c(meanFeatIndex, stdFeatIndex))
    
    # Subset of Features
    meanStdFeatures <- features$Name[meanStdFeatIndex]
    
    # Subset of Data-X
    meanStdX <- xAll[, meanStdFeatIndex]
    
# -----------------------------------------------------------------------------------    
    
    ## Name Activities (TASK #3)
    
    # Create a new character list
    
    activity <- as.character(yAll[[1]])
    
    # Replace Activity Index by the corresponding Activity Name
    
    for (i in 1:6)  {
        
        activity <- gsub(as.character(i), actLabel$Name[i], activity)
    }
    
    # Create New Column
    yAll$Activity <- activity
    
    # yAll Summary
    # yAll$ActivityIndex : Activity Index
    # yAll$Activity      : Descriptive Activity Name

# -----------------------------------------------------------------------------------    
    
    ## Make Labels (TASK #4)
    
    # Rules: 
    # Remove "-", "(", ")" and capitalize the first letter after "-"
    # Replace "," by "."
    # Use make.names() to create valid variable names.
    
    # All
    tmp <- gsub("-(\\w)", "\\U\\1", featNames, perl = TRUE)
    tmp <- gsub("\\(|\\)", "", tmp)
    cleanFeatNames <- gsub("\\,", "\\.", tmp)
    names(xAll) <- make.names(cleanFeatNames, unique=TRUE, allow_ = TRUE)
    write.csv(xAll,"X_all.csv")     

    # Table Subset (Mean & Std)
    tmp <- gsub("-(\\w)", "\\U\\1", meanStdFeatures, perl = TRUE)
    tmp <- gsub("\\(|\\)", "", tmp)
    cleanFeatNames <- gsub("\\,", "\\.", tmp)
    names(meanStdX) <- make.names(cleanFeatNames, unique=TRUE, allow_ = TRUE)    
    write.csv(meanStdX,"X_mean_std.csv")    
    
# -----------------------------------------------------------------------------------

    ## Tidy Data Set of the Mean for Each Activity and Subject (TASK #5)

    # Create Subset Column in xAll
    xAll$Subject <- sbjAll[[1]]
    
    # Group Data by Subject
    gpXAll <- group_by(xAll, Subject) 
    
    # Summarize and Compute the Mean for Each <easurement
    meanXAll <- summarize_each(gpXAll, funs(mean))
    
    # Make Tidy Data
    tidyXAll <- gather(meanXAll, Subject)
    
    # Name Columns
    names(tidyXAll) <- c("Subject","Activity","Mean")
    
    # Reorder Columns: Activity-Subject-Mean 
    tidyXAll <- tidyXAll[c("Activity","Subject","Mean")]
    
    write.csv(tidyXAll,"acivity_subject_mean.csv")

# -----------------------------------------------------------------------------------
    
