#install.packages("randomForest")
install.packages("caret")

train <- read.csv("https://raw.githubusercontent.com/m-earle/titanic-ml/main/train.csv", header=TRUE)
test <- read.csv("https://github.com/m-earle/titanic-ml/blob/main/test.csv", header = TRUE)

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
control <- trainControl(method = "cv", number = 10)
metric = "Accuracy"

#LDA
set.seed(7)
fit.lda <- train(Survived ~ Pclass + Sex + SibSp
                 + Parch + Age + Fare + Sex*Fare + Sex*Age*Fare,
                data = train.narm, method = "lda",
                metric = metric, trControl = control)
#CART
set.seed(7)
fit.cart <- train(Survived ~ Pclass + Sex + SibSp
                  + Parch + Age + Fare + Sex*Fare + Sex*Age*Fare,
                  data = train.narm, method = "rpart",
                  metric = metric, trControl = control)
#kNN
set.seed(7)
fit.knn <- train(Survived ~ Pclass + Sex + SibSp
                  + Parch + Age + Fare + Sex*Fare + Sex*Age*Fare,
                  data = train.narm, method = "knn",
                  metric = metric, trControl = control)
#SVM with radial kernel
set.seed(7)
fit.svm <- train(Survived ~ Pclass + Sex + SibSp
                 + Parch + Age + Fare + Sex*Fare + Sex*Age*Fare,
                 data = train.narm, method = "svmRadial",
                 metric = metric, trControl = control)
#random forest
set.seed(7)
fit.rf <- train(Survived ~ Pclass + Sex + SibSp
                + Parch + Age + Fare + Sex*Fare + Sex*Age*Fare,
                data = train.narm, method = "rf",
                metric = metric, trControl = control)

#find best model
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)
dotplot(results)

#summarize best model
print(fit.svm)
fit.svm$results



test$pred = predict(rf, test)