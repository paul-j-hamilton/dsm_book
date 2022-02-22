# Logistic Regression

The linear regression model described in a previous section allows one to model a *continuous* dependent variable as a function of one or more independent variables. However, what if we would instead like to model a categorical outcome (*i.e.* we are working on a classification problem)? **Logistic regression** (or the **logit model**) was developed by statistician David Cox in 1958 and is a model where the response variable $Y$ is categorical. Logistic regression allows us to estimate the probability of a categorical response based on one or more predictor variables ($X$). In this section we will cover the case when $Y$ is binary — that is, where it can take only two values, `0` and `1`, which represent outcomes such as pass/fail, win/lose, alive/dead, healthy/sick, etc. 

Cases where the dependent variable has more than two outcome categories may be analyzed with **multinomial logistic regression**, or, if the multiple categories are ordered, **ordinal logistic regression**. We will not cover these methods here.