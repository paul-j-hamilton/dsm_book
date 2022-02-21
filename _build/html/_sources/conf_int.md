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
employees <- read_csv("_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
degreeLevels <- c("High School", "Associate's", "Bachelor's", "Master's", "Ph.D")
employees$Degree <- parse_factor(employees$Degree, levels = degreeLevels, ordered = TRUE)
```

# Confidence Intervals

As described in the previous section, we often want to use sample data to estimate population quantities. Due to the randomness inherent to sampling, an observed sample statistic is almost certainly not equal to the true population parameter. To quantify the variability surrounding the sample statistic, we can compute a **confidence interval** which provides a lower and upper bound for where we think the true population value lies. Note that unless we take a sample which consists of the entire population (often called a census), we will never know the true population parameter with absolute certainty.

## Confidence Intervals for Proportions

Suppose that in a survey of one hundred adult cell phone users, 30% switched carriers in the past two years. Based on this sample statistic, what can we conclude about the entire population of adult cell phone users? Our sample estimate of 30% is based on a random sample of one hundred users and not the entire population, so we cannot conclude that the true population parameter is 30%. Instead, we must calculate a confidence interval to understand the range of plausible values for the population proportion.

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

As with the output for proportions, we can (for now) ignore everything besides the line that reads `95 percent confidence interval:`. We interpret this output as follows: we are 95% confident that the true population average salary at the company is between $153,931.5 and $159,040.5.

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
