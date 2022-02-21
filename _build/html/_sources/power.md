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

# Power

After completing the steps in the previous section, businesses face an additional decision: how much data to collect in their experiment. Of course, more data is always better, but there are usually economic limitations that prevent one from collecting an arbitrarily large sample. Therefore, we face a trade-off: large samples may be prohibitively expensive, but if our sample is too small we may not have enough “power” to detect a significant difference between our treatment and control groups. That is, we may not have enough data to reject the null when there truly is a difference between the two groups. **Power analysis** allows us to calculate the minimum sample size required to detect a difference, given that one really exists.

Using the language of hypothesis testing from Section \@ref(hypothesis-testing), Musicfi plans to test the following hypotheses, where $\mu_0$ is the mean of the control group and $\mu_1$ is the mean of the treatment group:

+ $H_o: \mu_0 = \mu_1$

+ $H_a: \mu_0 \ne \mu_1$

Imagine that the alternative hypothesis ($H_a$) is true, *i.e.*, the mean streaming minutes is different for customers in the control and treatment groups. Even under this scenario, there is no guarantee that our analysis will detect the difference because we have a **sample** of customers (fortunately a random sample) and not the population of all possible customers. The question then becomes: **what is the smallest sample we can collect that will still provide a reasonable chance of detecting a difference *if one exists*?**

To tackle this question, think through the following scenarios. What do you think would require more data: 

  (a) Detecting a difference in streaming time between free and premium users when the true average difference is five minutes, or 
  (b) Detecting a difference when the true average difference is only two minutes? 
  
Intuitively, the larger the true difference, the more likely that difference will manifest itself in our random sample. Therefore, we need would need more data in scenario (b) to pick up on the difference than we would in scenario (a). 

Let's imagine that based on the business context, Musicfi does not care if the difference between free and premium users is less than two minutes; in other words, if the true difference is two minutes or less, Musicfi would consider that difference negligible. Therefore, they want to determine the smallest possible sample size that still has a good chance of detecting a difference of two minutes or greater. Note this implies that if the true difference is *less* than two minutes, the experiment will likely *not* pick up on that difference. Determining the minimum detectable difference is an important step in a power analysis, and one that requires input from managers who have business area expertise. 

To conduct a power analysis, we need several pieces of information:

1. The **significance level** of the test ($\alpha$). As before, we will use a significance level of 0.05.

2. The **power of the test** ($1-\beta$). This is the probability that our test will detect the difference *given that there is a difference in the population*. A common choice for $1-\beta$ is 0.8. Note that this implies there is still a $\beta$ = 20% chance our test will *not* detect the difference when a difference actually exists.

3. The **treatment effect**, defined as the difference between the two groups ($\mu_1 - \mu_o$). Of course, we don't know the true population treatment effect — this is the quantity we are trying to estimate from the experiment. However, to determine how big our sample size should be, we need a plausible guess of the smallest effect that we would want to detect in our study. Typically, the estimate is based on historical data; we usually shrink the estimate closer to zero because our data is likely subject to unobserved confounding. 

4. The **pooled standard deviation** of the two groups, usually estimated from historical data. 

We then combine 3 and 4 to compute the normalized difference in means $d$ (know as the effect size, or Cohen's $d$) by dividing our estimate of the treatment effect by the pooled standard deviation. 

For example, with the Musicfi data we want to observe a minimum difference of two minutes, so we would calculate $d$ as:

$$d = \frac{\mu_1 - \mu_0}{s} = \frac{2}{s}$$

The quantity $s$ is the pooled standard deviation of the two groups, and is calculated from the standard deviations of the control group and the treatment group ($s_o$ and $s_1$ respectively) using the formula below. These quantities typically need to be estimated from historical data; in our case, we can use the data from Musicfi's previous experiment, which is stored in `musicfiExp`. 

$$s = \sqrt{\frac{s_1^2 + s_0^2}{2}}$$


After determining the three inputs using our historical data, we use the `pwr.t.test()` function from R's `pwr` package to calculate the required sample size. 

```{admonition} Syntax
pwr::pwr.t.test(d, power, sig.level=0.05)
+ *Required arguments*
  - `d`: The effect size, *i.e.*, Cohen's $d$.
  - `power`: The power of the test ($1-\beta$).
+ *Optional arguments*
  - `conf.level`: The significance level of the test.
```

Let's say we want to design a new experiment that will have an 80% chance of detecting a difference of two minutes or greater at a 5% significance level. We can use the `pwr.t.test()` function to calculate the minimum sample size we will need for this experiment. 

First, we need to calculate $s$ based on our historical data:

```{code-cell}
# Create separate data frames for free and premium users
musicfiExpFree = subset(musicfiExp, AccountType=="Free")
musicfiExpPremium = subset(musicfiExp, AccountType=="Premium")

# Calculate the sample standard deviation of streaming minutes for free and premium users
s0 = sd(musicfiExpFree$StreamingMinutes)
s1 = sd(musicfiExpPremium$StreamingMinutes)

# Calculate the estimate of the pooled standard deviation
s = sqrt((s0^2 + s1^2)/2)
```

Now we can use `s` to calculate Cohen's $d$:

```{code-cell}
d = 2/s
```

Finally, we can apply the `pwr.t.test()` function to determine our sample size:

```{code-cell}
pwr.t.test(d=d, power=0.8)
```

These results indicate that (rounding up) we need at least 128 participants in the control and treatment groups, for a total sample size of 256.

