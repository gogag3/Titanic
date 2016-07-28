# Setting Working Directory
setwd("C:/Users/GUNNAR/Desktop/Desktop Data/Kaggle/Titanic")
# Importing Datasets
test <- read.csv("~/Desktop Data/Kaggle/Titanic/test.csv", stringsAsFactors = FALSE)
train <- read.csv("~/Desktop Data/Kaggle/Titanic/train.csv", stringsAsFactors = FALSE)
# Making prediction about the people that survived
prop.table(table(train$Survived))
# Getting to know something about the traing dataset dataframe
str(test)
# Adding a column to "test" dataframe
test$Survived <- rep(0, 418)
# Writing a csv file for the modified dataset with two variables PassengerID and Survived stats
submit <- data.frame(PassengerID = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "theyallperish.csv", row.names = FALSE)
# Making a proportion based on Sex (by row)
prop.table(table(train$Sex, train$Survived), 1)
# Modifying the proportion for females (Assuming all females survived)
test$Survived <- 0
test$Survived[test$Sex == "female"] <- 1
# Writing a csv file for the modified dataset with two variables PassengerID and Survived stats
submit <- data.frame(PassengerID = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "part2.csv", row.names = FALSE)
# Based on Age
train$Child <- 0
train$Child[train$Age < 18] <- 1
aggregate(Survived ~ Child + Sex, data = train, FUN = sum)
aggregate(Survived ~ Child + Sex, data = train, FUN = length)
aggregate(Survived ~ Child + Sex, data = train, FUN = function(x){ sum(x)/length(x)})
# According to Fare in Train data
train$Fare2 <- '30+'
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- '20-30'
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- '10-20'
train$Fare2[train$Fare < 10] <- '<10'
aggregate(Survived ~ Fare2 + Pclass + Sex, data = train, FUN = function(x){ sum(x)/length(x)})
# Making Predictions about females with class = 3, and Fare >= 20
test$Survived <- 0
test$Survived[test$Sex == "female"] <- 1
test$Survived[test$Sex == "female" & test$Pclass == 3 & test$Fare >= 20] <- 0
submit <- data.frame(PassengerID = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "part3.csv", row.names = FALSE)
# Making CART Decision Trees
library(rpart)
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")
plot(fit)
text(fit)
# Install following packages to make things nicer
install.packages('rattle')
install.packages('rpart.plot')
install.packages('RColorBrewer')
library(rattle)
library(rpart.plot)
library(RColorBrewer)
# And Finally
fancyRpartPlot(fit)
# Making a csv out of our Prediction
Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "myfirstdtree.csv", row.names = FALSE)

