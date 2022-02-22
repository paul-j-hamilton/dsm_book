library(tidyverse)
library(kableExtra)
library(ggplot2)
options(readr.num_columns = 0)
churn <- read_csv("../_build/data/churn_train.csv")

head(churn)

churnSample <- read_csv("../_build/data/churn_sample.csv")
churnSample$churn = ifelse(churnSample$churn==1, "churn", "no churn")
churnSample$account_length = churnSample$account_length*sd(churn$account_length) + mean(churn$account_length)
churnSample$total_intl_charge = churnSample$total_intl_charge*sd(churn$total_intl_charge) + mean(churn$total_intl_charge)
library(ggplot2)

suppressMessages(print(ggplot(churnSample, aes(x=account_length, y=total_intl_charge, color=churn, shape=churn)) + geom_point(size=2) + theme_bw() +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"))))

churnSample <- read_csv("../_build/data/churn_sample.csv")
churnSample$churn = ifelse(churnSample$churn==1, "churn", "no churn")

churnSample$account_length = churnSample$account_length*sd(churn$account_length) + mean(churn$account_length)
churnSample$total_intl_charge = churnSample$total_intl_charge*sd(churn$total_intl_charge) + mean(churn$total_intl_charge)
library(ggplot2)

pointA = data.frame(account_length=25, total_intl_charge=3)
pointANearest = data.frame(c(4.564370,pointA$account_length,7.721684,pointA$account_length,20.697285,pointA$account_length,42.072091,pointA$account_length,48.209354, pointA$account_length), 
                           c(2.6889498,pointA$total_intl_charge,2.8776394,pointA$total_intl_charge,2.6624903,pointA$total_intl_charge,2.7909322,pointA$total_intl_charge,3.1609721,pointA$total_intl_charge),
                           c("no churn","no churn","no churn","no churn","no churn","no churn","no churn","no churn","no churn","no churn"))
names(pointANearest) = c("account_length", "total_intl_charge", "churn")
pointB = data.frame(account_length=160, total_intl_charge=1.8)
pointBNearest = data.frame(c(172.389055,pointB$account_length,171.992009,pointB$account_length,160.344819,pointB$account_length,148.586736,pointB$account_length,144.073490,pointB$account_length), 
                           c(1.6791425,pointB$total_intl_charge,2.0317458,pointB$total_intl_charge,1.5954999,pointB$total_intl_charge,1.6851977,pointB$total_intl_charge,1.6953439,pointB$total_intl_charge), c("no churn","no churn","no churn","no churn","no churn","no churn","no churn","no churn","no churn","no churn"))
names(pointBNearest) = c("account_length", "total_intl_charge", "churn")
pointC = data.frame(account_length=100, total_intl_charge=2.85)
pointCNearest = data.frame(c(93.494871,pointC$account_length,91.650732,pointC$account_length,98.252319,pointC$account_length,109.494056,pointC$account_length,112.812032,pointC$account_length),
                           c(2.7048315,pointC$total_intl_charge,3.0463884,pointC$total_intl_charge,2.5214656,pointC$total_intl_charge,3.0806561,pointC$total_intl_charge,2.7891426,pointC$total_intl_charge),
                           c("no churn","no churn","no churn","no churn","no churn","no churn","no churn","no churn","no churn","no churn"))
names(pointCNearest) = c("account_length", "total_intl_charge", "churn")

suppressWarnings(print(ggplot(churnSample, aes(x=account_length, y=total_intl_charge, color=churn, shape=churn)) + geom_point(size=2) + theme_bw() +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"))+
  geom_point(aes(x=pointA$account_length, y=pointA$total_intl_charge), colour="darkgreen", shape=15, size=3) + annotate("text", x = 25, y = 3.25, label = "Customer A") + 
  geom_path(data=pointANearest, colour="black")+
  geom_point(aes(x=pointB$account_length, y=pointB$total_intl_charge), colour="darkgreen", shape=15, size=3) + annotate("text", x = 100, y = 3.6, label = "Customer B") + 
  geom_path(data=pointBNearest, colour="black")+
  geom_point(aes(x=pointC$account_length, y=pointC$total_intl_charge), colour="darkgreen", shape=15, size=3) + annotate("text", x = 160, y = 2.15, label = "Customer C") + 
  geom_path(data=pointCNearest, colour="black"))) 

churnSample <- read_csv("../_build/data/churn_sample.csv")
churnSample$churn = ifelse(churnSample$churn==1, "churn", "no churn")

churnSample$account_length = churnSample$account_length*sd(churn$account_length) + mean(churn$account_length)
churnSample$total_intl_charge = churnSample$total_intl_charge*sd(churn$total_intl_charge) + mean(churn$total_intl_charge)
library(ggplot2)

pointA = data.frame(account_length=25, total_intl_charge=3)
pointANearest = data.frame(c(4.564370,pointA$account_length), 
                           c(2.6889498,pointA$total_intl_charge),
                           c("no churn","no churn"))
names(pointANearest) = c("account_length", "total_intl_charge", "churn")

suppressWarnings(print(ggplot(churnSample, aes(x=account_length, y=total_intl_charge, color=churn, shape=churn)) + geom_point(size=2) + theme_bw() +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"))+
  geom_point(aes(x=pointA$account_length, y=pointA$total_intl_charge), colour="darkgreen", shape=15, size=3) + annotate("text", x = 25, y = 3.25, label = "Customer A") + 
  geom_path(data=pointANearest, colour="black")))

churnSample <- read_csv("../_build/data/churn_sample.csv")
churnSample$churn = ifelse(churnSample$churn==1, "churn", "no churn")

churnSample$account_length = churnSample$account_length*sd(churn$account_length) + mean(churn$account_length)
churnSample$total_intl_charge = churnSample$total_intl_charge*sd(churn$total_intl_charge) + mean(churn$total_intl_charge)
library(ggplot2)

pointA = data.frame(account_length=50, total_intl_charge=2,churn="churn")
pointB = data.frame(c(100,pointA$account_length), 
                           c(2,pointA$total_intl_charge),
                           c("no churn","no churn"))
names(pointB) = c("account_length", "total_intl_charge", "churn")

pointC = data.frame(account_length=150, total_intl_charge=2,churn="churn")
pointD = data.frame(c(150,pointC$account_length), 
                           c(3,pointC$total_intl_charge),
                           c("no churn","no churn"))
names(pointD) = c("account_length", "total_intl_charge", "churn")

suppressWarnings(print(ggplot(churnSample, aes(x=account_length, y=total_intl_charge, color=churn, shape=churn)) + geom_point(size=2) + theme_bw() +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"))+
  geom_point(aes(x=pointA$account_length, y=pointA$total_intl_charge), colour="darkgreen", shape=15, size=3) +
  geom_path(data=pointB, colour="black") + 
  geom_point(aes(x=pointB[1,]$account_length, y=pointB[1,]$total_intl_charge), colour="darkgreen", shape=15, size=3)+
  geom_point(aes(x=pointC$account_length, y=pointC$total_intl_charge), colour="darkgreen", shape=15, size=3) +
  geom_path(data=pointD, colour="black") + 
  geom_point(aes(x=pointD[1,]$account_length, y=pointD[1,]$total_intl_charge), colour="darkgreen", shape=15, size=3)))

churnSample <- read_csv("../_build/data/churn_sample.csv")
churnSample$account_length <- (churnSample$account_length - min(churnSample$account_length)) / (max(churnSample$account_length) - min(churnSample$account_length))
churnSample$total_intl_charge <- (churnSample$total_intl_charge - min(churnSample$total_intl_charge)) / (max(churnSample$total_intl_charge) - min(churnSample$total_intl_charge))
churnSample$churn = ifelse(churnSample$churn==1, "churn", "no churn")
library(ggplot2)

suppressWarnings(print(ggplot(churnSample, aes(x=account_length, y=total_intl_charge, color=churn, shape=churn)) + geom_point(size=2) + theme_bw() +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"))))

library(caret)

# Create min-max scaler
scaler <- preProcess(churn, method="range")

# Apply scaler to our data set
churnScaled <- predict(scaler, churn)

head(churnScaled)

# Convert categorical variables to dummy variables
churnScaled$international_plan <- ifelse(churnScaled$international_plan=="yes", 1, 0)
churnScaled$voice_mail_plan <- ifelse(churnScaled$voice_mail_plan=="yes", 1, 0)

head(churnScaled)

churnNew <- read_csv("../_build/data/churn_new.csv")

head(churnNew)

churnNewScaled <- predict(scaler, churnNew)

head(churnNewScaled)

churnNewScaled$international_plan <- ifelse(churnNewScaled$international_plan=="yes", 1, 0)
churnNewScaled$voice_mail_plan <- ifelse(churnNewScaled$voice_mail_plan=="yes", 1, 0)

head(churnNewScaled)

library(class)
knnModelK5 <- knn(train = churnScaled[,-13], test = churnNewScaled, 
                  cl = churnScaled$churn, k = 5, prob=TRUE)

knnModelK5
