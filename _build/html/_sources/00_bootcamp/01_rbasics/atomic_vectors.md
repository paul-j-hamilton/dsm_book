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

# Atomic Vectors

So far we have seen how to create variables that store a single value only. However, in practice we almost always work with sets of many different values. To work with this type of data in R we can create an **atomic vector**, which stores a set of one or more values of the same type. There are two important components to this definition:

+ Atomic vectors can store one or more values, meaning an object that stores just a single value is an atomic vector. This means that every object we have created so far (*e.g.*, `myFirstTextVar`) has been an atomic vector. Below we will see how to create atomic vectors with more than one value.
+ Atomic vectors cannot mix data types. This means you could not have an atomic vector with numbers *and* characters, for example. Note that `NA` (which indicates a missing value) is *not* considered a distinct data type, so you can have atomic vectors that contain values of a particular data type as well as `NA`s. 

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