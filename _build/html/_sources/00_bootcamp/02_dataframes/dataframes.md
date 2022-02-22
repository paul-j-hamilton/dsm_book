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

# Data Frames

In the previous chapter we saw how to create atomic vectors, which can store one or more values of the same type. However, most of the time when we work with data we are dealing with **tabular** data, which contains many rows and columns. For example, below we have a data set with information on 1,000 employees from a software company. (For convenience we only display the first six rows of the data set.)

By convention, the **observations** (*i.e.*, the employees) form the rows of the data set, and the **variables** (*i.e.*, the characteristics of the employees we are measuring) form the columns. The **dimensions** of the data set are typically written as $n$ x $m$, where $n$ is the number of observations (or rows) and $m$ is the number of variables (or columns).

```{figure} ../../_build/images/tabular_data.png
---
height: 150px
name: tab_data
---
Example of Tabular Data
```

In R, this type of data is stored in a **data frame**. In this chapter we will explore the basics of data frames, which we will rely on heavily throughout the course.