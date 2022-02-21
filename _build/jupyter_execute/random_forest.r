library(tidyverse)
library(ggplot2)
library(kableExtra)
library(caret)
library(rpart)
library(rpart.plot)
library(randomForest)
churn <- read_csv("_build/data/churn_train.csv") %>% mutate_if(is.character, as.factor)
cvConditions <- trainControl(method = "cv", number = 5)

churn$churn <- ifelse(churn$churn=="yes", "churn", "no churn")
churn$churn <- factor(churn$churn, levels=c("churn", "no churn"))

modelRF <- randomForest(churn ~ ., data = churn, importance=TRUE)

importance(modelRF, type = 1)

set.seed(972945)
rfCV <- train(churn ~ ., 
                 data = churn,
                 method = "rf", 
                 trControl = cvConditions)

rfCV
