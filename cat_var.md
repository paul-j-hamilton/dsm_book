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
```

# Categorical Variables

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