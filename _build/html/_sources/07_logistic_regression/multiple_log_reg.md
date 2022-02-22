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
deposit <- read_csv("../_build/data/marketing.csv")
```

# Multiple Logistic Regression

Much like linear regression, logistic regression can include multiple independent ($X$) variables. When there is more than one $X$, we assume the following relationship:

$$P(Y = 1 | X) = \frac{e^{\beta_0+\beta_1X_1+\beta_2X_2+...+\beta_pX_p}}{1+e^{\beta_0+\beta_1X_1+\beta_2X_2+...+\beta_pX_p}}$$

Below we fit a multiple logistic regression using several of the independent variables in our data set:

```{code-cell}
depositLogMultiple <- glm(subscription ~ duration + campaign + loan + marital, 
                          data = deposit, family = "binomial")
summary(depositLogMultiple)
```

We interpret these estimated coefficients as follows:

+ On average, a one-unit increase in `duration` corresponds to an *increase* in the probability that the contacted person makes a deposit, assuming all other variables in the model are kept constant.
+ On average, a one-unit increase in `campaign` corresponds to a *decrease* in the probability that the contacted person makes a deposit, assuming all other variables in the model are kept constant.
+ On average, contacted persons with a personal loan are *less* likely to make a deposit than contacted persons without a personal loan, assuming all other variables in the model are kept constant.
+ On average, contacted persons who are married are *less* likely to make a deposit than contacted persons who are divorced, assuming all other variables in the model are kept constant. Note that `marital` can take on three possible values (`divorced`, `married`, and `single`), so `divorced` is our baseline because the model created explicit dummies for the other two categories (`maritalmarried` and `maritalsingle`).
+ On average, contacted persons who are single are *less* likely to make a deposit than contacted persons who are divorced, assuming all other variables in the model are kept constant. However, the p-value on this coefficient is quite large, so we cannot conclude that this difference is statistically significant.
