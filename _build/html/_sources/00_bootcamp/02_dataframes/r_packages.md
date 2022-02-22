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

# R Packages

Before we get to data frames, we first need to briefly discuss packages in R. 

In its most basic form, the R language contains a set of commands and functionality that are collectively referred to as **base R**. Any time you run R code, you will always have access to these base commands. However, you can import additional functionality by installing and loading **packages**, which expand what the R language can do. The R community has developed an immense number of packages that can help with nearly any type of analysis you can think of.

It is not always clear when to import a package and when to rely on base R. Your repertoire of packages will grow with experience. However, as a first step it would be helpful to review the list of the most popular R packages [here](https://data-flair.training/blogs/list-of-r-packages/). Throughout the book we will showcase a variety of different packages, many of which are on this list. Beyond the book, your best resource is Google - whenever you want to perform a new type of analysis, start by Googling to see if a relevant R package already exists.

In general, there are two steps you must complete to use a package in R:

1. Install the package using the `install.packages()` function. To use a package in R, that package must be installed on the machine where you are running your code. 

2. Load the package into your working R session using the `library()` function. Once the package is installed, you need to load it into your R session.

Below is the general syntax for installing and loading a package:

```{admonition} Syntax
`install.packages("packageName")`

`library(packageName)`
```

For example, if we wanted to use the `psych` package (information [here](https://cran.r-project.org/web/packages/psych/index.html)), we would run the following code:

```{code-cell}
:tags: [remove-output]
install.packages("psych")  # Install the package
library(psych)      # Load the package in the current R session
```

**Note** that in the `install.packages()` function, the package name needs to be in quotation marks (`"psych"`), but in the `library()` function it should *not* be in quotation marks.

Once a package is installed on a machine, it does not need to be re-installed in the future. This means that if you run your code on the same computer all the time, you will only need to run the `install.packages()` function once (the first time you use the package). Then, each subsequent time you use the package, it will already be installed and you can simply load it with the `library()` function.

Every time we introduce a new function that comes from an external package and is not part of base R, we will write the syntax as `package::function()`. For example, the `psych` package contains a useful function called `describe()` that calculates a variety of summary statistics for each variable in a data frame. We would write the syntax of this function as follows:

```{admonition} Syntax
`psych::describe(x, digits = 2, na.rm = TRUE)`
+ *Required arguments*
  + `x`: A data frame.
+ *Optional arguments*
  + `digits`: The number of significant digits to report.
  + `na.rm`: Whether to ignore missing values (`NA`).
```

## The tidyverse

Throughout the course, we will rely on a collection of R packages known as the **tidyverse** ([Wickham et al. 2019](https://bookdown.org/hbsabafaculty/ids_book/programming-concepts.html#ref-tidyverse)). The tidyverse packages were designed to create a streamlined workflow in R for data manipulation, exploration, and visualization. Everything that we will do with the tidyverse could be accomplished in base R. However, the tidyverse provides an elegant and efficient workflow that makes many of these tasks significantly easier and more efficient.

Because we will use the tidyverse so heavily throughout the course, we will always start by loading the tidyverse into our working R session with:

```{code-cell}
library(tidyverse)
```

Loading the `tidyverse` package prints a variety of messages to the screen, which can be ignored. If you fail to load the tidyverse at the start of an R session, you will get an error if you try to use any functions from the tidyverse. 