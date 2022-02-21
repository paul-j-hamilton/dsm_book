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
library(tidyverse)
library(ggplot2)
deposit <- read_csv("_build/data/marketing.csv")
```

# Why Not Linear Regression?

At this point, a natural question might be why one cannot use linear regression to model categorical outcomes. To understand why, let's look at an example. We have a data set related to a telephone marketing campaign of a Portuguese banking institution. Suppose we would like to model the likelihood that a phone call recipient will make a term deposit at the bank. The data is saved in a data frame called `deposit`, and the first few observations are shown below:

```{code-cell}
head(deposit)
```

These variables are defined as follows:

+ `age`: The age of the person contacted.
+ `marital`: The marital status of the person contacted. 
+ `education`: The education level of the person contacted. 
+ `default`: Whether the person contacted has credit in default.
+ `housing`: Whether the person contacted has a housing loan.
+ `loan`: Whether the person contacted has a personal loan.
+ `contact`: How the person was contacted (`cellular` or `telephone`).
+ `duration`: The duration of the contact, in seconds.
+ `campaign`: The number of contacts performed during this campaign for this client.
+ `previous`: The number of contacts performed before this campaign for this client.
+ `poutcome`: The outcome of the previous marketing campaign (`failure`, `nonexistent`, or `success`).
+ `subscription`: Whether the person contacted made a term deposit (`1` if the person made a deposit and `0` if not).

Let's try using linear regression to model `subscription` as a function of `duration`: 

```{code-cell}
depositLinear <- lm(subscription ~ duration, data = deposit)
summary(depositLinear)
```

Based on this output, our estimated regression equation is:

$$predicted \;subscription = \hat{y} = -0.01488 + 0.0004930(duration)$$

If we plot this line on top of our data, we can start to see the problem:

```{code-cell}
:tags: [remove-input]
suppressWarnings(print(ggplot(deposit, aes(x=duration, y=subscription)) + geom_point()  +
  geom_smooth(method='lm', se=F,size=2) + theme_bw() +
  xlim(-500, 3000) + ylim(-0.2, 1.2) +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"))))
```

Our independent variable `subscription` can only take on two possible values, `0` and `1`. However, the line we fit is not bounded between zero and one. If `duration` equals 2,500 seconds, for example, the model would predict a value greater than one:

$$\begin{aligned}predicted \;subscription = \hat{y} & \approx -0.01488 + 0.0004930(2500) \\ & \approx -0.01488 + 1.2325 \\ & \approx 1.2176\end{aligned}$$

A negative value of `duration` does not make sense in this context, but in principle the same problem applies in the opposite direction - for small values of $X$, the linear model might predict outcomes less than zero. To overcome this issue, logistic regression models the dependent variable $Y$ according to the logistic function, which is bounded between zero and one.
