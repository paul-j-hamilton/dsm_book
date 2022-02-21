options(warn=-1)
options(readr.num_columns = 0)

library(MLmetrics)
library(tidyverse)
library(kableExtra)
library(ggplot2)
library(caret)
library(class)

churn <- read_csv("_build/data/churn_train.csv")
scaler <- preProcess(churn, method="range")
churnScaled <- predict(scaler, churn)
churnScaled$international_plan <- ifelse(churnScaled$international_plan=="yes", 1, 0)
churnScaled$voice_mail_plan <- ifelse(churnScaled$voice_mail_plan=="yes", 1, 0)
churnHoldout <- read_csv("_build/data/churn_holdout.csv")
churnHoldoutScaled <- predict(scaler, churnHoldout)
churnHoldoutScaled$international_plan <- ifelse(churnHoldoutScaled$international_plan=="yes", 1, 0)
churnHoldoutScaled$voice_mail_plan <- ifelse(churnHoldoutScaled$voice_mail_plan=="yes", 1, 0)

cvConditions <- trainControl(method = "cv", number = 5)
set.seed(972945)
knnCV <- train(churn ~ ., 
                 data = churnScaled,
                 method = "knn", 
                 trControl = cvConditions, 
                 tuneGrid = expand.grid(k = c(1, 3, 5, 10, 20)))

finalModelPredictions <- predict(knnCV, churnHoldoutScaled)

ConfusionMatrix(finalModelPredictions, churnHoldoutScaled$churn)

finalModelPredictionsProb <- predict(knnCV, churnHoldoutScaled, type = "prob")
head(finalModelPredictionsProb)

finalModelPredictions0.8 <- ifelse(finalModelPredictionsProb$yes > 0.8, "yes", "no")
finalModelPredictions0.8[1:5]

ConfusionMatrix(finalModelPredictions0.8, churnHoldoutScaled$churn)

finalModelPredictions0.2 <- ifelse(finalModelPredictionsProb$yes > 0.2, "yes", "no")
ConfusionMatrix(finalModelPredictions0.2, churnHoldoutScaled$churn)

points <- data.frame(fp=c(0, 0.1581081, 0.03378378, 0.001351351, 1), tp=c(0, 0.7727273, 0.4454545, 0.1454545, 1))
ggplot(points, aes(x=fp, y=tp)) + geom_point(size=2)  + geom_line(size=1.25) +
  theme_bw() +
  xlim(0, 1) + ylim(0, 1) +
  xlab("False Positive Rate") + ylab("True Positive Rate") + 
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold")) + 
  annotate("text", x = 0.08, y = 0, label = "Cutoff = 1") + 
  annotate("text", x = 0.08, y = 0.13, label = "Cutoff = 0.8") +
  annotate("text", x = 0.12, y = 0.45, label = "Cutoff = 0.5") +
  annotate("text", x = 0.24, y = 0.73, label = "Cutoff = 0.2") +
  annotate("text", x = 0.95, y = 0.95, label = "Cutoff = 0")

points <- data.frame(fp=c(0, 0.1581081, 0.03378378, 0.001351351, 1), tp=c(0, 0.7727273, 0.4454545, 0.1454545, 1))
badPoints <- data.frame(fp=c(0,1), tp=c(0,1))
ggplot(points, aes(x=fp, y=tp)) + geom_point(size=2)  + geom_line(size=1.25) +
  theme_bw() +
  xlim(0, 1) + ylim(0, 1) +
  xlab("False Positive Rate") + ylab("True Positive Rate") + 
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold")) + 
  geom_line(data=badPoints, aes(x=fp, y=tp), linetype = "dashed", color="red", size=1.5) 

points <- data.frame(fp=c(0, 0.1581081, 0.03378378, 0.001351351, 1), tp=c(0, 0.7727273, 0.4454545, 0.1454545, 1))
badPoints <- data.frame(fp=c(0,1), tp=c(0,1))
perfectPoints <- data.frame(fp=c(0,0,1), tp=c(0,1,1))
ggplot(points, aes(x=fp, y=tp)) + geom_point(size=2)  + geom_line(, size=1.25) +
  theme_bw() +
  xlim(0, 1) + ylim(0, 1) +
  xlab("False Positive Rate") + ylab("True Positive Rate") + 
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold")) + 
  geom_line(data=badPoints, aes(x=fp, y=tp), linetype = "dashed", color="red", size=1.5) +
  geom_line(data=perfectPoints, aes(x=fp, y=tp), linetype = "longdash", color="blue", size=1.25)

library(ROCR)

rocPrediction <- prediction(finalModelPredictionsProb$yes, churnHoldoutScaled$churn)
roc <- performance(rocPrediction, "tpr", "fpr")

plot(roc)

# Convert labels to binary (0 / 1)
trueLabelsBinary <- ifelse(churnHoldoutScaled$churn=="yes", 1, 0)

# Calculate AUC
AUC(finalModelPredictionsProb$yes, trueLabelsBinary)

# Convert labels to binary (0 / 1)
trueLabelsBinary <- ifelse(churnHoldoutScaled$churn=="yes", 1, 0)

# Calculate log loss
LogLoss(finalModelPredictionsProb$yes, trueLabelsBinary)
