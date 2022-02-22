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
myFirstTextVar <- "I love DSM!"
```

# Data Types

You are likely framiliar with the window below from Excel, which shows the format of a cell (or group of cells). The proper choice of format depends on the type of data contained in the cell. For example, a column containing customers’ names should be formatted as *General* or *Text*; a column with the transaction dates of customer orders should be formatted as *Date*; a column with sales prices should be formatted as *Currency* or *Accounting*.

```{figure} ../../_build/images/Excel_Formats.png
---
height: 400px
name: excel2
---
Data Formats in Excel
```

Just like Excel, R has several **data types** that specify the type of data you are working with. We can see the data type of a variable by applying the `class()` function (we'll learn more about functions in an upcoming section). For example, if we apply `class()` to our variable `myFirstTextVar`, we see it is a `character`, which means that it stores text. Note that we did not need to explicitly tell R which class `myFirstTextVar` should belong to - because we were storing text in `myFirstTextVar`, R automatically knew to create a `character` object.

```{code-cell}
:tags: [remove-output]
class(myFirstTextVar)
```

```{code-cell}
:tags: [remove-input]
print(class(myFirstTextVar))
```

The following are the primary data types that you should be aware of:

+ **Logical** - Used to store Boolean data, which only take on the values `TRUE` or `FALSE`. 

```{code-cell}
:tags: [remove-output]
logicalVar <- TRUE
class(logicalVar)
```

```{code-cell}
:tags: [remove-input]
print(class(logicalVar))
```

+ **Numeric** - Used to store numbers with or without values after the decimal. 

```{code-cell}
:tags: [remove-output]
income <- 50000.25
class(income)
```

```{code-cell}
:tags: [remove-input]
print(class(income))
```

+ **Character** - Used to store text data, in particular text variables that can take on an infinite or very large set of possible values. For example, someone's name, which could be nearly anything, should be stored as a character.

```{code-cell}
:tags: [remove-output]
message <- "hello world"
class(message)
```

```{code-cell}
:tags: [remove-input]
print(class(message))
```

+ **Factor** - Used to represent categorical variables that take on a fixed set of values. For example, in our data set from  {numref}`excel2`, the `Division` variable can only take on three possible values: `Operations`, `Human Resources`, and `Sales`. Therefore, this data should ideally be stored as a factor.

	+ Note that in practice it can often be difficult to decide whether something should be stored as a factor or a character. It is possible to store division as a character instead of as a factor, and in many circumstances this would not be an issue. However, there are certain circumstances where you want R to recognize that a variable takes on a limited set of values. We will come back to this later in the course.

```{code-cell}
:tags: [remove-output]
division <- as.factor("Operations")
class(division)
```

```{code-cell}
:tags: [remove-input]
print(class(division))
```

+ **Date** - Used to store dates in R.

```{code-cell}
:tags: [remove-output]
birthday <- as.Date("2000-01-01")
class(birthday)
```

```{code-cell}
:tags: [remove-input]
print(class(birthday))
```

Although not a data type, you should also be framiliar with `NA`, which is used to represent missing data in R. We often work with data sets that have missing values. For example, in our employees data set, we may not know the salary of some of the employees. In Excel we might represent this with `#N/A`, but in R it would be stored as `NA`. Because missing data is such a common issue, we will revisit `NA` frequently throughout this book. One has to be particularly careful with missing data in R, as `NA` values can create issues and unexpected behaviors that are sometimes difficult to detect.