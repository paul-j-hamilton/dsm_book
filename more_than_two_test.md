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
carbs <- read.csv("_build/data/carbs.csv")
```

# Hypothesis Testing with More Than Two Samples (&#9909;)

This section is optional, and will not be covered in the DSM course. Select "Click to show" to reveal. 

## Testing Means (ANOVA)

If we want to compare the means of more than two groups, one procedure available is called **Analysis of Variance (ANOVA)**. The name seems strange because we are comparing means, but the word variance comes from the fact that this procedure makes a relatively strong assumption that the variability in each group we are comparing is the same. A rule of thumb when using ANOVA is that the ratio of the largest standard deviation of the groups to the smallest standard deviation should be no more than three.

The null hypothesis for ANOVA is that the means of all our groups are the same. The alternative is that there are at least two groups that have different means. If we reject the null hypothesis we need to do further analyses to see where the differences exist.

To understand when one might use ANOVA, consider the following example. Builder's Buddy, a nationwide home improvement chain, would like to not only sell you a water heater, they would also like to install it for you. The four service centers the company runs are organized by regional markets. One question of interest is whether the employees’ training is similar in the four different markets so that the install time is roughly consistent around the country. Builder's Buddy collected data from these four different markets on the amount of time it took (in minutes) to install a standard 40-gallon water heater. That data is saved in a data frame called `waterData`, and the first few observations are shown below:

```{code-cell}
:tags: [remove-input]
waterData <- read.csv("_build/data/waterheater.csv")
set.seed(201)
head(sample_n(waterData, 6))
```

Our null and alternative hypotheses for the ANOVA test are:

+ $H_o$: The mean install time is the same for all four cities.
+ $H_a$: The mean install time is *not* the same for all four cities.

We can use `summary(aov())` to calculate the appropriate p-value in R:

```{admonition} Syntax
`summary(aov(df$var ~ df$group))`
+ *Required arguments*
  - `df$var`: The variable of interest (*i.e.*, the variable we are comparing across the groups).
  - `df$group`: The group each observation belongs to.
```

Applying this to our sample data:

```{code-cell}
summary(aov(waterData$Time ~ waterData$City))
```

ANOVA runs what is called an F-test, and we find from the output for our observed data the resulting p-value for this test is 0.3276. This is not below 0.05, so we fail to reject the null hypothesis that the mean install time in each city is the same. Formally, there is not enough evidence to conclude that the samples came from distributions with different means.

What if we obtain a relatively small p-value and end up rejecting the null hypothesis? We would then want to do further analysis to see where the differences in means exist. The following example shows how to do that.

**Example** An experiment was conducted as follows. In three similar cities an advertisement campaign was launched. In each city only one of the three characteristics (convenience, quality, and price) was emphasized. The weekly sales were recorded for twenty weeks following the beginning of the campaigns. The data is saved in a data frame called `sales`, and the first few observations are shown below. 

```{code-cell}
:tags: [remove-input]
sales <- read.csv("_build/data/juicebox.csv")
set.seed(202)
head(sample_n(sales, 6))
```

Our null and alternative hypotheses for this test are:

+ $H_o$: The mean sales are the same for the three advertisement campaigns.
+ $H_a$: The mean sales are *not* the same for the three advertisement campaigns.

Applying this to our sample data:

```{code-cell}
summary(aov(sales$sales ~ sales$emphasis))
```

The relatively low p-value of 0.0468 implies the observed data is not consistent with the null hypothesis of equal means. Therefore, we conclude that it appears not all the mean responses are the same.

The question then is where do the means differ? Before we can answer this question, we need to be aware of the **multiple testing** problem. When performing multiple hypothesis tests at the same time, the chance of making a Type I error (*i.e.*, rejecting the null hypothesis when it is actually true) increases greatly from the traditional 5%, depending on how many tests are performed. For example, if one ran three hypothesis tests at the same time, the overall Type I error would increase from 5% to 14%, even though each individual test is done at the 5% level. There are corrections to p-values that can be applied when performing multiple tests to correct for this issue. More information about this can be found [here](https://www.stat.berkeley.edu/~mgoldman/Section0402.pdf). The `pairwise.t.test()` command runs all possible two-sample t-tests, and reports p-values adjusted for the multiple comparison problem:

```{admonition} Syntax
`pairwise.t.test(df$var, df$group, p.adjust.method)`
+ *Required arguments*
  - `df$var`: The variable of interest (*i.e.*, the variable we are comparing across the groups).
  - `df$group`: The group each observation belongs to.
+ *Optional arguments*
  - `p.adjust.method`: The method used to adjust the p-values to account for multiple testing. We will use a method called the **Bonferroni correction** (see [here](https://en.wikipedia.org/wiki/Bonferroni_correction)), so we will set this parameter equal to `"bonf"`.
```

Applying this to our sample data:

```{code-cell}
pairwise.t.test(sales$sales, sales$emphasis, p.adjust.method = "bonf")
```

The numbers printed in the table within the output (0.904, 0.043, and 0.428) are the bonferroni-adjusted p-values. From this output we see the difference in sales occurred between the quality and convenience groups, as this is the only adjusted p-value below 0.05. 

## Testing Proportions (Chi-Square)

Research in business often generates frequency (count) data. This is certainly the case in most opinion surveys in which the person interviewed is asked to respond to a question by marking, say "Agree", "Not Sure", or "Disagree", or some other such collection of categories. In a case like this, the investigator might be concerned with determining what proportion of respondents marked each of the choices or whether there is any relationship between the opinion marked and the sex, age, or occupation of the respondent.

Chi-square methods make possible the meaningful analysis of frequency data by permitting the comparison of frequencies actually observed with frequencies which would be expected if the null hypothesis were true. At first glance the chi-square test procedures can be confusing as there are two different tests with very similar names.

+ **Chi-Square Goodness of Fit Test:** this is used to test if counts in different categories follow a specified distribution.
+ **Chi-Square Test of Independence:** this is used to test if two categorical variables are independent or dependent.

Using examples, we will investigate each of these tests in turn below.

**Goodness-of-Fit**

Suppose that the Bar Galaxy Chocolate Co. wants to determine if customers have a preference for any of the following four candy bars. From a random sample of 200 people, it was found that:

1. 43 preferred The Frosty Bar
2. 53 preferred Galaxy’s Milk Chocolate
3. 60 preferred Galaxy’s Special Dark Chocolate
4. 44 preferred Munchies Bar

For the goodness-of-fit test, the null hypothesis states that customers have no preference for any of the four candy bars (1, 2, 3, and 4). That is, all four candy bars are equally preferred. The alternative hypothesis states that the preference probabilities are not all the same. Formally:

+ $H_o$: $p_1 = p_2 = p_3 = p_4 = 0.25$

+ $H_a$: The data do not follow the distribution specified in $H_o$. 

The goodness-of-fit test is easily run in R with `chisq.test()`. The data we need to give the command are the observed counts (`x`) and the hypothesized proportions under the null (`p`):

```{admonition} Syntax
`chisq.test(x = c(x1, x2, x3, x4), p = c(p1, p2, p3, p4))`
+ *Required arguments*
  - `x`: A vector with the observed counts in each group.
  - `n`: A vector with the hypothesized proportions of each group under the null.
```
  
Applying this to our Bar Galaxy sample data:

```{code-cell}
chisq.test(x = c(43, 53, 60, 44), p = c(0.25, 0.25, 0.25, 0.25))
```

Since the p-value (0.27) is quite large, there is insufficient evidence to reject the null hypothesis. That is, we cannot conclude that there appears to be a candy bar preference.

**Test of Independence**

A contingency table is a cross classification of two categorical variables. The **Chi-Square Test of Indepence** sees if there is an association between categorical variables. 

As an example, the Wall Street Journal Subscriber Study has data on the employment status of subscribers. We have data on sample results corresponding to subscribers of the Eastern and Western editions as well as employment status. This data is stored in a data frame called `wsj`, and the first few observations are shown below. 

```{code-cell}
:tags: [remove-input]
wsj <- read.csv("_build/data/wsj_table.csv")
set.seed(202)
head(sample_n(wsj, 6))
```

Using `prop.table()`, we can tabulate subscribers' employment status by Easter and Western edition: 

```{code-cell}
prop.table(table(wsj$status, wsj$region), 2)
```

The proportions between regions seem similar, but we can formally check to see whether they are the same by running a chi-square test of independence. For this test, our null and alternative hypotheses would be:

+ $H_o:$ There is no association between employment status and region. 

+ $H_a:$ There is an association between employment status and region. 

To run this in R we can use the same `chisq.test()` function we saw before: 

```{admonition} Syntax
`chisq.test(df$var1, df$var2)`
+ *Required arguments*
  - `df$var1`, `df$var2`: The two categorical variables in the data frame `df` being compared.
```
  
Applying this to our Wall Street Journal data:

```{code-cell}
chisq.test(wsj$status, wsj$region)
```

The proportions per region do appear to be different and this is confirmed by the small p-value from the Chi-square test. The null hypothesis of independence is rejected, implying there is a relationship between employment status and edition of the newspaper.
