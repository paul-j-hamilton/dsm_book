---
jupytext:
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
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
```

# Summary Statistics

The concept of summary statistics should be familiar to most readers. These are the summary measures that all organizations use to track key business outcomes. While visualizations can provide a visual indication of typical values, outliers, variations, trends, and associations in a data set, summary statistics provide unambiguous, numerical measures.

## Quantitative Variables

As we explore a data set, it is often useful to calculate summary statistics that provide a preliminary overview of the variables we are working with. There are two main types of quantitative variables, continuous and discrete. A **continuous** variable is one that can take on any value within a certain numerical range. For example, in the `employees` data set `Salary` is continuous because it can take on any value above \$0. A **discrete** variable can take on only a discrete set of values (*e.g.*, 2,4,6,8). 
The most basic summary statistics for quantitative variables are measures of **central tendency**, such as:

+ The **mode** - the most frequent value in the data.

+ The **mean** - the average value, defined as the sum of all observations divided by the total number of observations. In mathematical notation, we would write this as: 

$$\bar{x} = \frac{1}{n} \sum^{n}_{i=1}{x_i}$$

  Conventionally, we have a data set with $n$ observations, and $x_i$ represents the value of the $i^{th}$ observation in that data set. In the formula above, the expression $\sum^{n}_{i=1}{x_i}$ means "the sum of the $n$ values of $x$ in the data set." To get the mean ($\bar{x}$), we divide that total by $n$.

  As we've seen before, we can calculate the mean in R with the `mean()` function.

```{code-cell}
:tags: [remove-output]
mean(employees$Salary, na.rm = TRUE)
```

```{code-cell}
:tags: [remove-input]
print(mean(employees$Salary, na.rm = TRUE))
```

+ The **median** & **quartiles** - when the data is sorted:
  + The median is the middle value (*i.e.*, the 50th percentile, also called the second quartile),
  + The first quartile is the 25th percentile, and 
  + The third quartile is the 75th percentile.
  
  We can calculate the median in R withinh the `median()` function.
  
```{admonition} Syntax
`median(x, na.rm = FALSE)`
+ *Required arguments*
  - `x`: The atomic vector whose values one would like to find the median of.
+ *Optional arguments*
  - `na.rm`: If `TRUE`, the function will **r**e**m**ove any missing values (`NA`s) in the atomic vector and find the median of the non-missing values. If `FALSE`, the function does *not* remove `NA`s and will return a value of `NA` if there is an `NA` in the atomic vector.
```

```{code-cell}
:tags: [remove-output]
median(employees$Salary, na.rm = TRUE)
```

```{code-cell}
:tags: [remove-input]
print(median(employees$Salary, na.rm = TRUE))
```

  We can calculate the first and third quartiles with `quantile()`.

```{admonition} Syntax
`quantile(x, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm = FALSE)`
+ *Required arguments*
  - `x`: The atomic vector of values where we would like to find the quantiles.
+ *Optional arguments*
  - `probs`: An atomic vector with the percentiles (between 0 and 1) we would like to calculate.
  - `na.rm`: If `TRUE`, the function will **r**e**m**ove any missing values (`NA`s) in the atomic vector and find the percentiles of the non-missing values. If `FALSE`, the function does *not* remove `NA`s and will return a value of `NA` if there is an `NA` in the atomic vector.
```

```{code-cell}
:tags: [remove-output]
quantile(employees$Salary, na.rm = TRUE)
```

```{code-cell}
:tags: [remove-input]
print(quantile(employees$Salary, na.rm = TRUE))
```

In addition to measures of central tendency, we often also want to measure the dispersion, or spread, of a data set. We can do that with the following measures:

+ The **interquartile range (IQR)** - the difference between the first quartile (*i.e.*, the 25th percentile) and the third quartile (*i.e.*, the 75th percentile).

+ The **standard deviation** & **variance** - variance and standard deviation are both measures of the spread of a data set. The minimum value of both measures is zero (which indicates no variation in the data), and the higher the values the more spread out the data are. The variance is calculated in squared units, while the standard deviation is recorded in the base units.
  + Formally, the variance of a data set is written as:


  $$s^2 = \frac{1}{n - 1}\sum^{n}_{i=1}{(x_i - \bar{x})^2}$$

  + Although variance is an important concept in statistics, it does not provide a very intuitive understanding of the spread of a data set, because it is in squared units. Instead we more commonly look at the standard deviation, which is the square root of the variance.
  + Formally, the standard deviation of a data set is written as:


  $$s = \sqrt{\frac{1}{n - 1}\sum^{n}_{i=1}{(x_i - \bar{x})^2}}$$

  This can be thought of as roughly the average distance observations in the data set fall from the mean.

  We can calculate standard deviation and variance with the `sd()` and `var()` functions, respectively.

```{admonition} Syntax
`sd(vectorName, na.rm = FALSE)` & `var(vectorName, na.rm = FALSE)`
+ *Required arguments*
  - The atomic vector whose values one would like to find the standard deviation/variance of.
+ *Optional arguments*
  - `na.rm`: If `TRUE`, the function will **r**e**m**ove any missing values (`NA`s) in the atomic vector and find the standard deviation/variance of the non-missing values. If `FALSE`, the function does *not* remove `NA`s and will return a value of `NA` if there is an `NA` in the atomic vector.
```
  
```{code-cell}
:tags: [remove-output]
sd(employees$Salary, na.rm = TRUE)
var(employees$Salary, na.rm = TRUE)
```

```{code-cell}
:tags: [remove-input]
print(sd(employees$Salary, na.rm = TRUE))
print(var(employees$Salary, na.rm = TRUE))
```

## Categorical Variables

Categorical variables take on values corresponding to a category. For example, `Degree` in `employees` can only take on the values `High School`, `Associate's`, `Bachelor's`, `Master's`, and `Ph.D`. Categorical variables cannot be summarized by the mean, median, or standard deviation. Instead, these variables are often summarized using tables and bar plots. For categorical variables, the `table()` and `prop.table()` commands show the number and percentage (**prop**ortion) of observations in each category, respectively. Note that to use `prop.table()`, we need to apply `table()` first.

```{admonition} Syntax
`table(x)` & `prop.table(table(x))`
+ *Required arguments*
  - `x`: The atomic vector of values.
```

```{code-cell}
table(employees$Division)
```

```{code-cell}
prop.table(table(employees$Division))
```

Two categorical variables can be summarized in a two-way table using the same `table()` and `prop.table()` commands shown above. For example:

```{code-cell}
table(employees$Division, employees$Degree)
```

The `prop.table()` command has an optional second argument `margin` that calculates the proportion of observations by row (`margin` = 1) or column (`margin` = 2). Note that the term `margin` refers to the "margins" (*i.e.*, the outer edges) of the table, where the sum of the rows and columns are often written. In the code chunk below we do not specify the `margin` parameter in `prop.table()`, so each cell represents the proportion over all observations in the data set. For example, 5.4% of all employees work in Sales and have a high school diploma.

```{code-cell}
prop.table(table(employees$Division, employees$Degree))
```

If we set `margin` equal to 1, each cell represents the proportion of observations by row. For example, of all employees in Accounting, 49.2% have a Bachelor's.

```{code-cell}
prop.table(table(employees$Division, employees$Degree), margin = 1)
```

If we set `margin` equal to 2, each cell represents the proportion of observations by column. For example, of all employees with an Associate's, 55.0% work in Operations. 

```{code-cell}
prop.table(table(employees$Division, employees$Degree), margin = 2)
```