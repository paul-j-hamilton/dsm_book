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
v4 <- c(2, 3, 4, 5)                 # Numeric atomic vector
v5 <- c(TRUE, TRUE, FALSE)          # Logical atomic vector
v6 <- c("R is fun!", "I hate R")    # Character atomic vector
v7 <- c(8, 9, 10, NA)               # Numeric atomic vector with missing value
```

# Functions

A fundamental part of R programming is the use of **functions**, which are very similar to functions in Excel. For example, you may be framiliar with the Excel function `SUMIF()`, which sums the values in a range of cells that adhere to a certain criteria. Let's return to the small data set from {numref}`excel3`:

```{figure} ../../_build/images/Excel_Example.png
---
height: 200px
name: excel3
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
:tags: [remove-output]
length(v4)
```

```{code-cell}
:tags: [remove-input]
print(length(v4))
```

```{code-cell}
:tags: [remove-output]
length(v5)
```

```{code-cell}
:tags: [remove-input]
print(length(v5))
```

```{code-cell}
:tags: [remove-output]
length(v6)
```

```{code-cell}
:tags: [remove-input]
print(length(v6))
```

```{code-cell}
:tags: [remove-output]
length(v7)
```

```{code-cell}
:tags: [remove-input]
print(length(v7))
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
:tags: [remove-output]
sum(v4)
```

```{code-cell}
:tags: [remove-input]
print(sum(v4))
```

```{code-cell}
:tags: [remove-output]
sum(v5)
```

```{code-cell}
:tags: [remove-input]
print(sum(v5))
```

```{code-cell}
:tags: [remove-output]
sum(v7)
```

```{code-cell}
:tags: [remove-input]
print(sum(v7))
```

What happened with `v7`? Recall that this vector contains a missing value (`NA`). If you review the syntax for the `sum()` function, you'll see that it includes an optional parameter `na.rm`, which determines how the function treats missing values. If this argument is set to `TRUE`, it ignores missing values and calculates the sum of the non-missing values. If it is set to `FALSE`, the function will return `NA` if there is a single missing value present. 

However, in our call to the `sum()` function, we didn't include this argument at all, so what is going on? Optional arguments often have a default value that is used if you fail to specify the desired value explicitly. In this case, the default value is `FALSE`, so if we do not specify `na.rm=TRUE` in our call to `sum()`, the missing values will *not* be ignored and the function will return `NA`. 

If we re-run the function but add `na.rm = TRUE`, we get the expected result:

```{code-cell}
:tags: [remove-output]
sum(v7, na.rm = TRUE)
```

```{code-cell}
:tags: [remove-input]
print(sum(v7, na.rm = TRUE))
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
:tags: [remove-output]
mean(v4)
```

```{code-cell}
:tags: [remove-input]
print(mean(v4))
```

```{code-cell}
:tags: [remove-output]
min(v5)
max(v5)
```

```{code-cell}
:tags: [remove-input]
print(min(v5))
print(max(v5))
```

```{code-cell}
:tags: [remove-output]
mean(v7, na.rm = TRUE)
```

```{code-cell}
:tags: [remove-input]
print(mean(v7, na.rm = TRUE))
```

Before moving on to the next section, work through the two exercises below. 

---

<iframe src="https://hbs-data-science.shinyapps.io/atomic_vectors_functions/#section-exercise-u.s.-gdp" width="800" height="1150" frameborder="0" marginheight="0" marginwidth="0" scrolling="no">Loading…</iframe>
