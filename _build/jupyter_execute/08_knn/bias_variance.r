options(warn=-1)
options(readr.num_columns = 0)

library(tidyverse)
library(kableExtra)
library(ggplot2)
library(caret)
library(class)

churn <- read_csv("../_build/data/churn_train.csv")

churnSample <- read_csv("../_build/data/churn_sample.csv")
churnSample$account_length <- (churnSample$account_length - min(churnSample$account_length)) / (max(churnSample$account_length) - min(churnSample$account_length))
churnSample$total_intl_charge <- (churnSample$total_intl_charge - min(churnSample$total_intl_charge)) / (max(churnSample$total_intl_charge) - min(churnSample$total_intl_charge))
# get the range of x1 and x2
rx1 <- range(churnSample$account_length)
rx2 <- range(churnSample$total_intl_charge)
# get lattice points in predictor space
px1 <- seq(from = rx1[1], to = rx1[2], by = 0.015 )
px2 <- seq(from = rx2[1], to = rx2[2], by = 0.015 )
xnew <- expand.grid(x1 = px1, x2 = px2)

# get the contour map
k=5
knnK <- knn(train = churnSample[,1:2], test = xnew, cl = churnSample$churn, k = k, prob = TRUE)
prob <- attr(knnK, "prob")
prob <- ifelse(knnK=="1", prob, 1-prob)
probK <- matrix(prob, nrow = length(px1), ncol = length(px2))

# Figure 2.2
#par(mar = rep(2,4))
contour(px1, px2, probK, levels=0.5, labels="", xlab="account_length", ylab="total_intl_charge", axes=FALSE)
points(churnSample[,1:2], col=ifelse(churnSample[,3]==1, "#F8766D", "#00BFC4"),
       pch=ifelse(churnSample[,3]==1, 19, 17))
points(xnew, pch=".", cex=1.2, col=ifelse(probK>0.5, "#F8766D", "#00BFC4"),
       shape=ifelse(churnSample[,3]==1, "a", "b"))
title(xlab="account_length", ylab="total_intl_charge", main=paste0("k = ", k))
box()

k=1
knnK <- knn(train = churnSample[,1:2], test = xnew, cl = churnSample$churn, k = k, prob = TRUE)
prob <- attr(knnK, "prob")
prob <- ifelse(knnK=="1", prob, 1-prob)
probK <- matrix(prob, nrow = length(px1), ncol = length(px2))

# Figure 2.2
#par(mar = rep(2,4))
contour(px1, px2, probK, levels=0.5, labels="", xlab="account_length", ylab="total_intl_charge", axes=FALSE)
points(churnSample[,1:2], col=ifelse(churnSample[,3]==1, "#F8766D", "#00BFC4"),
       pch=ifelse(churnSample[,3]==1, 19, 17))
points(xnew, pch=".", cex=1.2, col=ifelse(probK>0.5, "#F8766D", "#00BFC4"),
       shape=ifelse(churnSample[,3]==1, "a", "b"))
title(xlab="account_length", ylab="total_intl_charge", main=paste0("k = ", k))
box()

k=20
knnK <- knn(train = churnSample[,1:2], test = xnew, cl = churnSample$churn, k = k, prob = TRUE)
prob <- attr(knnK, "prob")
prob <- ifelse(knnK=="1", prob, 1-prob)
probK <- matrix(prob, nrow = length(px1), ncol = length(px2))

# Figure 2.2
#par(mar = rep(2,4))
contour(px1, px2, probK, levels=0.5, labels="", xlab="account_length", ylab="total_intl_charge", axes=FALSE)
points(churnSample[,1:2], col=ifelse(churnSample[,3]==1, "#F8766D", "#00BFC4"),
       pch=ifelse(churnSample[,3]==1, 19, 17))
points(xnew, pch=".", cex=1.2, col=ifelse(probK>0.5, "#F8766D", "#00BFC4"),
       shape=ifelse(churnSample[,3]==1, "a", "b"))
title(xlab="account_length", ylab="total_intl_charge", main=paste0("k = ", k))
box()
