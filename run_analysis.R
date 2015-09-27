#loading required packages
library(dplyr)
library(tidyr)

#loading all txt files in memory
files <- dir(recursive=TRUE,pattern ='\\.txt$')
List <- lapply(files,read.table,fill=TRUE)

#selecting useful files
#saving files into corresponding file names, converting them into data frames and finally naming columns
activity<-List[1]
activity<-as.data.frame(activity)
activity<-tbl_df(activity)
names(activity)<-c("No.","activity")

features<-List[2]
features<-as.data.frame(features)
features<-tbl_df(features)
names(features)<-c("No.","features")

y_train<-List[28]
y_train<-as.data.frame(y_train)
y_train<-tbl_df(y_train)
names(y_train)<-c("Activity")

x_train<-List[27]
x_train<-as.data.frame(x_train)
x_train<-tbl_df(x_train)
#features as column names
names(x_train) <- features$features

subject_train<-List[26]
subject_train<-as.data.frame(subject_train)
subject_train<-tbl_df(subject_train)
names(subject_train) <- c("Subject")

y_test<-List[16]
y_test<-as.data.frame(y_test)
y_test<-tbl_df(y_test)
names(y_test)<-c("Activity")

x_test<-List[15]
x_test<-as.data.frame(x_test)
x_test<-tbl_df(x_test)
#features as column names
names(x_test) <- features$features

subject_test<-List[14]
subject_test<-as.data.frame(subject_test)
subject_test<-tbl_df(subject_test)
names(subject_test) <- c("Subject")


rm("List")


#Merging the training and the test sets to create one data set.
new_data_test<-bind_cols(y_test,subject_test,x_test)
new_data_train<-bind_cols(y_train,subject_train,x_train)
new_data<-rbind(new_data_test,new_data_train)


#Using descriptive activity names to name the activities in the data set
new_data$Activity<-new_data$Activity_no%>%
  replace(new_data$Activity==1,c('WALKING'))%>%
  replace(new_data$Activity==2,c('WALKING_UPSTAIRS'))%>%
  replace(new_data$Activity==3,c('WALKING_DOWNSTAIRS'))%>%
  replace(new_data$Activity==4,c('SITING'))%>%
  replace(new_data$Activity==5,c('STANDING'))%>%
  replace(new_data$Activity==6,c('LAYING'))

#conversion to valid column names
valid_column_names <- make.names(names=names(new_data), unique=TRUE, allow_ = TRUE)
names(new_data) <- valid_column_names

#Extracting only the measurements on the mean and standard deviation for each measurement.
activity_subject<-select(new_data,1:2)
mean_columns<-select(new_data,contains("mean"))
std_columns<-select(new_data,contains("std"))
mean_std_data<-bind_cols(activity_subject,mean_columns,std_columns)

#data set with the average of each variable for each activity and each subject.
final_dataset<-mean_std_data%>%group_by(Activity,Subject)%>%summarise_each(funs(mean))
View(final_dataset)