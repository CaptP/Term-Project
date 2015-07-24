##Term Project in Course -- Getting and Cleaning Data
##Course ID: getdata-030 CaptP

#### The problem:  Take a group of files with multiple (561) gyroscope and accelerometer measurements from 30 subjects, doing 6 activities, such as walking; assemble these files into a Tidy file. Then average the data for eack
subject and activity. First assemble everthing into tidiness and then average over subject and activity forming 180 rows.
 
 The required steps for the project are:
Create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
 These 5 parts are described in run_analysis.R
 
##Variables
File names and variable names.  The original data was split into test data and training data. Our job is to recombine.
The data was split so that data for some subjects went into the test file and for others into the train.  
Xtest<-read.table ("test/X_test.txt", header=FALSE) -> actual data test
Ytest<-read.table ("test/Y_test.txt", header=FALSE) -> subjects column test
subjectTest<-read.table ("test/subject_test.txt", header=FALSE)
Xtrain<-read.table ("train/X_train.txt", header=FALSE)
Ytrain<-read.table ("train/y_train.txt", header=FALSE)
subjectTrain<-read.table ("train/subject_train.txt", header=FALSE)
activities<-read.table("activity_labels.txt", header=FALSE)
features<-read.table("features.txt", header=FALSE)

#  Put train and test together. Combine data sets ####### 
#  Project Objective 1..
    datax<-dplyr::bind_rows(Xtest,Xtrain) 
    datay<-dplyr::bind_rows(Ytest,Ytrain)
    datasubject<-dplyr::bind_rows(subjectTest,subjectTrain)
#  Find columns in datax that contain either mean or std.####### 
#  Project Objective 2.
    library(stringr)
    meanstdonly<-features %>% filter(str_detect(V2, "mean\\(") | str_detect(V2, "std\\("))
#  Notice the escape sequence(\\) so that you don't get MeanFreq.
    datax<-datax[,meanstdonly[,1]]  #Get columns with mean or std only
    names(datax)<-meanstdonly[,2]   #datax now has the names of the mean or std feature.
#  Put in Activities and column names
#  Project objectives 3 and 4
    datay$V1<-activities[datay$V1,2]
    colnames(datay)<-c("Activity")
    colnames(datasubject)<-c("Subject")
    Tidy_Data_Set<- cbind(datasubject,datay,datax)
    Tidy<-Tidy_Data_Set[order(Tidy_Data_Set$Subject),] #Ordered by Subject
    library(plyr)  #Average all the data for each Subject and Activity
#  Project objective 5  Create tidy data set with averages.
    TidyAverage<-ddply(Tidy_Data_Set, .(Subject, Activity), function(x) colMeans(x[,3:68]))
#  Output Table with the averages.    
    write.table(TidyAverage, "Tidy_Averages.txt", row.name=FALSE)
