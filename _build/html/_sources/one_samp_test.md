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
carbs <- read.csv("_build/data/carbs.csv")
```

# One-Sample Hypothesis Testing (&#9909;)

This section is optional, and will not be covered in the DSM course. Select "Click to show" to reveal.

We use a one-sample hypothesis test when we want to compare a population parameter to a specified value. The following are all examples of scenarios where a one-sample hypothesis test would be appropriate:

+ An automobile manufacturer received a shipment of light bulbs from a supplier, and would like to verify that less than 2% of the bulbs are defective.
  + Is the true proportion ($p$) less than 0.02?
+ We would like to determine whether the majority of the electorate support the Democratic candidate for president.
  + Does the true proportion ($p$)  exceed 0.50?
+ A food processing plant received a truckload of chickens from a local farmer, and needs to verify that the average chicken weighs at least two pounds. 
  + Does the true mean ($\mu$)  exceed 2 lbs?
+ A software company wants to determine whether its users interact with the homepage for at least ten seconds, on average. 
  +  Does the true mean ($\mu$) exceed 10 seconds?
  
The first two examples concerned questions about population proportions ($p$), whereas the second two questions concern population means ($\mu$).

## Testing Means

To illustrate a one-sample test of means, let's return to our `employees` data set. Suppose that the HR department of the company is thinking about re-calibrating the employee performance scale, which is currently measured from one to ten. If the scale were calibrated properly the average score would be around five, but the team suspects there might be some "rating inflation" occurring. To investigate this, they would like to test whether the average employee `Rating` is greater than five. Under this scenario, the null and alternative hypotheses are:

+ $H_o$: The true average rating of all employees at the company is five.
  + $\mu = 5$
+ $H_a$: The true average rating of all employees at the company is *greater than* five.
  + $\mu > 5$
  
Recall that `employees` is a data frame with a random sample of 1,000 employees from the company. Using this sample data, we can apply `t.test()` to calculate the appropriate p-value for the hypothesis test:

:::{admonition} Syntax
`t.test(x, mu = 0, alternative = "two.sided")`
+ *Required arguments*
  - `x`: An atomic vector with the sample values.
+ *Optional arguments*
  - `mu`: The value of the population mean under the null hypothesis. By default, it is assumed that under the null, $\mu = 0$.
  - `alternative`: Whether one wants to conduct a two-sided, right-sided, or left-sided test. Under a right-sided test the alternative hypothesis states that the true population parameter is *greater than* the value specified in the null, so `alternative` should equal `"greater"` for a right-sided test. Following the same logic, `alternative` should equal `"less"` for a left-sided test.

Our null hypothesis states that $\mu$ equals five, so we set the `mu` parameter equal to five in the function call. Additionally, because our alternative hypothesis states that the population mean is *greater than* the value specified in the null, we are conducting a right-sided test and must set the `alternative` parameter equal to `"greater"`.

:::{code-cell}
t.test(employees$Rating, mu = 5, alternative = "greater")
:::

This p-value is quite small, so we reject the null hypothesis and conclude it is likely that the average employee rating at the company is greater than 5.

## Testing Proportions

To illustrate a one-sample test of proportions, let's focus on the second example from Section \@ref(one-sample-hypothesis-testing). Suppose we would like to determine whether the majority of the electorate supports the Democratic candidate for president. Our null and alternative hypotheses would then be:

+ $H_o$: The true population proportion of voters who support the Democratic candidate *equals* fifty percent.
  + $p = 0.5$
+ $H_a$: The true population proportion of voters who support the Democratic candidate *exceeds* fifty percent.
  + $p > 0.5$
  
Now imagine that we randomly polled 1,000 people, and 540 said that they supported the Democratic candidate. 

We can use `binom.test()` in R to calculate the appropriate p-value from this sample data:

```{admonition} Syntax
`binom.test(x, n, p = 0.5, alternative = "two.sided")`
+ *Required arguments*
  - `x`: The number of "successes" in the sample.
  - `n`: The total sample size.
+ *Optional arguments*
  - `p`: The value of the population proportion under the null hypothesis. By default, it is assumed that under the null, $p = 0.50$.
  - `alternative`: Whether one wants to conduct a two-sided, right-sided, or left-sided test. Under a right-sided test the alternative hypothesis states that the true population parameter is *greater than* the value specified in the null, so `alternative` should equal `"greater"` for a right-sided test. Following the same logic, `alternative` should equal `"less"` for a left-sided test.
```
  
Because our alternative hypothesis states that the population proportion is *greater than* the value specified in the null, we are conducting a right-sided test and must set the `alternative` parameter equal to `"greater"`.

```{code-cell}
binom.test(540, 1000, p = 0.5, alternative = "greater")
```

Of primary importance in this output is the p-value, which equals 0.006222. Recall that this does *not* mean there is a 0.62% chance that the null hypothesis is true. Instead, we interpret the p-value as follows: if the null were true and only half of the electorate supported the Democratic candidate, there would only be a 0.62% chance that our sample of 1,000 people would find 540 or more who support the Democratic candidate. In other words, the result we observed in the sample would be very unlikely if the null were in fact true. Therefore, we reject $H_o$ and conclude it is likely that the majority of the electorate prefer the Democratic candidate.
