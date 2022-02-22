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

# Sorting Data

Often you would like to sort your data based on one or more of the columns in your data set. This can be done using the `arrange()` function, which uses the following syntax:

```{admonition} Syntax
`tidyverse::arrange(df, var1, var2, var3, ...)`
+ *Required arguments*
  - `df`: The tibble (data frame) with the data you would like to sort. 
  - `var1`: The name of the column to use to sort the data.
+ *Optional arguments*
  - `var2, var3, ...`: The name of additional columns to use to sort the data. When multiple columns are specified, each additional column is used to break ties in the preceding column. 
```

By default, `arrange()` sorts `numeric` variables from smallest to largest and `character` variables alphabetically. You can reverse the order of the sort by surrounding the column name with `desc()` in the function call.

First, let's create a new version of the data frame called `employeesSortedAge`, with the employees sorted from youngest to oldest. 

```{code-cell}
employeesSortedAge <- arrange(employees, Age)
head(employeesSortedAge)
```

```{code-cell}
tail(employeesSortedAge)
```

We can instead sort the data from oldest to youngest by adding `desc()` around `Age`:

```{code-cell}
employeesSortedAgeDesc <- arrange(employees, desc(Age))
head(employeesSortedAgeDesc)
```

```{code-cell}
tail(employeesSortedAgeDesc)
```

Now imagine that we wanted to perform a multi-level sort, where we first sort the employees from oldest to youngest, and then within each age sort the names alphabetically. We can do this by adding the `Name` column to our function call:

```{code-cell}
employeesSortedAgeDescName <- arrange(employees, desc(Age), Name)
head(employeesSortedAgeDescName)
```

```{code-cell}
tail(employeesSortedAgeDescName)
```