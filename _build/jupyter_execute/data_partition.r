library(MLmetrics)
library(tidyverse)
library(kableExtra)
library(ggplot2)
library(caret)
library(class)
options(readr.num_columns = 0)
churn <- read_csv("_build/data/churn_train.csv")
scaler <- preProcess(churn, method="range")
churnScaled <- predict(scaler, churn)
churnScaled$international_plan <- ifelse(churnScaled$international_plan=="yes", 1, 0)
churnScaled$voice_mail_plan <- ifelse(churnScaled$voice_mail_plan=="yes", 1, 0)

# Set the random seed
set.seed(972943)

# Define the training and validation sets
library(caTools)
sample <- sample.split(churnScaled$churn, SplitRatio = 0.8)

# Split the data into two data frames
train <- subset(churnScaled, sample == TRUE)
validate <- subset(churnScaled, sample == FALSE)

dim(train)
dim(validate)

knnModelK1 <- knn(train = train[,-13], test = validate[,-13], 
                  cl = train$churn, k = 1, prob=TRUE)

knnModelK3 <- knn(train = train[,-13], test = validate[,-13], 
                  cl = train$churn, k = 3, prob=TRUE)

knnModelK5 <- knn(train = train[,-13], test = validate[,-13], 
                  cl = train$churn, k = 5, prob=TRUE)

knnModelK10 <- knn(train = train[,-13], test = validate[,-13], 
                  cl = train$churn, k = 10, prob=TRUE)

knnModelK20 <- knn(train = train[,-13], test = validate[,-13], 
                  cl = train$churn, k = 20, prob=TRUE)

knnModelK1[1:5]

Accuracy(knnModelK1, validate$churn)

Accuracy(knnModelK3, validate$churn)
Accuracy(knnModelK5, validate$churn)
Accuracy(knnModelK10, validate$churn)
Accuracy(knnModelK20, validate$churn)

cvConditions <- trainControl(method = "cv", number = 5)

set.seed(972945)
knnCV <- train(churn ~ ., 
                 data = churnScaled,
                 method = "knn", 
                 trControl = cvConditions, 
                 tuneGrid = expand.grid(k = c(1, 3, 5, 10, 20)))

knnCV

churnHoldout <- read_csv("_build/data/churn_holdout.csv")
head(churnHoldout)

# Apply min-max scaling to the holdout set
churnHoldoutScaled <- predict(scaler, churnHoldout)

# Convert categorical variables in the holdout set to dummy variables
churnHoldoutScaled$international_plan <- ifelse(churnHoldoutScaled$international_plan=="yes", 1, 0)
churnHoldoutScaled$voice_mail_plan <- ifelse(churnHoldoutScaled$voice_mail_plan=="yes", 1, 0)

head(churnHoldoutScaled)

knnCV$finalModel

finalModelPredictions <- predict(knnCV, churnHoldoutScaled)
finalModelPredictions[1:5]

Accuracy(finalModelPredictions, churnHoldoutScaled$churn)
