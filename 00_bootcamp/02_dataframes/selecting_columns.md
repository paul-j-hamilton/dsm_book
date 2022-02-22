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
employees <- read_csv("../../_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
```

# Selecting Columns

In the previous section we saw how to select certain *rows* based on a set of conditions. In this section we show how to select certain *columns*, which we can do with `select()`: 

```{admonition} Syntax
`tidyverse::select(df, var1, var2, var3, ...)`
+ *Required arguments*
  - `df`: The tibble (data frame) with the data. 
  - `var1`: The name of the column to keep.
+ *Optional arguments*
  - `var2, var3, ...`: The name of additional columns to keep.
```

Imagine we wanted to explore the relationship between `Degree`, `Division`, and `Salary`, and did not care about any of the other columns in the employees data set. Using `select()`, we could create a new data frame with only those columns:

```{code-cell}
employeesTargetCols <- select(employees, Degree, Division, Salary)
head(employeesTargetCols)
```

If we want to exclude column(s) by name, we can simply add a minus sign in front of the column names in the call to `filter()`:

```{code-cell}
employeesExcludedCols <- select(employees, -Age, -Retired)
head(employeesExcludedCols)
```
