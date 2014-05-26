### Codebook:

labels: activity labels dataset. It comes from the file "activity_labels.txt". It has 2 variables:
* Activity_ID: activity number
* Activity_Description: activity name

selection_id: variable created to distinguish between 'test' and 'train' values

features: list of the features. It comes from the file features.txt. It has 2 variables:
* featIndex: feature index
* Feature: feature name

subject_test: test subjects list. It comes from the file "subject_test.txt". It has 2 variables:
* Subject: subject index
* Selection_ID: 1 for 'test' or 2 for 'train'

subject_train: test subjects list. It comes from the file "subject_train.txt".

x_test: test set. It comes from the file "X_test.text".

x_train: train set. It comes from the file "X_train.text".

y_test: test labels in numeric format. It comes from the file "y_test.txt".

y_train: train labels in numeric format. It comes from the file "y_train.txt".

test_data: dataset to store all the test data. It has 564 variables:
* Subject: subject index
* Selection_ID: 1 for 'test' or 2 for 'train'
* Activity_ID: activity number
* V1 till V561: the features indexes

train_data: dataset to store all the train data. It has the same 564 variables as 'test_data'.

total_data: complete dataset resulting in the merge of 'test_data' and 'train_data'. It has 564 variables:
* Subject: subject index
* Selection_ID: 1 for 'test' or 2 for 'train'
* Activity_ID: activity number
* V1 till V561: the features indexes
Transformations:
* Selection_ID converted into Selection, a factor conaining 2 level: test and train
* Activity_ID converted into Activity, a factor containing 6 levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS
, SITTING
, STANDING
, LAYING

* V1 till V564 replace by the respective names, based on the 'features' list
* Sorted according to the subject and activity

mean_std_data: the mean and standard deviations variables from the analysed data were extracted. There are 33 means and 33 corresponding standard deviations. Those variables names were simplified, by removing special characters and applying other transformations to turn them better readable. 

meanFeatures: independent tidy data set with the average of each variable for each activity and each subject.