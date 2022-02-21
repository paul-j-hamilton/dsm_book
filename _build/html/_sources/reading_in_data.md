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

# Reading in Data

The tidyverse contains a variety of functions for reading in data from different file types. Our employee data is saved in a comma-separated values (.csv) file called `employee_data.csv`. We can read the data from this file into a data frame using the read_csv() function, which uses the following syntax:

```{admonition} Syntax
`tidyverse::read_csv(file, col_names=TRUE, skip=0, …)`
+ *Required arguments*
  + `file`: The file path of the file you would like to read in. Note that the path must be surrounded in quotation marks.
+ *Optional arguments*
  + `col_names`: When this argument is `TRUE`, the first row of the file is assumed to contain the column names of the data set. When it is `FALSE`, the first row is assumed to contain data, and column names are generated automatically (`X1`, `X2`, `X3`, etc.)
  + `skip`: The number of rows at the top of the file to skip when reading in the data. This is useful if the first few rows of your data file have text you want to ignore.
```

Below we use this function to read our data from the csv file into a data frame called `employees`. In this case, our data file is stored at the path `"_build/data/employee_data.csv"`.

```{code-cell}
employees <- read_csv("_build/data/employee_data.csv") # NOTE: Change this to URL
```

By default, the function prints out the assumed data type of each column. For example, the function assumes that `ID` is a `double` (a sub-class of the `numeric` type), `Name` is a `character`, `Retired` is a `logical`, etc. These seem like the correct choices. However, you may also notice that the function got some of the types wrong. For example, `Start_Date`, `Degree`, and `Salary` were all read in as `character`s instead of as a `Date`, `factor`, and `numeric`, respectively. We will see how to correct this in a subsequent section.

If our data were in an Excel (.xlsx) file instead of a csv, we could read it in using the `read_excel()` function from the `readxl` package ([Wickham and Bryan 2019](https://bookdown.org/hbsabafaculty/ids_book/programming-concepts.html#ref-readxl)). This function uses the following syntax:

```{admonition} Syntax
`readxl::read_excel(file, sheet = 1, col_names = TRUE, range = NULL, skip = 0 …)`
+ *Required arguments*
  + `file`: The file path of the file you would like to read in. Note that the path must be surrounded in quotation marks.
+ *Optional arguments*
  + `sheet`: The sheet within the Excel workbook that contains the data you want to read in. You can either specify the sheet number (the default is `sheet = 1`), or the name of the sheet as a string (e.g., `sheet = "Sheet Name"`).
  + `col_names`: When this argument is `TRUE`, the first row of the file is assumed to contain the column names of the data set. When it is `FALSE`, the first row is assumed to contain data, and column names are generated automatically (`X1`, `X2`, `X3`, etc.)
  + `range`: The range of cells in the sheet that contains the data you would like to read in. For example, if your only wanted to read in the data in the range `B4:F100`, you would set `range = "B4:F100"`.
  + `skip`: The number of rows at the top of the file to skip when reading in the data. This is useful if the first few rows of your data file have text you want to ignore.
```

Although .csv and .xlsx are very common file types, you will likely encounter data stored in other file types (tab-separated files (.tab), text files (.txt), etc.) Here we will not show the functions to read in data from all of these different file types. However, they will generally be of a similar form as the `read_csv()` and `read_excel()` functions shown above. Always start by Googling to find the appropriate function for the type of file you need to read into R.
