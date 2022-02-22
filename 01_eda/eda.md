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
employees <- read_csv("../_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
```

# Exploring Data

````{panels}
:column: col-4
:card: border-2
**Motivation**
^^^
Framiliarize yourself with the data and establish a common set of facts among all stakeholders. Answer basic descriptive questions and identify irregularities in the data.
---
**Methods**
^^^
+ Summary Statistics - Unambiguous, numerical measures of the data.
+ Visualization - Visual representations of data that tell a clear and compelling story.
---
**Message**
^^^
Present data-driven insights to stakeholders as clearly as possible. Complement domain-area expertise with quantitative evidence. Focus on producing insights that are actionable. 
````

One of the fundamental pillars of data science is to understand the data by visualizing it and computing basic descriptive summary statistics (*e.g.*, average, standard deviation, maximum, and minimum). This collection of techniques is typically referred to as **exploratory data analysis (EDA)**. Often, visualizing data is enough to answer basic descriptive questions (such as, which types of customers are buying different products?) devise more complex hypotheses about various relationships (such as, which types of customers are more likely to buy different products?) and identify irregularities (such as mistakes in the data collection or outlier data).

```{admonition} Why is this important?
The main purpose of EDA is to help look at data before making any assumptions. It can help identify obvious errors, as well as better understand patterns within the data, detect outliers or anomalous events, find interesting relations among the variables. Data scientists can use exploratory analysis to ensure the results they produce are valid and applicable to any desired business outcomes and goals. EDA also helps stakeholders by confirming they are asking the right questions. EDA can help answer questions about standard deviations, categorical variables, and confidence intervals. Once EDA is complete and insights are drawn, its features can then be used for more sophisticated data analysis or modeling, including machine learning.

*IBM, [Exploratory Data Analysis](https://www.ibm.com/cloud/learn/exploratory-data-analysis)*
```

Descriptive statistics of key business metrics are aggregations of data that should form the information backbone of every enterprise. For example, sales, revenue, and customer churn are all examples of business metrics. Creating meaningful visualizations and analyzing descriptive statistics is the first important step in addressing business problems with data.


```{admonition} How will this help me as a manager?
An understanding of EDA will help you: 

+ Develop a deeper understanding of key business metrics;
+ Examine assumptions and hypotheses more rigorously; 
+ Convince stakeholders of new insights through compelling visualizations.
```

In this chapter, we will explore EDA using the employee data introduced in the [R Bootcamp](../00_bootcamp/02_dataframes/dataframes.html#data-frames). This data contains information on 1,000 employees at a software company, and is stored in a data frame called `employees`:

```{code-cell}
:tags: [remove-input]
head(employees)
```

These variables are defined as follows:

+ `ID`: A unique ID for each employee.
+ `Name`: The name of each employee.
+ `Gender`: The gender of each employee.
+ `Age`: The age of each employee at the time the data were collected.
+ `Rating`: Each employee's rating from one to ten on their last performance evaluation.
+ `Degree`: The highest degree attained by the employee.
+ `Start_Date`: The date the employee started with the company.
+ `Retired`: Whether or not the employee is retired (`TRUE` / `FALSE`).
+ `Division`: The division the employee works in.
+ `Salary`: The employee's most recent yearly salary.