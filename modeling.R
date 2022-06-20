#install.packages("randomForest")
install.packages("caret")

train <- read.csv("train.csv", header=TRUE)
test <- read.csv("test.csv", header = TRUE)

#library(randomForest)
library(caret)

#for a classification problem, need to make sure that outcome is factor
train$Survived <- as.factor(train$Survived)
typeof(train$Age)

#remove missing rows (for now)
train.narm <- na.omit(train)

####Feature Engineering- TO DO ####

#### Modeling ####

#10-fold cross validation
control <- 


#random forest
rf <- randomForest(
  Survived ~ Pclass + Sex + SibSp + Parch + Age + Fare + Sex*Fare + Sex*Age*Fare,
  data=train.narm, proximity=TRUE, importance = TRUE)

print(rf)

test$pred = predict(rf, test)