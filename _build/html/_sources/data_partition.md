---
jupytext:
  cell_metadata_filter: -all
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.11.5
kernelspec:
  display_name: R
  language: R
  name: ir
---

```{code-cell}
:tags: [remove-cell]
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
```

# Partitioning Data

## Train & Validation Sets

Let's return to the kNN model we applied to the `churn` data in the previous chapter. In order to traverse the bias-variance tradeoff, we need to **tune** the model hyperparameter $k$. If $k$ is too small we risk overfitting the data and picking up on the noise of the sample, while if $k$ is too large we risk underfitting the data and missing the signal. Consequently, we need to find the value of $k$ that maximizes the ability of the model to make accurate predictions on unseen data.

A typical approach to this problem is to split the data into a training set and a validation set. One rule of thumb is to devote 80% of the available data to the training set, and 20% to the validation set. The **training set** is used to build models with different values of our hyperparameter $k$. We start by defining a **grid** of different values for the hyperparameter that we want to test. In this case, our grid will be $k = {1, 3, 5, 10, 20}$. We then use the training set to build five different models, each with a different value of $k$.

Next, we apply all five of those models to the **validation set**, which is used to compare the accuracy of different models. Whichever value of $k$ results in the most accurate predictions on the validation set is taken to be the optimal value.

Note that instead of using a validation set, we could just calculate the accuracy of each model on the training data. In other words, we could build a model on the training set, then calculate the accuracy of that model on the same data it was trained on. The reason one should never do this is that it will almost certainly result in overfitting. On the training set, the most accurate model is the one where $k$ equals one, as this model very closely fits the training data. However, this model will not generalize well to unseen data. Therefore, we need the validation set to ensure that our model is not overfitting the training data, and that it will generalize well to new data.

We can split our processed data set (`churnScaled`) into training and validation sets using the `sample.split()` function from the `caTools` package. One advantage of using `sample.split()` is that it ensures that the training and validation sets have the same proportions of the target feature, in our case `churn`.

Note that we are *randomly* dividing the data, meaning that each observation should have a chance of being included in the training set and a chance of being included in the validation set. We want this sampling process to be random, but we also want to ensure that every time the code is run, the same observations are sorted into the training set and the same observations are sorted into the validation set. This will guarantee that every time the code is re-run, we have the exact same training and validation sets. If we did not do this, two different runs of the code would almost certainly have a different set of observations in the training set, so the results would be different each time. 

We can ensure that a random process is stable (*i.e.*, leads to the same result) by setting the random seed with `set.seed()`. The number you pass into this function "seeds" the randomization that R uses to split the data, so two people using the same random seed will have identical splits of the data. In the code below we use a random seed of `972941`, a number which was itself randomly chosen.

After setting the random seed we then apply `sample.split()`, which uses the following syntax:

```{admonition} Syntax
`caTools::sample.split(Y, SplitRatio = 2/3)`
+ *Required arguments*
  - `Y`: An atomic vector with the values of the target feature in the data set. 
+ *Optional arguments*
  - `SplitRatio`: The proportion of observations to use for the training set. The remaining observations are used for the validation set.
```

We save the output of `sample.split()` into `sample`, a vector with either `TRUE` or `FALSE` for each observation in our data set. An element of `sample` is set equal to `TRUE` if the observation is assigned to the training set and `FALSE` if the observation is assigned to the validation set. We can then create the two separate data sets `train` and `validate` using the `subset()` function. Note that we will place 80% of the data into the training set and 20% into the validation set. 

```{code-cell}
# Set the random seed
set.seed(972943)

# Define the training and validation sets
library(caTools)
sample <- sample.split(churnScaled$churn, SplitRatio = 0.8)

# Split the data into two data frames
train <- subset(churnScaled, sample == TRUE)
validate <- subset(churnScaled, sample == FALSE)
```

If we view the dimensions of `train` and `validate`, we can see that `train` contains 80% of the observations and `validate` contains 20%.

```{code-cell}
dim(train)
dim(validate)
```

Now we can use `train` to build five different models, each with a different value of $k$. We can then calculate the accuracy of those models on `validate` to determine the optimal value of $k$. In the code below, we fit all five of these models using the `knn()` function. Note that we set the `test` parameter equal to `validate` so that the models are applied to the validation set. 

```{code-cell}
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
```

To determine the performance of each model on the validation set, we need to compare the model's predictions against the known, true values. Here we will score the models using **accuracy**, or the proportion of observations where the model's prediction was correct. In Section [Performance Metrics](performance_metrics.html#performance-metrics), we will learn about other metrics that can be used to assess model performance. 

We can easily calculate the accuracy of our models on the validation set using the `Accuracy()` function from the `MLmetrics` package, which uses the following syntax:

```{admonition} Syntax
`MLmetrics::Accuracy(y_pred, y_true)`
+ *Required arguments*
  - `y_pred`: An atomic vector with the model predictions. 
  - `y_true`: An atomic vector with the true labels. 
```
  
The model objects that we created (*e.g.*, `knnModelK1`) store a vector of the model's predictions on the validation set. For example, if we display the first few elements of `knnModelK1`, we see the model's prediction for the first few observations in `validate`. In this case, the model predicted that four of the five observations will not churn. 

```{code-cell}
knnModelK1[1:5]
```

To use `Accuracy()`, we pass in our vector of model predictions as `y_pred` and the true values (stored in the column `validate$churn`) as `y_true`:

```{code-cell}
Accuracy(knnModelK1, validate$churn)
```

This means that the model where $k$ was one correctly predicted 85.44% of the observations in the validation set. Now let's apply this to the other models:

```{code-cell}
Accuracy(knnModelK3, validate$churn)
Accuracy(knnModelK5, validate$churn)
Accuracy(knnModelK10, validate$churn)
Accuracy(knnModelK20, validate$churn)
```

Based on these results, we can conclude that the best value for $k$ is somewhere around three to five. We will use a $k$ of three because it tied for the highest accuracy on the validation set.

Now that we have chosen a value for $k$, we would fit a final model with $k$ equals three using all of the available data (*i.e.*, the combined training and validation sets, which is stored in `churnScaled`). This is the model we would deploy to predict which customers will churn in the upcoming quarter. 

## $k$-Fold Cross Validation

Although we can help prevent overfitting by dividing our data into train and validation sets, this method is not without its shortcomings. It requires that we sacrifice a significant portion of our data (usually around 20%) for model validation, so we can only build our models on 80% of the data. We always want to build our models with as much data as possible, and this becomes especially problematic when working with smaller data sets.

An alternative method for training and validating different models is called **$k$-fold cross validation**. Note that this $k$ is unrelated to the hyperparameter $k$ from the kNN algorithm; to distinguish between them, moving forward we will use $k_{fold}$ when discussing cross validation, and $k_{knn}$ when discussing the kNN algorithm. Cross validation randomly divides our data set into $k_{fold}$ partitions (called folds). It then builds a model on all but one of these folds, and uses the held-out fold to validate that model's predictive ability. It then repeats this procedure $k_{fold}$ times, each time holding out a different one of the $k_{fold}$ folds.  

For example, we would apply the following steps if we chose a $k_{fold}$ of five:

1. Randomly divide the data set into five equally-sized folds.
2. Treat the fifth fold as the validation set and train the model on the first four folds.
3. Evaluate the model's performance error on the fifth fold.
4. Repeat Steps 2 and 3 four more times, but each time treat a different fold as the validation set. 
5. Calculate the model error for five-fold cross-validation by averaging the five error estimates from Step 3.

This process is shown in the visualization below:

```{figure} ../images/kfold.png
---
height: 300px
---
```

<br>

Imagine that we applied this process with the kNN algorithm and a $k_{knn}$ of three. We would first divide our data into five folds, and train the kNN model on the first four folds using a $k_{knn}$ of three. Then, we would calculate the accuracy of that model on the fifth fold. Next, we would train another kNN model (again using a $k_{knn}$ of three) on folds one, two, three, and five, then calculate the accuracy of that model on the fourth fold. We would repeat this process five times, each time using a different one of the folds for validation. This would provide us with five separate estimates of the model's accuracy, which we could average together for a final accuracy score.

Just as we tried several different values of $k_{knn}$ in the previous section, we can perform cross validation with a grid of different values for our hyperparameter. Whichever value attains the best average accuracy score can be chosen as our final value of $k_{knn}$.

The `caret` package in R provides a framework for building and validating models with cross validation. The first step is to set up the conditions of the cross validation process with the `trainControl()` function, which uses the following syntax:

```{admonition} Syntax
`caret::trainControl(method, number)`
+ *Required arguments*
  - `method`: The method used to divide the data; there are many different approaches, but we will set it to "cv" for **c**ross **v**alidation.
  - `number`: The number of folds (*i.e.*, $k_{fold}$).
```

```{code-cell}
cvConditions <- trainControl(method = "cv", number = 5)
```

What is this object for? We always want to build and compare multiple models under the same conditions. If we were evaluating two kNN models, one with a $k_{knn}$ of three and another with a $k_{knn}$ of ten, we would want to ensure that the models were trained and evaluated on the same set of observations so that they are directly comparable. The `cvConditions` object defines these conditions so that we are always consistent when training different models.

We will next use the `cvConditions` object with the `train()` function from `caret`, which actually performs the cross validation. This function uses the following syntax:

```{admonition} Syntax
`caret::train(y ~ x1 + x2 + … + xp, data, method = "rf" , trControl = trainControl(), tuneGrid = NULL)`
+ *Required arguments*
  - `y`: The name of the dependent ($Y$) feature.
  - `x1`, `x2`, ..., `xp`:  The name of the first, second, and $p_{th}$ independent feature. Note that if you just replace the names of the features with the wildcard character `.`, the model will be built using all of the features in the data set.
  - `data`: The name of the data frame with the `y`, `x1`, `x2`, and `xp` variables.
+ *Optional arguments*
  - `method`: The algorithm to apply. See [here](https://topepo.github.io/caret/available-models.html) for the complete list of available models. 
  - `trControl`: A list defining the conditions of the training procedure. 
  - `tuneGrid`: A data frame with different values of the hyperparameter(s) to test.               
```
  
In the code below, we apply this function to the `churn` data set. Within `train()`, we define the model with `churn` as the independent ($Y$) feature, and all the remaining features in the data set as dependent ($X$) features. Because we are using the kNN algorithm, we set `method` equal to `"knn"` (from the list [here](https://topepo.github.io/caret/available-models.html)). We set `trControl` equal to the `cvConditions` object we created above to control how the cross validation is performed. Finally, we define a grid of different values for $k_{knn}$ and pass that in to `tuneGrid`. Note that we set the random seed so that the process is replicable. 

```{code-cell}
set.seed(972945)
knnCV <- train(churn ~ ., 
                 data = churnScaled,
                 method = "knn", 
                 trControl = cvConditions, 
                 tuneGrid = expand.grid(k = c(1, 3, 5, 10, 20)))

knnCV
```

How do we interpret this? In the output we see a small table with the following results:

|k|Accuracy|Kappa|
|:-:|:-:|:-:|
| 1 | 0.8552832 | 0.3708154 |
| 3 | 0.8844082 | 0.4207154 |
| 5 | 0.8841206 | 0.3858950 |
| 10 | 0.8820605 | 0.3480523 |
| 20 | 0.8764739 | 0.2582296 |

For each value of $k_{knn}$, the function performed five-fold cross validation, the results of which are shown in this table. For example, for a $k_{knn}$ of one, `train()` built five different models on different folds of the data, and evaluated each one on the held-out fold. It then averaged those five accuracy estimates together for a final accuracy score of 85.53% (we will ignore kappa). As we can see from the table, `train()` determined that three is the optimal value of $k_{knn}$. 

## Holdout Sets

Finally, in addition to the train and validation sets, we always reserve a portion of our data as a **holdout set**. The purpose of the holdout set is to provide a final estimate of our model's predictive accuracy on unseen data. 

After we use the train and validation sets (or cross validation) to build and compare different models, we decide on a final model. We know how this model performs on the validation set, but this still does not provide an unbiased estimate for how our model will perform on unseen data. The reason for this is that although the model may not be directly trained on the observations in the validation set, the validation set was still used to tune the model's hyperparameters. This means that the validation set had some influence on how the model was built. Consequently, it cannot provide a completely unbiased estimate for how the model will perform on observations it has never seen before. For this, we need to evaluate our final model on the holdout set. 

It is important to emphasize that the holdout set should *never* influence the model building process. If you use the holdout set to make decisions about your model (which algorithm to use, the values of any hyperparameter(s), etc.), the holdout set can no longer provide an unbiased estimate of your model's performance. Therefore, you should only look at the holdout set after you have decided on a final model.

For the churn data, we have held out a portion of the observations for the holdout set. These observations are saved in a data frame called `churnHoldout`; the first few observations are shown below. 

```{code-cell}
:tags: [remove-input]
churnHoldout <- read_csv("_build/data/churn_holdout.csv")
head(churnHoldout)
```
<br>

To stay consistent, we need to (1) normalize the holdout data using the scaler we created in Section [Applying kNN in R](knn.html#applying-knn-in-r), and (2) convert the categorical variables into dummies.

```{code-cell}
# Apply min-max scaling to the holdout set
churnHoldoutScaled <- predict(scaler, churnHoldout)

# Convert categorical variables in the holdout set to dummy variables
churnHoldoutScaled$international_plan <- ifelse(churnHoldoutScaled$international_plan=="yes", 1, 0)
churnHoldoutScaled$voice_mail_plan <- ifelse(churnHoldoutScaled$voice_mail_plan=="yes", 1, 0)
```

```{code-cell}
:tags: [remove-input]
head(churnHoldoutScaled)
```
<br>

Now we can use our final model to make predictions on the holdout set. Note that the object we created with the `train()` function, `knnCV`, automatically identifies the optimal hyperparameters and trains a final model on all of the data. We can view the details of this final model with `$finalModel`, as follows:

```{code-cell}
knnCV$finalModel
```

Because the optimal $k_{knn}$ according to our cross validation was three, the final model is a `3-nearest neighbor model`. 

Now we can use our final model to make predictions on the holdout set. We can do this using the same `predict()` function we used with linear regression. To do this we simply pass in our model object (`knnCV`) and the data we want to make predictions on (`churnHoldoutScaled`). The result is an atomic vector with the final model's predictions on the holdout set. The predictions on the first few observations are shown in the output below. 

```{code-cell}
finalModelPredictions <- predict(knnCV, churnHoldoutScaled)
finalModelPredictions[1:5]
```

Finally, we can calculate the accuracy of our final model on the holdout set using the `Accuracy()` function:

```{code-cell}
Accuracy(finalModelPredictions, churnHoldoutScaled$churn)
```

This final accuracy measure provides an estimate for how well our model will perform on future observations. 