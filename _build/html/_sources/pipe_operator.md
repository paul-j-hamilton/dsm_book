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
```

# The Pipe Operator

Recall the ***Data Frames*** chapter of the R Bootcamp, where we applied a series of steps to process the `employees` data set. In that section, we did the following:

1. Fixed the types of the `Start_Date` and `Salary` columns (***Fixing Variable Types***).
2. Filtered rows out of the data using `filter()` (***Filtering Rows***).
3. Selected certain columns using `select()`  (***Selecting Columns***).
4. Sorted the data using `arrange()`  (***Sorting Data***).

Using what we learned in the bootcamp, let's apply these steps in a single code chunk. Imagine we would like to rank each employee with a Bachelor's, Master's, or Ph.D based on their salary. We will start with the raw data set that we read in from `employee_data.csv`, and apply the steps above to calculate the employee ranks.

```{code-cell}
:tags: [remove-output]
# Read in data
employees <- read_csv("_build/data/employee_data.csv")

# Step 1
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format="%m/%d/%Y")

# Step 2
employeesCollege <- filter(employees, Degree %in% c("Bachelor's", "Master's", "Ph.D"), !is.na(Salary))

# Step 3
employeesTargetCols <- select(employeesCollege, Degree, Salary)

# Step 4
employeesWithRankSorted <- arrange(employeesTargetCols, desc(Salary))
```
We can view the highest paid employees with `head()`. 

```{code-cell}
head(employeesWithRankSorted)
```

This got us the correct result, although the code is not very elegant or concise. Notice that we created several different data frames at each intermediate step in the code. In Step 2 we created a new data frame called `employeesCollege`, which we then passed to Step 3, where we created another data frame called `employeesTargetCols`, which we passed to Step 4, etc. To get to our final data set called `employeesWithRankSorted`, we had to create two intermediate data frames, in addition to our original data frame `employees`. Storing these four different data frames not only clutters up our environment; it can also create memory issues when working with very large data sets.

In the tidyverse we can solve this problem with an operator known as the **pipe** (`%>%`), which offers an easy and efficient way to combine multiple steps into a single statement. The pipe works according to the following basics syntax:

```{admonition} Syntax
`transformedData <- originalData %>% STEP 1 %>% STEP 2 %>% ... %>% STEP N`         
```

In this generic example, the original data is passed through steps 1 through N, and the resulting transformed data set is saved into `transformedData`. To better understand the pipe, think of the data as "flowing" through a series of steps. Our original data frame (`originalData`) is "pushed" through the opening of the pipe and through all the subsequent steps, coming out the other end after being processed and transformed. Because each step is applied within a single statement, we are not creating multiple intermediate data sets that have to be stored in memory. 

In the code chunck below, we use the pipe to apply the exact same data wrangling steps that we showed above. Note that we use all of our usual data wrangling functions as before, except now we do *not* need to specify the name of the data frame as the first argument.

```{code-cell}
:tags: [remove-output]
# Read in the data 
employees <- read_csv("_build/data/employee_data.csv")

employeesWithRankSortedPipe <- employees %>%

     mutate(Salary = parse_number(Salary),                                           # Step 1
            Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")) %>%

     filter(Degree %in% c("Bachelor's", "Master's", "Ph.D"), !is.na(Salary)) %>%     # Step 2

     select(Degree, Salary) %>%                                                      # Step 3

     arrange(Salary)                                                             # Step 4
```

If we output the first few rows of our new data frame, we'll see that it is identical to the one we created before.

```{code-cell}
head(employeesWithRankSortedPipe)
```
