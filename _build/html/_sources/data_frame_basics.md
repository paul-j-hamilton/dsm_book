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
```

# Data Frame Basics

Now that our employee data has been read into a data frame, we can begin exploring the data! We will start by exploring the dimensions of the data set. We can determine the **n**umber of **rows** (or observations) in our data set with the `nrow()` function:

```{admonition} Syntax
`nrow(x)`
+ *Required arguments*
  + `x`: A data frame.
```

```{code-cell}
:tags: [remove-output]
nrow(employees)
```

```{code-cell}
:tags: [remove-input]
print(nrow(employees))
```

Similarly, we can use `ncol()` to determine the **n**umber of **col**umns:

```{admonition} Syntax
`ncol(x)`
+ *Required arguments*
  + `x`: A data frame.
```

```{code-cell}
:tags: [remove-output]
ncol(employees)
```

```{code-cell}
:tags: [remove-input]
print(ncol(employees))
```

The `dim()` function returns the full **dim**ensions of the data (*i.e.*, both the number of rows and columns):

```{admonition} Syntax
`dim(x)`
+ *Required arguments*
  + `x`: A data frame.
```

```{code-cell}
:tags: [remove-output]
dim(employees)
```

```{code-cell}
:tags: [remove-input]
print(dim(employees))
```

We can view the first and last few rows of the data set with the `head()` and `tail()` functions, respectively:

```{admonition} Syntax
`head(x)` & `tail(x)`
+ *Required arguments*
  + `x`: A data frame.
```

```{code-cell}
:tags: [remove-output]
head(employees)
```

```{code-cell}
:tags: [remove-input]
print(head(employees))
```

```{code-cell}
:tags: [remove-output]
tail(employees)
```

```{code-cell}
:tags: [remove-input]
print(tail(employees))
```

It is easy to get a quick view of the **str**ucture of the data using the `str()` function. This shows the number of observations, the number of variables, the type of each variable, and the first few values of each variable. 

```{admonition} Syntax
`str(x)`
+ *Required arguments*
  + `x`: A data frame.
```

```{code-cell}
:tags: [remove-output]
str(employees)
```

```{code-cell}
:tags: [remove-input]
print(str(employees))
```

After reading in a data set, it is best practice to check the dimensions of the data and explore its structure using the functions shown in this section. This will help uncover any immediate problems with the data.

So far we have seen some functions that can applied to an entire data frame. However, we often want to work with an individual column in a data frame. For example, we may be interested in calculating the average `Age` of all employees in the data set. We can access specific columns of a data frame using the `$` operator, which takes the general form:

```{admonition} Syntax
`dataFrameName$variableName`
```

If we write `employees$Age`, we will get an atomic vector with the age of the 1,000 employees in the data frame. If you recall from the previous chapter, there are many different functions we can apply to atomic vectors in R. Because `employees$Age` is an atomic vector, we can apply those functions here to explore the `Age` variable. For example, to calculate the mean, minimum, and maximum `Age`, we could write:

```{code-cell}
:tags: [remove-output]
mean(employees$Age)
min(employees$Age)
max(employees$Age)
```

```{code-cell}
:tags: [remove-input]
print(mean(employees$Age))
print(min(employees$Age))
print(max(employees$Age))
```