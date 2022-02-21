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

# Filtering Rows

Instead of just sorting the rows in your data, you might want to filter out rows based on a set of conditions. You can do this with the `filter()` function, which uses the following syntax:

```{admonition} Syntax
`tidyverse::filter(df, condition1, condition2, condition3, ...)`
+ *Required arguments*
  - `df`: The tibble (data frame) with the data you would like to filter. 
  - `condition1`: The logical condition that identifies the rows you would like to keep.
+ *Optional arguments*
  - `condition2, condition3, ...`: Any additional conditions that identify the rows you would like to keep.
```
  
The conditions specified in `filter()` can use a variety of **comparison operators**:

+ `>` (greater than), `<` (less than)
+ `>=` (greater than or equal to), `<=` (less than or equal to)
+ `==` (equal to); note that a single equals sign (`=`) will *not* work
+ `!=` (not equal to)

For example, imagine we wanted to create a new data frame with only those employees who are retired. We could do this with `filter()` by writing a condition that specifies that the `Retired` variable equals `TRUE`:

```{code-cell}
retiredEmployees <- filter(employees, Retired == TRUE)
head(retiredEmployees)
dim(retiredEmployees)
```

```{code-cell}
:tags: [remove-output]
dim(retiredEmployees)
```

```{code-cell}
:tags: [remove-input]
print(dim(retiredEmployees))
```

By specifying multiple conditions in our call to `filter()`, we can filter by more than one rule. Let's say we wanted a dataset with employees who:

+ Are still working, *and*
+ Started on or after January 1, 1995, *and*
+ Are *not* in human resources. 

```{code-cell}
employeesSub <- filter(employees, 
                       Retired == FALSE, Start_Date >= "1995-01-01", Division != "Operations")
head(employeesSub)
dim(employeesSub)
```

```{code-cell}
:tags: [remove-output]
dim(employeesSub)
```

```{code-cell}
:tags: [remove-input]
print(dim(employeesSub))
```

When you list multiple conditions in `filter()`, those conditions are combined with "and". In the previous example, our new data frame `employeesSub` contains the `r nrow(employeesSub)` employees who are still working, *and* who started on or after January 1, 1995, *and* who are not in human resources. 

However, you might want to filter based on one condition *or* another. For example, imagine we wanted to find all employees who have a master's, *or* who started on or before December 31, 2000, *or* who make less than $100,000. To do this, instead of listing each condition as a separate argument, we combine the conditions with the `|` character, which evaluates to "or". For example:  

```{code-cell}
employeesSubOr <- filter(employees, 
                         Degree == "Master's" | Start_Date <= "2000-12-31" | Salary < 100000)
head(employeesSubOr)
dim(employeesSubOr)
```

```{code-cell}
:tags: [remove-output]
dim(employeesSubOr)
```

```{code-cell}
:tags: [remove-input]
print(dim(employeesSubOr))
```

Now let's create a data frame with the employees who have a Master's or a Ph.D. We could do this using the or operator `|`:

```{code-cell}
employeesGrad <- filter(employees, Degree == "Master's" | Degree == "Ph.D")
head(employeesGrad)
dim(employeesGrad)
```

```{code-cell}
:tags: [remove-output]
dim(employeesGrad)
```

```{code-cell}
:tags: [remove-input]
print(dim(employeesGrad))
```

Now imagine we wanted to find all employees who have a Master's, a Ph.D, or a Bachelor's. We could add another `|` to our condition and specify that `Degree == "Bachelor's"`. Alternatively, we could make our code more compact by re-writing the condition as `var_name %in% values`. This will filter to only those rows where `var_name` is equal to one of the values specified in the atomic vector `values`. For example:

```{code-cell}
employeesCollege <- filter(employees, Degree %in% c("Bachelor's", "Master's", "Ph.D"))
head(employeesCollege)
dim(employeesCollege)
```

```{code-cell}
:tags: [remove-output]
dim(employeesCollege)
```

```{code-cell}
:tags: [remove-input]
print(dim(employeesCollege))
```

```{warning}
Be careful filtering data when you have missing values (`NA`).
```

The `filter()` function keeps only those rows where the specified condition(s) evaluate(s) to `TRUE`. This is complicated by the presence of missing values, as it is impossible to determine whether a condition is `TRUE` or `FALSE` if the relevant information is missing. In our employees data set, we are missing a `Salary` for around 5% of the employees. If we wanted to filter to only those individuals who made more than \$100,000, how would `filter()` treat the 5% of employees with `NA` values for `Salary`? Because the condition does not evaluate to `TRUE` for these rows, they are dropped.

```{code-cell}
employees100k <- filter(employees, Salary >= 100000)
head(employees100k)
```

In this example, `employees100k` would *not* include any of the employees whose salary is unknown. Note that R provides no warning that these rows are being excluded as well; it is up to the user to recognize that the data contains missing values, and that this will affect how data are filtered. 

If you did not want R to drop the missing values, you could explicitly state in the condition to keep all rows where `Salary` is greater than or equal to $100,000, *or* where `Salary` is missing. As we saw before, we can combine conditions with "or" using the `|` character. It may be tempting to assume we should add `Salary == NA` in order to capture the rows where `Salary` is missing; however, this will not work. We cannot use logical operators like `==` to compare something to `NA`. Instead have to use the `is.na()`, as follows:

```{code-cell}
employees100kNA <- filter(employees, Salary >= 100000 | is.na(Salary))
head(employees100kNA)
```

```{code-cell}
tail(employees100kNA)
```