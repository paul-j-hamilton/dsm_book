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
```

# Fixing Variable Types

As we saw in a previous section, R does not always correctly guess the appropriate type for our columns. This is a very common occurance, and fixing column types is a tedious but important step in preparing a data frame for analysis.

## Fixing Numeric Variables

When the `read_csv()` function read in the data, it assumed that the `Salary` column was a `character` instead of a `numeric`. This is because the data includes dollar signs (`$`), commas (`,`), and periods (`.`), which R interprets as `character`s. Fortunately, it is very easy to correct this using the `parse_number()` function from the tidyverse, which uses the following syntax:

```{admonition} Syntax
`tidyverse::parse_number(x, locale = default_locale(), ...)`
+ *Required arguments*
  + `x`: An atomic vector with values you would like to convert to a `numeric`. 
+ *Optional arguments*
  + `locale`: This is used to control the parsing convention for numbers. By default, the function assumes that periods (`.`) are used for decimal marks and commas (`,`) are used for grouping (*e.g.*, numbers are written as $1,500.25). You can explicitly change the characters that are used for decimal marks and groupings by setting changing the `grouping_mark` and `decimal_mark`, respectively. For example, if numbers are written in the European convention (*e.g.*, numbers are written as €1.500,25), you could set `locale=locale(grouping_mark=".", decimal_mark=",")`. 
```

Let's first try applying this function to a single value to see how it works:

```{code-cell}
:tags: [remove-output]
parse_number("$1,500.25")
```

```{code-cell}
:tags: [remove-input]
print(parse_number("$1,500.25"))
```

If our data is recorded in a different format, we can explicitly set the decimal mark and grouping characters in the `locale` argument so that the data is converted properly:

```{code-cell}
:tags: [remove-output]
parse_number("€1.500,25", locale=locale(grouping_mark=".", decimal_mark=","))
```

```{code-cell}
:tags: [remove-input]
print(parse_number("€1.500,25", locale=locale(grouping_mark=".", decimal_mark=",")))
```

To convert the entire `Salary` column to a `numeric`, we can apply `parse_number()` to the entire column, and then store the parsed values back into the `Salary` column:

```{code-cell}
employees$Salary <- parse_number(employees$Salary)
```

Now if we view the class of `Salary`, it will show `numeric`:

```{code-cell}
:tags: [remove-output]
class(employees$Salary)
```

```{code-cell}
:tags: [remove-input]
print(class(employees$Salary))
```

Finally, if we view the first few rows of our data frame with `head()`, we'll see that `Salary` no longer contains dollar signs, decimals, or commas:

```{code-cell}
head(employees)
```

## Fixing Date Variables

As you might expect, the tidyverse also has a `parse_date()` function that we can use to convert the `Start_Date` column to a `Date`. This function uses the following syntax:

```{admonition} Syntax
`tidyverse::parse_date(x, format="", ...)`
+ *Required arguments*
  - `x`: An atomic vector with values you would like to convert to a `Date`. 
+ *Optional arguments*
  - `format`: The format of the date. 
```

Because dates can be recorded in a variety of ways, R has a set of symbols that can be used to represent different date formats:

| Symbol | Meaning | Example |
| :-- | :-- | :-- |
| %d | day as a number | 01-31 |
| %a | abbreviated weekday | Mon |
| %A | unabbreviated weekday | Monday |
| %m | month (00-12) | 00-12 |
| %b | abbreviated month | Jan |
| %B | unabbreviated month | January |
| %y | 2-digit year | 07 |
| %Y | 4-digit year | 2007 |

*Source:* [here](https://www.statmethods.net/input/dates.html). 

Below we see some examples of the `parse_date()` function applied to dates of different formats:

```{code-cell}
:tags: [remove-output]
parse_date("25-06-99", format="%d-%m-%y")
```

```{code-cell}
:tags: [remove-input]
print(parse_date("25-06-99", format="%d-%m-%y"))
```

```{code-cell}
:tags: [remove-output]
parse_date("January 12, 2021", format="%B %d, %Y")
```

```{code-cell}
:tags: [remove-input]
print(parse_date("January 12, 2021", format="%B %d, %Y"))
```

```{code-cell}
:tags: [remove-output]
parse_date("08/18/95", format="%m/%d/%y")
```

```{code-cell}
:tags: [remove-input]
print(parse_date("08/18/95", format="%m/%d/%y"))
```

```{code-cell}
:tags: [remove-output]
parse_date("12Feb2003", format="%d%b%Y")
```

```{code-cell}
:tags: [remove-input]
print(parse_date("12Feb2003", format="%d%b%Y"))
```

Now we'll use the `format_date()` function to convert the entire `Start_Date` column to a `Date`. This column is coded as `month/day/year`, so the `format` of our date is `%m/%d/%Y`. 

```{code-cell}
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
```

Now if we view the class of `Start_Date`, it will show `Date`:

```{code-cell}
:tags: [remove-output]
class(employees$Start_Date)
```

```{code-cell}
:tags: [remove-input]
print(class(employees$Start_Date))
```