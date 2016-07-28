# Setting Working Directory
setwd("~/Kaggle/Titanic")
# Importing Datasets
test <- read.csv("~/Kaggle/Titanic/test.csv", stringsAsFactors = FALSE)
train <- read.csv("~/Kaggle/Titanic/train.csv", stringsAsFactors = FALSE)
# Making prediction about the people that survived
prop.table(table(train$Survived))
# Getting to know something about the traing dataset dataframe
str(test)
# Adding a column to "test" dataframe
test$Survived <- rep(0, 418)
# Writing a csv file for the modified dataset with two variables PassengerID and Survived stats
submit <- data.frame(PassengerID = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "theyallperish.csv", row.names = FALSE)
