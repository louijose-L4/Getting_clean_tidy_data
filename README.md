Getting and Cleaning Data Course Project:

Step1: Downloading files for url and save it a local path
Step2: Reading the feature file which consist of all the feature variables
step3: include 'activity' and "subject_id" into the feature labels.  All the column variables will be mapped with corresponding column data.
step4: read x train data. This has 561 columns
step5: read y_train data. Ths has 1 column
step6: read subject data . This has 1 column
step7: merge all the column data using cbind. This dataset will have 563 columns
step8: add the column variables to the merged train data set
step9: repeat all the steps for test dataset.
step10: merge the train and test data set.
step11: filter columns headers that strings "mean", "std" and "activity" and "label"
step12:find the mean of the variables by grouping activity and label.
