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

# Assignment

When you work with data in Excel, each value in your data set is stored in an individual cell, and each one of those cells has a unique name made up of a letter and a number. For example, in the figure below, cell A2 stores the number `110,000`, cell B3 stores the text `"Operations"`, etc.

```{figure} ../../_build/images/Excel_Example.png
---
height: 200px
name: excel1
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
:tags: [remove-output]
A2
```

```{code-cell}
:tags: [remove-input]
print(A2)
```

Fortunately, we can be more descriptive with our variable names. We can name our variables anything we want, subject to two rules.

:::{note}
+ A variable name has to start with a letter and can contain letters, numbers, underscores, and periods.
+ A variable cannot have the same name as any of R’s **reserved words**. These are words that already have meaning in the R language. For example, we could not create a variable called `class`, because this word is already being used for the `class()` function in R.
:::

Below we create some more variables.

```{code-cell}
:tags: [remove-output]
a <- 5.5
a
```

```{code-cell}
:tags: [remove-input]
a <- 5.5
print(a)
```

If you create a variable in R but then want to change its value, you can simply overwrite it with the assignment operator `<-`. Imagine we wanted `a` to store the value `6.5` instead of `5.5`; we can fix it as follows:

```{code-cell}
:tags: [remove-output]
a <- 6.5
a
```

```{code-cell}
:tags: [remove-input]
a <- 6.5
print(a)
```

The variables we create can store more than just numbers. We can store text in a variable by surrounding the text with quotation marks (`""`):

```{code-cell}
:tags: [remove-output]
myFirstTextVar <- "I love DSM!"
myFirstTextVar
```

```{code-cell}
:tags: [remove-input]
myFirstTextVar <- "I love DSM!"
print(myFirstTextVar)
```

You'll notice in the code example above that in our variable name, the first letter of each word (except the first word) is capitalized. Writing variable names this way is a convention known as **camel case**, and although it is not required, we recommend it to keep your R code easily readable. 

Before moving on to the next section, work through the two questions below. 

---

<iframe src="https://hbs-data-science.shinyapps.io/assignment/" width="800" height="800" frameborder="0" marginheight="0" marginwidth="0"  scrolling="no">Loading…</iframe>
