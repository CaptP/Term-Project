---
title: "CodeBook.md"
author: "CaptP"
date: "Friday, July 24, 2015"
output: html_document
---

###Term Project in Course -- Getting and Cleaning Data
###Course ID: getdata-030 CaptP

#### The problem:  Take a group of files with multiple (561) gyroscope and accelerometer measurements from 30 subjects, doing 6 activities, such as walking; assemble these files into a Tidy file. Then average the data for each subject and activity. First assemble everthing into tidiness and then average over subject and activity forming 180 rows.
 
 The required steps for the project are:
Create one R script called "run_analysis.R" that does the following:  
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.  
 
 These 5 parts are described in run_analysis.R

###Input files.
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. There are 561 of these measurements.  Some are mean and standard deviantions which we will later pull out of the data.
 

###Program Variables Mapping to File Names
* The variable names in the script can be found from the corresponding read statements.  
* Xtest<-read.table ("test/X_test.txt", header=FALSE) -> actual data test  
* Ytest<-read.table ("test/Y_test.txt", header=FALSE) -> subjects column test  
* subjectTest<-read.table ("test/subject_test.txt", header=FALSE)  
* Xtrain<-read.table ("train/X_train.txt", header=FALSE)  
* Ytrain<-read.table ("train/y_train.txt", header=FALSE)  
* subjectTrain<-read.table ("train/subject_train.txt", header=FALSE)  
* activities<-read.table("activity_labels.txt", header=FALSE)  
* features<-read.table("features.txt", header=FALSE)  

###Internal Program Variables
* datax<-dplyr::bind_rows(Xtest,Xtrain) -> combined file  
* datay<-dplyr::bind_rows(Ytest,Ytrain) -> combined label  
* datasubject<-dplyr::bind_rows(subjectTest,subjectTrain) ->combined label  
* meanstdonly list of rows with mean or std.  
* datax<-datax[,meanstdonly[,1]]  #Get columns with mean or std only  
* names(datax)<-meanstdonly[,2]   #datax now has the names of the mean or std feature.  
* datay$V1<-activities[datay$V1,2]  -> list of activities  
* Tidy_Data_Set -> combined data set  
* Tidy ->  combined data set Ordered by Subject  
* TidyAverage -> final data set of averages  
* write.table(TidyAverage, "Tidy_Averages.txt", row.name=FALSE) 
* Tidy_Averages.txt is the file that was submitted.
* Finally....The final data set with averages of the averages.  
    
###CaptP


