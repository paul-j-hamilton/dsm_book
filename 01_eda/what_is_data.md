---
jupytext:
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  display_name: R
  language: R
  name: ir
---

```{code-cell}
:tags: [remove-cell]
library(tidyverse)
employees <- read_csv("../_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
```

# What Is Data?

In this note, we define data as any recorded information. In our application, data is used to inform business decisions. All of the following are examples of data that a company might collect:
+ Customer purchasing behavoirs;
+ The demographic characteristics of customers;
+ Quarterly sales figures;
+ Tweets describing customers' experiences with a given product;
+ Real-time information on the heart rate of customers wearing a smart device. 

The term “data” is constantly evolving and expanding; data can be anything from spreadsheets to videos and images to audio files! Nevertheless, we classify data into two main types: structured and unstructured data. **Structured data** refers to information that is stored in a consistent, well-defined format such that it can be analyzed without extensive processing.  A basic example of structured data is an Excel file that recorded the weekly sales of widgets over several years. Conversely, **unstructured data** does not follow a consistent format and is stored in a way that makes it difficult to analyze without extensive processing. For example, image data, such as pictures of the lines at different registers in a grocery store throughout the day, is typically considered unstructured data. In general, structured data is much more useful for the applications covered in this note. Additionally, unstructured data can often be represented as structured data; in the previous example, we do not care about the pictures themselves so much as the waiting times of customers in the grocery store lines, which could be represented as a structured data set. Therefore, this note will focus on structured data.

The most basic form of structured data is tabular data, which is characterized by rows and columns. You are already familiar with tabular data if you have ever worked with an Excel spreadsheet. For example, in the figure below, we have a data set with information on 1,000 employees from a software company. For convenience, we only display the first few rows of the data. By convention, the observations (*i.e.*, the employees) form the rows of the data set, and the variables (*i.e.*, the characteristics of the employees we are measuring) form the columns. The dimensions of the data set are typically written as $n x m$ (read as "n-by-m"), where $n$ is the number of observations (or rows) and $m$ is the number of variables (or columns). 

```{code-cell}
:tags: [remove-input]
head(employees)
```

This example illustrates the different types of information storable in a tabular data set. For instance, some of the columns, such as `Degree` and `Division`, take on a fixed, discrete set of values. These types of variables are known as **categorical variables**. The `Retired` variable is also a categorical variable, but since it takes on precisely two values (`TRUE` and `FALSE`) it's often called a **binary** (or **boolean**) **variable**. On the other hand, the `Salary` column is a **quantitative variable** because it is measured numerically and takes on many values. Finally, notice that some of the cells in the above table are `NA`; these are referred to as **missing data** and will be discussed further below.

Directly examining the data set is an important start, but typically, we can gain additional insights by summarizing the data. The methods used to summarize data depend on whether the variable is categorical or quantitative; therefore, each section is divided into a subsection for quantitative and categorical variables for the remainder of this note. 

## Data Lineage

Before analyzing the data, it is vital to understand how the data were generated and collected.  Collectively, we call this information the lineage of the data. This is key for understanding how the data can be used, what limitations the data might have, and what methods of analysis are appropriate. Keeping track of a data set’s lineage is a collaborative effort between managers, data scientists, business analysts, etc., and requires good documentation and organization practices. 

### Data Generating Process

Data lineage begins with an understanding of the **data generating process (DGP)**, which is the fundamental mechanism by which the data were produced. Often, it is impossible to precisely know the exact DGP that generated our data, so we make approximations and assumptions about the data which must be well documented and understood by all stakeholders. 

### Data Collection

#### Why were the data collected?

#### Who collected the data, and who do the data represent?

#### Where are the data stored? 

#### When were the data collected?

## Missing Data

Most modern data sets are likely to have missing values. Good data practice requires that missing values are indicated in a unique way, such as with a symbol like `NA` or a null entry. Using a numeric value such as -1 or 99 to indicate missing values can be dangerous and is not encouraged.

To determine the best strategy for handling missing values, we need to understand how the missing values were created. Typically, this requires examining the pattern that the missing data forms. If there are no discernable patterns, we say that the missing data are missing completely at random (MCAR). For example, imagine that the entire data set was printed on a large sheet of paper with no missing values, then someone accidentally dropped random spots of ink on the paper so that some values were hidden. If the data are MCAR, a complete case analysis (where rows with missing data are ignored) will produce valid results. On the other hand, if there are patterns in the missing data, we need to apply more advanced statistical techniques that are not covered in this course. An example of a pattern would be seeing that taller people failed to report their weight at a higher rate.