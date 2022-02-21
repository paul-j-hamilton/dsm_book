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
install.packages(c("pwr", "purrr"))
library(pwr)
library(purrr)

inv.logit <- function(x) {
    1 / (1 + exp(-x))
}

data_causal_inf <- function(n, tau = 1, b = 2, base = 100) {
    ## DGP
    age <- rnbinom(n, 10, 0.3)
    ps <- inv.logit(0.2*(age- mean(age)))
    Y0s <- round(base + b * age + rnorm(n, 0, 3))
    Y1s <- round(Y0s + tau)
    Z <- map_dbl(ps, ~ sample(c(0,1), 1, F, c(1-., .)))
    Y <- Z * Y1s + (1-Z) * Y0s
    return(list(age = age, Y = Y, Z = Z, ps = ps))
}

data_causal_inf_rand_exp <- function(n, tau = 1, b = 2, base = 100) {
    ## DGP
    age <- rnbinom(n, 10, 0.3)
    ps <- inv.logit(0.2*(age- mean(age)))
    Y0s <- round(base + b * age + rnorm(n, 0, 3))
    Y1s <- round(Y0s + tau)
    Z <- rbinom(n, 1, 0.5)
    Y <- Z * Y1s + (1-Z) * Y0s
    return(list(age = age, Y = Y, Z = Z, ps = ps))
}

set.seed(7)
n <- 500

causal_int_obs <- data_causal_inf(n, tau = 0.9123, b = - 1.0314)

Age <- causal_int_obs$age; StreamingMinutes <- causal_int_obs$Y; AccountType <- ifelse(causal_int_obs$Z, "Premium", "Free")
musicfi <- data.frame(Age, AccountType, StreamingMinutes)

causal_int_obsrand <- data_causal_inf_rand_exp(n=500, tau = 0.9123, b = - 0.5314)

Age <- causal_int_obsrand$age; StreamingMinutes <- causal_int_obsrand$Y; AccountType <- ifelse(causal_int_obsrand$Z, "Premium", "Free")
musicfiExp <- data.frame(Age, AccountType, StreamingMinutes)
```

# Observational Studies

The vast majority of statistics courses begin and end with the premise that correlation is not causation. But they rarely explain why we can not directly assume that correlation is not causation.

Let’s consider a simple example. Imagine you are working as a data scientist for Musicfi, a firm that offers on-demand music streaming services. To keep things simple, let’s assume the firm has two account types: a free account and a premium account. Musicfi’s main measure of customer engagement is the total streaming minutes that measure how many minutes each customer spent on the service per day. As a data scientist, you want to understand your customers, so you decide to perform a simple analysis that compares the total streaming minutes across the two account types. To put this in causal terms:

+ Our treatment is having a premium account
+ Our control is having a free account
+ Our outcome is total streaming minutes

Suppose we have a random sample of 500 customers, stored in a data frame called `musicfi`:

```{code-cell}
head(musicfi)
```

First, let's create a side-by-side boxplot that compares the `StreamingMinutes` of free and premium customers:

```{code-cell}
boxplot(musicfi$StreamingMinutes ~ musicfi$AccountType, 
        ylab = "Streaming Minutes", xlab = "Treatment")
```

From the figure, we can see that the customers with premium accounts had lower total streaming minutes than customers with free accounts! The average in the premium group was 71 minutes compared to 80 minutes in the free group, meaning that (on average) customers with a premium account listened to less music! We can use a t-test to check if this observed difference is statistically significant:


```{code-cell}
t.test(musicfi$StreamingMinutes ~ musicfi$AccountType)
```

Suppose we take the above results at face value. In that case, we might incorrectly conclude that having a premium account reduces customer engagement. But this seems unlikely! Our general understanding suggests that buying a premium account should have the opposite effect. So what's going on? Well, we are likely falling victim to what is often called **selection bias**. Selection bias occurs when the treatment group is systematically different from the control group before the treatment has occurred, making it hard to disentangle differences due to the treatment from those due to the systematic difference between the two groups.

Mathematically, we can model selection bias as a third variable---often called a confounding variable---associated with both a unit's propensity to receive the treatment and that unit's outcome. In our Musicfi example, this variable could be the age of the customer: younger customers tend to listen to more music and are less likely to purchase a premium account. Therefore, the age variable is a confounding variable as it limits our ability to draw causal inferences.

To see this, we can compare how age is related to total streaming minutes and the account type. First, let's create a scatter plot of age and streaming minutes:

```{code-cell}
plot(musicfi$Age, musicfi$StreamingMinutes)
```

If we wanted to adjust for the age variable (assuming it is observed), we could run a linear regression with both `AccountType` and `Age` as independent variables:

```{code-cell}
summary(lm(StreamingMinutes ~ AccountType + Age, data=musicfi))
```

From this output, we see that the coefficient on `AccountType` is positive! This means that after controlling for age, premium users actually listen to *more* music, on average. Including `Age` in the regression removes its confounding effect on the relationship between `AccountType` and `StreamingMinutes`. 

However, even after controlling for age, can we be confident in interpreting this as a causal outcome? The answer is still most likely no. That is because there may exist more confounding variables that are not a part of our data set; these are known as **unobserved confounders**. Even if there were no unobserved confounders, there are much more robust methods for analyzing observational studies than linear regression.
