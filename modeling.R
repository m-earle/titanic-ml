#install.packages("randomForest")

train <- read.csv("train.csv", header=TRUE)
test <- read.csv("test.csv", header = TRUE)

library(randomForest)

#for a classification problem, need to make sure that outcome is factor
train$Survived <- as.factor(train$Survived)
typeof(train$Age)

#remove missing rows (for now)
train.narm <- na.omit(train)

#random forest
rf <- randomForest(
  Survived ~ Pclass + Sex + SibSp + Parch + Age + Fare + Sex*Fare + Sex*Age*Fare,
  data=train.narm, proximity=TRUE, importance = TRUE)

print(rf)

test$pred = predict(rf, test)