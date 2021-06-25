library(dplyr)

#First I read and create the data frames for the required data
features <- read.table("features.txt")
testset <- read.table("X_test.txt", col.names=features$V2)
testlabel <- read.table("Y_test.txt", col.names="activity")
trainset <- read.table("X_train.txt", col.names=features$V2)
trainlabel <- read.table("Y_train.txt", col.names="activity")
testsubj <- read.table("subject_test.txt", col.names="subj")
trainsubj <- read.table("subject_train.txt", col.names="subj")
activity_labels <- read.table("activity_labels.txt")

#I create the test and train data.frames
testcomplete <- data.frame(testset, testlabel, testsubj)
traincomplete <- data.frame(trainset,trainlabel,trainsubj)


#Then I put them together
allthedata <- bind_rows(traincomplete, testcomplete)


#I select the variables of interest (activity, subj and the ones that contain "mean" or "std")
onlyvalues <- select(allthedata, c(activity, subj, contains("std"),contains("mean")))

#In the labels' column, each value represent a type of activity. "activity_labels" indicates what activity is each number
#I change the numbers for its correspondent activity

for (i in 1:nrow(onlyvalues)){
  onlyvalues[i,1] <- activity_labels[onlyvalues[i,1],2]
} 

#Finally, I create a data.frame with one single row per activity-subject pair
tidydata <- aggregate(onlyvalues, by = list(onlyvalues$subj, onlyvalues$activity), FUN = "mean")
tidydata <- select(tidydata, -c(subj,activity))
tidydata <- rename(tidydata, subject = Group.1, activity = Group.2)
