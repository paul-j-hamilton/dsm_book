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
employees <- read_csv("../_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
degreeLevels <- c("High School", "Associate's", "Bachelor's", "Master's", "Ph.D")
employees$Degree <- parse_factor(employees$Degree, levels = degreeLevels, ordered = TRUE)
```

# Confidence Intervals

As described in the previous section, we often want to use sample data to estimate population quantities. Due to the randomness inherent to sampling, an observed sample statistic is almost certainly not equal to the true population parameter. To quantify the variability surrounding the sample statistic, we can compute a **confidence interval** which provides a lower and upper bound for where we think the true population value lies. Note that unless we take a sample which consists of the entire population (often called a census), we will never know the true population parameter with absolute certainty.

## Confidence Intervals for Proportions

Suppose that in a survey of one hundred adult cell phone users, 30% switched carriers in the past two years. Based on this sample statistic (which we denote $\hat{p}$), what can we conclude about the proportion of all adult cell phone users who switched carriers (which we denote $p$)? Our sample estimate of $\hat{p} = 30%$ is based on a random sample of one hundred users and not the entire population, so we cannot conclude that the true population parameter is $p = 30%$. Instead, we must calculate a confidence interval to understand the range of plausible values for the population proportion $p$.

For proportions, we generally use the following formula to calculate a confidence interval from our sample estimate:

$$ \hat{p} \pm z^\ast \sqrt{\frac{\hat{p}(1 - \hat{p})}{n}} $$

where $\hat{p}$ is our estimate from the sample, $n$ is the number of observations in the sample, and $z^\ast$ is a constant that determines our desired level of confidence in the interval (we typically use a value of 1.96, which corresponds to a 95% level of confidence). 

Now imagine we wanted to construct a 95% confidence interval based on our sample of one hundred cell phone users. Applying the above formula:

$$
\begin{aligned}
\hat{p} \pm z^\ast \sqrt{\frac{\hat{p}(1 - \hat{p})}{n}} &= 0.30\ \pm\ 1.96\sqrt{\frac{0.30\left(0.70\right)}{100}} \\
&=\ [0.2124,\ 0.3998] 
\end{aligned}
$$

We interpret this confidence interval as follows: "we are 95% confident that the true population proportion of adult cell phone users who switched carriers in the past two years is between 21.24% and 39.98%." 

Note that we can adjust our desired level of confidence by changing the value of $z^\ast$. For example, imagine we only desired 80% confidence in our interval estimate. In this case, we would apply the same formula but use a $z^\ast$ value of 1.28.

$$
\begin{aligned}
hat{p} \pm z^{\ast}\sqrt{\frac{\hat{p}\left(1-\hat{p}\right)}{n}}\ &= 0.30\ \pm\ 1.28\sqrt{\frac{0.30\left(0.70\right)}{100}} \\
&=\ [0.2398,\ 0.3664]
\end{aligned}
$$

We interpret this confidence interval as follows: "we are 80% confident that the true population proportion of adult cell phone users who switched carriers in the past two years is between 23.98% and 36.64%." In this case, relative to the 95% confidence interval we are slightly less confident that the interval contains the true population proportion, but the interval is narrower. This implies that as we decrease our level of confidence, our interval becomes more precise (and vice versa). The table below shows the appropriate value of $z^{\ast}$ for several common confidence levels. 

| Confidence Level | $z^{\ast}$ |
| :-: | :-: |
| 80\% | 1.28 |
| 90\% | 1.645 |
| 95\% | 1.96 |
| 98\% | 2.33 |
| 99\% | 2.58 |

In R, we can calculate a confidence interval for proportions with the `binom.test()` command, which uses the following syntax:

```{admonition} Syntax
`binom.test(x, n, conf.level = 0.95)`
+ *Required arguments*
  + `x`: The number of “successes” in the sample.
  + `n`: The sample size.
+ *Optional arguments*
  + `conf.level`: The confidence level of the interval.
```

Applying this to our sample of cell phone users, we can run `binom.test()` with `x` equal to thirty and `n` equal to one hundred:

```{code-cell}
binom.test(30, 100)
```

For now, all we care about in this output is the line that reads `95 percent confidence interval:`. We interpret this output as follows: we are 95% confident that the true population proportion of adult cell phone users who switched carriers in the past two years is between 21.24% and 39.98%.

## Confidence Intervals for Means

Now suppose that in our sample of one hundred adult cell phone users, we also asked them to rate their satisfaction with their most recent service provider on a continuous scale from one to ten. In this sample, the average rating was 6.72 with a standard deviation of 1.72. Based on this sample statistic (which we denote $\bar{x}$), what can we conclude about the average level of satisfaction among the entire population of adult cell phone users (which we denote $\mu$)? Our sample estimate of $\bar{x} = 6.72$ is based on a random sample of one hundred users and not the entire population, so we cannot conclude that the true population parameter is $\mu = 6.72$. Instead, we must calculate a confidence interval to understand the range of plausible values for the population mean $\mu$.

When working with means, we use a different formula to calculate the confidence interval:

$$ \bar{x} \pm t^{\ast}\frac{s}{\sqrt n},\ \ \ \ \ \ \ \ df\ =\ n\ -\ 1 $$

where $\bar{x}$ is our estimate from the sample, $n$ is the number of observations in the sample, $s$ is the standard deviation from the sample, $df$ is the degrees of freedom (described below), and $t^{\ast}$ is a constant that determines our desired level of confidence in the interval.

The standard deviation from the sample ($s$) is calculated using the following formula:

$$ s\ =\ \sqrt{\frac{\sum{(x_i\ -\ \bar{x})}^2}{n\ -\ 1}} $$

Unlike the z^\ast from the previous section, the value $t^\ast$ depends on both our desired level of confidence and something called the **degrees of freedom** of the test. In the case of confidence intervals for means, the degrees of freedom is simply the sample size ($n$) minus one. To determine the appropriate value of $t^{\ast}$ for our 95% confidence interval, we therefore need to look up the value of $t^{\ast}$ that corresponds to a confidence level of 0.95 with 99 degrees of freedom. This can be done by searching the web for a calculator that returns the appropriate value of $t^{\ast}$ based on our degrees of freedom and confidence level; in this case, the value is approximately 1.98. Note that in practice, one would often use statistical software (such as the R or Python programming languages, SPSS, Excel, etc.) to calculate confidence intervals instead of calculating them by hand. These packages determine the appropriate value of $t^{\ast}$ for you behind the scenes, so you will rarely need to look it up yourself. 

Now let’s apply the above formulas to calculate a 95% confidence interval (note there may be some error due to rounding):

$$
\begin{aligned}
\bar{x}\ \pm\ t^{\ast}\frac{s}{\sqrt n}\ &=\ 6.72\ \pm\ 1.98\frac{1.72}{\sqrt{100}} \\
&=\ [6.38,\ 7.06]
\end{aligned}
$$

We interpret this confidence interval as follows: "we are 95% confident that the true population average satisfaction among all adult cell phone users is between 6.38 and 7.06."

Recall that our `employees` data set has the salary of the sampled employees. Imagine that based on this sample, we would like to estimate the true average salary of all employees at the company. For means, we need to use the `t.test()` function to calculate the 95% confidence interval:

```{admonition} Syntax
`t.test(x, conf.level = 0.95)`
+ *Required arguments*
  + `x`: An atomic vector with the sample values.
+ *Optional arguments*
  + `conf.level`: The confidence level of the interval.
```

Applying this to our sample of employees:

```{code-cell}
t.test(employees$Salary)
```

As with the output for proportions, we can (for now) ignore everything besides the line that reads `95 percent confidence interval:`. We interpret this output as follows: we are 95% confident that the true population average salary at the company is between \$153,931.5 and \$159,040.5.

We could also calculate confidence intervals for specific subgroups. Let’s use the `employees` data to calculate the salary confidence intervals for men and women separately:

```{code-cell}
maleEmployees <- filter(employees, Gender=="Male")
t.test(maleEmployees$Salary)
```

```{code-cell}
femaleEmployees <- filter(employees, Gender=="Female")
t.test(femaleEmployees$Salary)
```

Note that the 95% confidence intervals do *not* overlap, which suggests that on average, women at the company are paid lower than men. To investigate this further, we need a formal method to compare groups statistically. This topic is covered in the next section.
