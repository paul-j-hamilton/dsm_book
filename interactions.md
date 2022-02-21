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
:tags: [hide-cell]
library(tidyverse)
library(knitr)
library(kableExtra)
employees <- read_csv("_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Degree<-as.factor(employees$Degree)
employees <- within(employees, Degree <- relevel(Degree, ref = "High School"))
modelAge <- lm(Salary ~ Age, data=employees)
```

# Interactions (&#9909;)

This section is optional, and will not be covered in the DSM course. Select "Click to show" to reveal. 

::::{toggle}

::::