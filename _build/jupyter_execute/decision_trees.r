library(tidyverse)
library(ggplot2)
library(kableExtra)
library(caret)
library(rpart)
library(rpart.plot)
library(randomForest)
install.packages("e1071")
library(e1071)
churn <- read_csv("_build/data/churn_train.csv")
cvConditions <- trainControl(method = "cv", number = 5)

churnSample <- read_csv("_build/data/churn_sample2.csv")
churnSample$churn = ifelse(churnSample$churn==1, "churn", "no churn")
churnSample$account_length = churnSample$account_length*sd(churn$account_length) + mean(churn$account_length)
churnSample$total_intl_charge = churnSample$total_intl_charge*sd(churn$total_intl_charge) + mean(churn$total_intl_charge)
library(ggplot2)

ggplot(churnSample, aes(x=account_length, y=total_intl_charge, color=churn, shape=churn)) + geom_point(size=3) + theme_bw() +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"))

churnSample <- read_csv("_build/data/churn_sample2.csv")
churnSample$churn = ifelse(churnSample$churn==1, "churn", "no churn")
churnSample$account_length = churnSample$account_length*sd(churn$account_length) + mean(churn$account_length)
churnSample$total_intl_charge = churnSample$total_intl_charge*sd(churn$total_intl_charge) + mean(churn$total_intl_charge)

ggplot(churnSample, aes(x=account_length, y=total_intl_charge, color=churn, shape=churn)) + geom_point(size=3) + theme_bw() +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold")) + 
    geom_vline(xintercept = 87) + 
  annotate("text", x = 50, y = 3, label = "R1", size=6) + 
  annotate("text", x = 140, y = 3.5, label = "R2", size=6)

churnSample <- read_csv("_build/data/churn_sample2.csv")
churnSample$churn = ifelse(churnSample$churn==1, "churn", "no churn")
churnSample$account_length = churnSample$account_length*sd(churn$account_length) + mean(churn$account_length)
churnSample$total_intl_charge = churnSample$total_intl_charge*sd(churn$total_intl_charge) + mean(churn$total_intl_charge)

ggplot(churnSample, aes(x=account_length, y=total_intl_charge, color=churn, shape=churn)) + geom_point(size=3) + theme_bw() +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold")) + 
    geom_vline(xintercept = 85) + 
  annotate("text", x = 140, y = 3.5, label = "R2", size=6) + 
  annotate("text", x = 40, y = 4, label = "R4", size=6) + 
  annotate("text", x = 40, y = 2.75, label = "R3", size=6) + 
  geom_segment(aes(x = 0, y = 3.8, xend = 85, yend = 3.8), color="black") +
  scale_x_continuous(limits = c(0, 170), expand = c(0, 0))
  

thing <- churnSample
thing$churn <- factor(thing$churn, levels=c("churn", "no churn"))
thing$churn <- ordered(thing$churn, levels = c("no churn", "churn"))
modelDT1 <- rpart(churn ~ ., data = thing, minsplit = 1)
rpart.plot(modelDT1)

model <- rpart(churn ~ ., data = churn)
rpart.plot(model)

thing <- churnSample
thing$churn <- factor(thing$churn, levels=c("churn", "no churn"))
thing$churn <- ordered(thing$churn, levels = c("no churn", "churn"))
modelDT2 <- rpart(churn ~ ., data = thing, minsplit = 0, maxdepth=1)#
rpart.plot(modelDT2)

set.seed(972945)
rpartCV <- train(churn ~ ., 
                 data = churn,
                 method = "rpart2", 
                 trControl = cvConditions)

rpartCV

rpart.plot(rpartCV$finalModel)
