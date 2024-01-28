# reading the train data set



base_path <- getwd()
URL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('TidyData')) {dir.create('TidyData')}
setwd(file.path(base_path,'TidyData'))
download.file(URL, destfile = 'data.zip', method = "curl")
unzip('data.zip')
setwd(file.path(base_path,'TidyData/UCI HAR Dataset'))

### Collecting the features of the dataset

features_df <- read.csv('features.txt',sep="\n",header=FALSE)
features_labels <- features_df %>% separate(V1,c('id','name')," ")
features_labels <- append(features_labels$name,c("activity","subject_id"))

### Training data extraction

x_train <- read.csv('train/X_train.txt',sep='',header=FALSE)
y_train <- read.csv('train/y_train.txt',sep='\n',header=FALSE)
subject_train <- read.csv('train/subject_train.txt',sep='\n',header=FALSE)
train_data <- cbind(x_train,y_train,subject_train)

### Adding feature column names to the train dataset
colnames(train_data) <- features_labels

### Test data extraction
x_test <- read.csv('test/X_test.txt',sep='',header=FALSE)
y_test <- read.csv('test/y_test.txt',sep='\n',header=FALSE)
subject_test <- read.csv('test/subject_test.txt',sep='\n',header=FALSE)
test_data <- cbind(x_test,y_test,subject_test)

### Adding feature column names to the test dataset
colnames(test_data) <- features_labels

### Merging train and test data set
final_data <- rbind(train_data,test_data)

### filtering columns that are related to mean and std 
final_data <- final_data[,grep("mean\\(\\)|std\\(\\)|activity|subject_id",colnames(final_data))]

### converting activity labels into descriptive text

final_data$activity[final_data$activity == 1] <- "WALKING"
final_data$activity[final_data$activity == 2] <- "WALKING_UPSTAIRS"
final_data$activity[final_data$activity == 3] <- "WALKING_DOWNSTAIRS"
final_data$activity[final_data$activity == 4] <- "SITTING"
final_data$activity[final_data$activity == 5] <- "STANDING"
final_data$activity[final_data$activity == 6] <- "LAYING"

### grouping data based on activity and subject id and calculating mean

aggregate_data <- final_data %>% group_by(activity,subject_id) %>% summarise(across(everything(),mean))
