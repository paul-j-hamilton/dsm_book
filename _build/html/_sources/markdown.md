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

# **R Basics**

This chapter provides an introduction to the very basics of R (and coding in general). By the end, you will be familiar with all of the following concepts:

+ R as a Calculator
+ Assignment
+ Data Types
+ Atomic Vectors
+ Functions

If you already have experience with coding and/or the R language, you may skip this chapter. However, you must still successfully complete the coding exercise at the end of the bootcamp before our third class.


To begin, watch the following video:

[ADD]

Click the button below to launch an interactive R session in your browser. As you read through the sections of this chapter, use this interactive R session to test out what your learn. 

<a href="https://hbs-data-science.shinyapps.io/DSM_R_Basics" class="btn btn-primary" style="color:white;" target="_blank">Start Coding in R!</a>

---

## R as a Calculator

At its most basic, R can be used as a calculator. As you would expect, you can use all the standard mathematical operators:

+ Addition (`+`) & Subtraction (`-`)
+ Multiplication (`*`) & Division (`/`)
+ Exponentiation (`^`)

```{code-cell}
2 + 2
```

```{code-cell}
100 / 20
```

```{code-cell}
3 ^ 3
```

Of course, R is much more than a simple calculator! In the following sections, you'll learn the building blocks of R that we'll rely on throughout the entire course. 

## Assignment

When you work with data in Excel, each value in your data set is stored in an individual cell, and each one of those cells has a unique name made up of a letter and a number. For example, in the figure below, cell A2 stores the number `110,000`, cell B3 stores the text `"Operations"`, etc.

```{figure} ../images/Excel_Example.png
---
height: 200px
name: excel
---
Example Excel Worksheet
```

Once you have data stored in cells, you can apply formulas to those cells by referencing the cell names. For example, if you ran `=SUM(A2:A7)`, Excel would sum the salaries of all employees in the data set. If this example is framiliar to you, you already understand the basics of R programming!

To learn how to code in R, you do not need a complete understanding of how the language is designed. However, you should know that everything you create in an R program is referred to as an **object**. Every object you create belongs to one of several **classes**, which determines the properties and attributes of the object.

To see what this means in concrete terms, let’s take a look at some R code. In the code below, we create an object called `A2`, which contains the value `110000`. We can create objects (or **variables**) with the **assignment operator** `<-`. When we run this line of code, we create an object called `A2` that stores the value `110000`. Think of this as similar to entering the value `110000` into cell `A2` in an Excel worksheet.

```{code-cell}
A2 <- 110000
```

This code does not produce any output; all we are doing is storing the value `11000` in a variable called `A2`, so there are no results to print out. If we want to see what’s stored in our variable, we can simply run a line of code with the name of the variable and R will output its contents.

```{code-cell}
A2
```

Fortunately, we can be more descriptive with our variable names. We can name our variables anything we want, subject to two rules.

:::{note}
+ A variable name has to start with a letter and can contain letters, numbers, underscores, and periods.
+ A variable cannot have the same name as any of R’s **reserved words**. These are words that already have meaning in the R language. For example, we could not create a variable called `class`, because this word is already being used for the `class()` function in R.
:::

Below we create some more variables.

```{code-cell}
a <- 5.5
a
```

If you create a variable in R but then want to change its value, you can simply overwrite it with the assignment operator `<-`. Imagine we wanted `a` to store the value `6.5` instead of `5.5`; we can fix it as follows:

```{code-cell}
a <- 6.5
a
```

The variables we create can store more than just numbers. We can store text in a variable by surrounding the text with quotation marks (`""`):

```{code-cell}
myFirstTextVar <- "I love DSM!"
myFirstTextVar
```

You'll notice in the code example above that in our variable name, the first letter of each word (except the first word) is capitalized. Writing variable names this way is a convention known as **camel case**, and although it is not required, we recommend it to keep your R code easily readable. 

## Data Types

You are likely framiliar with the window below from Excel, which shows the format of a cell (or group of cells). The proper choice of format depends on the type of data contained in the cell. For example, a column containing customers’ names should be formatted as *General* or *Text*; a column with the transaction dates of customer orders should be formatted as *Date*; a column with sales prices should be formatted as *Currency* or *Accounting*.

```{figure} ../images/Excel_Formats.png
---
height: 400px
name: excel
---
Data Formats in Excel
```

Just like Excel, R has several **data types** that specify the type of data you are working with. We can see the data type of a variable by applying the `class()` function (we'll learn more about functions in an upcoming section). For example, if we apply `class()` to our variable `myFirstTextVar`, we see it is a `character`, which means that it stores text. Note that we did not need to explicitly tell R which class `myFirstTextVar` should belong to - because we were storing text in `myFirstTextVar`, R automatically knew to create a `character` object.

```{code-cell}
class(myFirstTextVar)
```

The following are the primary data types that you should be aware of:

+ **Logical** - Used to store Boolean data, which only take on the values `TRUE` or `FALSE`. 

```{code-cell}
logicalVar <- TRUE
class(logicalVar)
```

+ **Numeric** - Used to store numbers with or without values after the decimal. 

```{code-cell}
income <- 50000.25
class(income)
```

+ **Character** - Used to store text data, in particular text variables that can take on an infinite or very large set of possible values. For example, someone's name, which could be nearly anything, should be stored as a character.

```{code-cell}
message <- "hello world"
class(message)
```

+ **Factor** - Used to represent categorical variables that take on a fixed set of values. For example, in our data set from  {numref}`excel`, the `Division` variable can only take on three possible values: `Operations`, `Human Resources`, and `Sales`. Therefore, this data should ideally be stored as a factor.

	+ Note that in practice it can often be difficult to decide whether something should be stored as a factor or a character. It is possible to store division as a character instead of as a factor, and in many circumstances this would not be an issue. However, there are certain circumstances where you want R to recognize that a variable takes on a limited set of values. We will come back to this later in the course.

```{code-cell}
division <- as.factor("Operations")
class(division)
```

+ **Date** - Used to store dates in R.

```{code-cell}
birthday <- as.Date("2000-01-01")
class(birthday)
```

Although not a data type, you should also be framiliar with `NA`, which is used to represent missing data in R. We often work with data sets that have missing values. For example, in our employees data set, we may not know the salary of some of the employees. In Excel we might represent this with `#N/A`, but in R it would be stored as `NA`. Because missing data is such a common issue, we will revisit `NA` frequently throughout this book. One has to be particularly careful with missing data in R, as `NA` values can create issues and unexpected behaviors that are sometimes difficult to detect.

## Atomic Vectors

So far we have seen how to create variables that store a single value only. However, in practice we almost always work with sets of many different values. To work with this type of data in R we can create an **atomic vector**, which stores a set of one or more values of the same type. There are two important components to this definition:

+ Atomic vectors can store one or more values, meaning an object that stores just a single value is an atomic vector. This means that every object we have created so far (*e.g.*, `myFirstTextVar`) has been an atomic vector. Below we will see how to create atomic vectors with more than one value.
+ Atomic vectors cannot mix data types. This means you could not have an atomic vector with numbers *and* characters, for example.

:::{note}
Atomic vectors store one or more values of the same type.
:::

As we’ve seen throughout the book so far, single-value atomic vectors can be created by simply assigning a value to a variable:

```{code-cell}
v1 <- 2             # Numeric atomic vector
v2 <- TRUE          # Logical atomic vector
v3 <- "R is fun!"   # Character atomic vector
```

If we want to combine multiple values into a single atomic vector, we need to use the `c()` function, which stands for “**c**ombine”:

```{code-cell}
v4 <- c(2, 3, 4, 5)                 # Numeric atomic vector
v5 <- c(TRUE, TRUE, FALSE)          # Logical atomic vector
v6 <- c("R is fun!", "I hate R")    # Character atomic vector
v7 <- c(8, 9, 10, NA)               # Numeric atomic vector with missing value
```

Now that we have multiple values stored in a single atomic vector, there are many different functions we can apply to these atomic vectors.

## Functions

A fundamental part of R programming is the use of **functions**, which are very similar to functions in Excel. For example, you may be framiliar with the Excel function `SUMIF()`, which sums the values in a range of cells that adhere to a certain criteria. Let's return to the small data set from {numref}`excel`:

```{figure} ../images/Excel_Example.png
---
height: 200px
name: excel2
---
Example Excel Worksheet
```

Imagine that we wanted to calculate the total amount spent on only those employees in the Operations department. We can accomplish this with `SUMIF()`, which uses the following syntax:

```{admonition} Syntax
`SUMIF(range, criteria, sum_range)`
+ *Required arguments*
	+ `range`: The range of cells where the criteria should be evaluated.
	+ `criteria`: The criteria to apply to the cells in `range`.
+ *Optional arguments*
	+ `sum_range`: The cells to sum based on the criteria.
```

To apply this function to the data shown in the figure, we would write `=SUMIF(B2:B7, "Operations", A2:A7)`, which would evaluate to `302,000`. Feel free to verify this in Excel yourself.

Note that every time we use the `SUMIF()` function, we *must* specify the `range` and `criteria` arguments. The `sum_range` argument is optional, and we only need to use it if we want to sum a different set of cells than those specified in the `range` argument.

Whenever we introduce a new R function, we will follow the same convention shown above to demonstrate the syntax of the function. The basic syntax of the function will be shown in a light blue box marked "Syntax", and any required and optional arguments will be described within the box. Additionally, whenever you are learning a new function, we encourage you to search Google for examples, as well as review the official documentation for the function at [rdocumentation.org](https://www.rdocumentation.org/). 

```{tip} 
You can look up the syntax for a function on [rdocumentation.org](https://www.rdocumentation.org/), and/or search Google for helpful examples.
```

Now let's learn an actual R function. One commonly used function is `length()`, which (as you might guess) determines the length of an R object. This function uses the following syntax:

```{admonition} Syntax
`length(x)`
+ *Required arguments*
	+ `x`: An R object.
```

We can apply this function to the atomic vectors we created in the previous section to determine how many values each one contains:

```{code-cell}
length(v4)
```

```{code-cell}
length(v5)
```

```{code-cell}
length(v6)
```

```{code-cell}
length(v7)
```

Additionally, there is a `sum()` function we can use to add up all the values of an atomic vector. This function uses the following syntax:

```{admonition} Syntax
`sum(x, na.rm=FALSE)`
+ *Required arguments*
	+ `x`: An R object.
+ *Optional arguments*
	+ `na.rm`: If `TRUE`, the function will remove any missing values (`NA`s) in the atomic vector and sum the non-missing values. If `FALSE`, the function does not remove `NA`s and will return a value of `NA` if there is an `NA` in the atomic vector.
```

Note that this will not work for `v6`, because there is no logical way to sum characters together. If we apply it to `v5`, it will treat the `TRUE` values like `1` and the `FALSE` values like `0`.

```{code-cell}
sum(v4)
```

```{code-cell}
sum(v5)
```

```{code-cell}
sum(v7)
```

What happened with `v7`? Recall that this vector contains a missing value (`NA`). If you review the syntax for the `sum()` function, you'll see that it includes an optional parameter `na.rm`, which determines how the function treats missing values. If this argument is set to `TRUE`, it ignores missing values and calculates the sum of the non-missing values. If it is set to `FALSE`, the function will return `NA` if there is a single missing value present. 

However, in our call to the `sum()` function, we didn't include this argument at all, so what is going on? Optional arguments often have a default value that is used if you fail to specify the desired value explicitly. In this case, the default value is `FALSE`, so if we do not specify `na.rm=TRUE` in our call to `sum()`, the missing values will *not* be ignored and the function will return `NA`. 

If we re-run the function but add `na.rm = TRUE`, we get the expected result:

```{code-cell}
sum(v7, na.rm = TRUE)
```

Similar to `sum()`, there are many other functions that can be applied to atomic vectors:

```{admonition} Syntax
`mean(x, na.rm=FALSE)`
+ *Required arguments*
	+ `x`: An R object.
+ *Optional arguments*
	+ `na.rm`: If `TRUE`, the function will ignore any missing values (`NA`s) in the atomic vector. If `FALSE`, the function does not ignore `NA`s and will return a value of `NA` if there is an `NA` in the atomic vector.
```

```{admonition} Syntax
`min(x, na.rm=FALSE)` & `max(x, na.rm=FALSE)`
+ *Required arguments*
	+ `x`: An R object.
+ *Optional arguments*
	+ `na.rm`: If `TRUE`, the function will ignore any missing values (`NA`s) in the atomic vector. If `FALSE`, the function does not ignore `NA`s and will return a value of `NA` if there is an `NA` in the atomic vector.
```

```{code-cell}
mean(v4)
```

```{code-cell}
min(v5)
max(v5)
```

```{code-cell}
mean(v7, na.rm = TRUE)
```
