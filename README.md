### Script Description

This script merges the analysed test and train datasets into one ordered and organised complete dataset. 
The ordering is done by subject and then by activity. Finally, the mean and standard deviations variables from the
analysed data were extracted. There are 33 means and 33 corresponding standard deviations.
Those variables names were simplified, by removing special characters and applying other transformations to
turn them better readable.
Finally, a second, independent tidy data set with the average of each variable for each activity and each subject
was created.


### Code
<!-- -->

      library(plyr) # import libraries
      setwd("getdata_projectfiles_UCI HAR Dataset") # go to main directory where data is
      setwd("UCI HAR Dataset")
      labels = read.table ("activity_labels.txt") # load activity labels dataset
      names(labels)<-c("Activity_ID","Activity_Description") # name the columns of the activity labels dataset
      features = read.table("features.txt", stringsAsFactors = FALSE) # load features list dataset as char
      names(features)<-c("featIndex","Feature") # name the columns of the features list dataset dataset
      setwd("test") # go to the test data directory
      subject_test <- read.table ("subject_test.txt") # load the subject_test dataset
      selection_id <- rep("1",length(subject_test[1])) # create an ID variable to distinguish between 'test' and 'train', in this case for the test dataset
      subject_test[2] <- selection_id # and add that variable to the subject_test dataset
      names(subject_test) <- c("Subject","Selection_ID") # name the columns of the subject_test dataset.
      x_test <- read.table ("X_test.txt") # load the remaining 2 test datasets
      y_test <- read.table ("y_test.txt")
      names(y_test) <- c("Activity_ID") # name the y_test dataset column. # This is another ID variable, this time to distinguish between the 6 types of activity
      setwd("..") # go back one directory
      setwd("train") # go to the train directory
      # Repeat all the steps performed with the test data, but now with the train data
      subject_train <- read.table ("subject_train.txt")
      selection_id <- rep("2",length(subject_train[1]))
      subject_train[2] <- selection_id
      names(subject_train) <- c("Subject","Selection_ID")
      x_train <- read.table ("X_train.txt")
      y_train <- read.table ("y_train.txt")
      names(y_train) <- c("Activity_ID")
      setwd("..")
      test_data <- cbind(subject_test,y_test,x_test) # merge the 3 test datasets
      train_data <- cbind(subject_train,y_train,x_train) # merge the 3 train datasets
      total_data <- join_all(list(test_data,train_data),type="full") # create a complete dataset that includes 'test' and 'train' data
      names(total_data)<-c("Subject", "Selection_ID", "Activity_ID",features$Feature) # name the complete dataset, including now the features names.
      # create factors describing the type of activity abd the subject selection ('test' or 'train') from the ID variables
      total_data$Activity = factor(total_data$Activity_ID,labels=(labels$Activity_Description))
      total_data$Selection = factor(total_data$Selection_ID,labels=c("test","train"))
      # organize the data
      total_data <- total_data[,c(1,566,2,3,565,seq(4,564))] # organize the columns
      total_data <- total_data[order(total_data$Subject,total_data$Activity_ID),] # organize the lines, by ordering by subject and then by activity
      # remove the ID variables. They are not needed anymore, since we have already the description factors
      total_data$Activity_ID=NULL
      total_data$Selection_ID=NULL
      # extract the mean and standard deviation variables. Mean frequencies and angles are no included. Note that there are 33 means and 33 corresponding standard deviations
      mean_std_data <- total_data[,c(1,2,3,grep("mean\\()",colnames(total_data)),grep("std\\()",colnames(total_data)))]
      # simplify the variavle names. Underscores and parenthesis removed. To facilitate reading, 'mean' was turned into 'Mean' and 'std' into 'Std'
      # This way, each variable starts with a 'f' or 't', followed by all the other analysis processes starting with capitals.
      names(mean_std_data) <- sub("mean","Mean",names(mean_std_data))
      names(mean_std_data) <- sub("std","Std",names(mean_std_data))
      names(mean_std_data) <- gsub("-","",names(mean_std_data))
      names(mean_std_data) <- sub("\\()","",names(mean_std_data))
      # Computed the mean values of the features
      measure_vars <- names(total_data[4:564])
      melt <- melt(total_data,id=c("Subject","Selection","Activity",),measure.vars=measure_vars)
      tidy_data <- dcast(melt,Subject+Activity~variable,mean)
      write.table(tidy_data, "d:/mydata.txt", sep="\t")

