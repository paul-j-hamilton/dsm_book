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
offices <- read.csv("../_build/data/office.csv")
employees <- inner_join(employees, offices, by="ID")
```

# Summarising Data

Now that we know how to use the pipe, we can use it to quickly and efficiently summarise data. To start we first need to introduce the `summarise()` function from the `tidyverse`, which we can use to summarise one or more columns in a data frame. This function uses the following syntax:

```{admonition} Syntax
`tidyverse::summarise(df, summaryStat1 = ..., summaryStat2 = ..., ...)`
+ *Required arguments*
  - `df`: The data frame with the data. 
  - `summaryStat1 = ...`: The summary statistic we would like to calculate.
+ *Optional arguments*
  - `summaryStat2 = ..., ...`: Any additional summary statistics we would like to calculate.
```

For example, we can use `summarise()` to calculate all of the following at once from `employees`:

+ The average of `Salary`
+ The standard deviation of `Salary`
+ The minimum `Age`
+ The maximum `Age`

```{code-cell}
summarise(employees,  meanSalary = mean(Salary, na.rm = TRUE),
                          sdSalary = sd(Salary, na.rm = TRUE),
                          minAge = min(Age),
                          maxAge = max(Age))
```

It is often useful to include the helper function `n()` within `summarise()`, which will calculate the number of observations in the data set. Note that this is similar to the `nrow()` function that we saw in the bootcamp, but `n()` only works within other `tidyverse` functions.

```{code-cell}
summarise(employees,  meanSalary = mean(Salary, na.rm = TRUE),
                          sdSalary = sd(Salary, na.rm = TRUE),
                          minAge = min(Age),
                          maxAge = max(Age),
                          nObs = n())
```

The `summarise()` function is useful for calculating summary statistics, but it becomes even more powerful when we combine it with `group_by()`. 

```{admonition} Syntax
`tidyverse::group_by()`
```

Imagine that we wanted to calculate separate summary statistics for each of the three offices (`New York`, `Boston`, and `Detroit`) separately, not across the entire data set. To accomplish this, we can use the pipe to pass the data through `group_by()` first, then pass it through `summarise()`. Any variable(s) we specify in `group_by()` will be used to separate the data into distinct groups, and `summarise()` will be applied to each one of those groups separately. For example:

```{code-cell}
employees %>%

  group_by(office) %>%

  summarise(meanSalary = mean(Salary, na.rm=TRUE),
            sdSalary = sd(Salary, na.rm=TRUE),
            minAge = min(Age),
            maxAge = max(Age),
            nObs = n())
```

From the output we can see that this calculate the summary statistics within each value of the `office` variable. We can also include more than one variable within `group_by()`. For example, imagine we wanted to calculate these summary statistics by gender within each office. All we would need to do is add `Gender` to the `group_by()`:

```{code-cell}
employees %>%

  group_by(office, Gender) %>%

  summarise(meanSalary = mean(Salary, na.rm=TRUE),
            sdSalary = sd(Salary, na.rm=TRUE),
            minAge = min(Age),
            maxAge = max(Age),
            nObs = n())
``` 