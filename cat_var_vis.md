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
degreeLevels <- c("High School", "Associate's", "Bachelor's", "Master's", "Ph.D")
employees$Degree <- parse_factor(employees$Degree, levels = degreeLevels, ordered = TRUE)
```

# Categorical Variables

In this section, we will review some of the data visualizations that are appropriate for quantitative variables. 

## Bar Plots

For categorical variables, **bar plots** can be used to visualize how the data are distributed over the different categories. Specifically, a bar plot shows the number of observations corresponding to each category of a categorical variable, such as `Division`. To create the barplot, we first need to create a table of the categorical variable we are examining, then apply `barplot}()` to that table.

```{admonition} Syntax
`barplot(table(x))`
+ *Required arguments*
  - `x`: The atomic vector of values.
```

```{code-cell}
barplot(table(employees$Division))
```

By combining the `barplot()` command and the `table()` and `prop.table()` commands, we can create a **stacked barplot** for two categorical variables, such as `Division` and `Gender`. Recall that the `margin` argument of the `prop.table()` command (`2` in this case) indicates that we wish to calculate the proportion of observations by column rather than by row. The `legend` parameter adds a legend with the `Male` and `Female` labels for each color.

```{code-cell}
barplotTable <- prop.table(table(employees$Gender,employees$Division), 2)
barplot(barplotTable, legend=rownames(barplotTable))
```

## Pie Chart

Alternatively, we can visualize a categorical variable with a pie chart using the `pie()` function:

```{admonition} Syntax
`pie(table(x))`
+ *Required arguments*
  - `x`: The atomic vector of values.
```

```{code-cell}
pie(table(employees$Division))
```