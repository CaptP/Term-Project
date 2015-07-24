#Project_ Getting and Cleaning Data--Course ID: getdata-030 CaptP
#################################################################
#  Read in all the files.  
#  There are 30 subjects, each does 6 activities and there are 561 measurements done for each
#  of those 6x30=180 cases. 
#  We only want those measurements that are a mean or std dev. So we  put everything together 
#  and then select the columns that have "mean" or "std" in the name.
#################################################################
    setwd("T:/BP-DATA/Courses/Data_Science/G_and_C_Data/Project/UCI HAR Dataset")
#################################################################
#  I fetched the zip files from the indicated url and put in the above directory .
#  Read in files ################################################# 
    Xtest<-read.table ("test/X_test.txt", header=FALSE)
    Ytest<-read.table ("test/Y_test.txt", header=FALSE)
    subjectTest<-read.table ("test/subject_test.txt", header=FALSE)
    Xtrain<-read.table ("train/X_train.txt", header=FALSE)
    Ytrain<-read.table ("train/y_train.txt", header=FALSE)
    subjectTrain<-read.table ("train/subject_train.txt", header=FALSE)
    activities<-read.table("activity_labels.txt", header=FALSE)
    features<-read.table("features.txt", header=FALSE)
    library(dplyr)
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
#  All done. CaptP
