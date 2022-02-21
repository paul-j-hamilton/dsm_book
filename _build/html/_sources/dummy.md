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
employees$Degree<-as.factor(employees$Degree)
employees <- within(employees, Degree <- relevel(Degree, ref = "High School"))
modelAge <- lm(Salary ~ Age, data=employees)
```

# Dummy Variables

So far we have been modeling `Salary` as a function of `Age` and `Rating`, which are both quantitative variables. However, there are also categorical variables in our data set that we might want to include in the model. For example, we might be interested in exploring whether there is a gender bias in our salary data. To do this, we need to somehow include `Gender` as an independent variable in our regression. However, this variable is not measured numerically; it takes on the values "Male" or "Female". How, then, can we include it in our regression model?

To do this we need to create a **dummy variable**, or a binary, quantitative variable that is used to represent categorical data. Dummy variables use the numeric quantities `0` and `1` to represent the categories of interest. In our case our categorical variable is `Gender`, so our dummy needs to encode one of the genders as `0` and the other as `1`. (Note that it is largely arbitrary which category we assign to `1` and which we assign to `0`.) Let's create a new variable in our data set called `male_dummy`, which equals `1` if the employee is male and `0` if the employee is female:

```{code-cell}
employees$male_dummy <- ifelse(employees$Gender == "Male", 1, 0)
head(employees)
```

Now that we've created a dummy variable for gender, we can add it to our regression model:

```{code-cell}
modelMaleDummy <- lm(Salary ~ Age + Rating + male_dummy, data = employees)
summary(modelMaleDummy)
```

This produces the following estimated regression equation:

$$predicted \;salary = \hat{y} = \$27,047.67 + \$1,964.33(Age)  + \$5,520.34(Rating)   + \$8,278.08(male\_dummy)$$

The interpretation of the coefficients on `Age` and `Rating` are the same as before; for example, we would say that on average, salary goes up by \$5,520.34 for each additional point in an employee's rating, assuming all other variables in the model are kept constant. However, a similar interpretation would not be possible for the coefficient on `male_dummy`, as this variable can only take on the values `0` and `1`. Instead we interpret this coefficient as follows: on average, men at the company are paid \$8,278.08 more than women at the company, assuming all other variables in the model are kept constant. Because the p-value on this coefficient is quite small, we might conclude from these results that there does appear to be a gender bias in the company's salary data.

To better understand the coefficient on the dummy variable, consider two employees, one male and one female. Assume that they are both 35, and both received an 8 in their last performance evaluation. For the male employee, our model would predict his salary to be:

$$\begin{aligned}predicted \;salary = \hat{y} & =  \$27,047.67 + \$1,964.33(35)  + \$5,520.34(8)   + \$8,278.08(1) \\ & = \$139,961.94 + \$8,278.08(1)  \\ & = \$148,240.02 \end{aligned}$$

Conversely, for the female employee, our model would predict her salary to be:

$$\begin{aligned}predicted \;salary = \hat{y} & =  \$27,047.67 + \$1,964.33(35)  + \$5,520.34(8)   + \$8,278.08(0) \\ & = \$139,961.94 + \$8,278.08(0)  \\ & = \$139,961.94 \end{aligned}$$

From this example we can see that when the other variables are held constant, the difference between the predicted salary for men and women is the value of the coefficient on our dummy variable (\$8,278.08).

In this example, we manually created a dummy variable for gender (called `male_dummy`) and used that variable in our model. However, this was not actually necessary - the `lm()` function automatically converts any categorical variables you include into dummy variables behind the scenes. If we specify our model as before but include `Gender` instead of `male_dummy`, we get the same results:

```{code-cell}
modelMaleDummy <- lm(Salary ~ Age + Rating + Gender, data = employees)
summary(modelMaleDummy)
```

Dummy variables are relatively straightforward for *binary* categorical variables such as `Gender`. But what about a variable like `Degree`, which can take on several different values (`"High School"`, `"Associate's"`, `"Bachelor's"`, `"Master's"`, and `"Ph.D"`)? It might be natural to assume that you could just assign a unique integer to each category. In other words, our dummy for degree could represent "High School" as 0, "Associate's" as 1, "Bachelor's" as 2, "Master's" as 3, and "Ph.D" as 4. However, this method of coding categorical variables is problematic. First, it implies an ordering to the categories that may not be correct. There might be an ordering to `Degree`, but consider the `Division` variable; there is no inherent ordering to the divisions of a company, so any ordering implied by a dummy variable would be arbitrary. Second, this method of coding implies a fixed difference between each category. There is no reason to believe that the difference between an associate's and a bachelor's is the same as the difference between a bachelor's and a master's, for example. 

How, then, do we incorporate multinomial categorical variables into our regression model? The answer is by creating separate 0 / 1 dummy variables for each of the variable's categories. For example, we will need one dummy variable (`DegreeAssociate's`) that equals `1` for observations where `Degree` equals "Associate's", and `0` if not. We will need another dummy variable (`DegreeBachelor's`) that equals `1` for observations where `Degree` equals "Bachelor's" and `0` if not, and so on. The table below shows how all possible values of `Degree` can be represented through four binary dummy variables:

<table class=" lightable-classic-2" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; width: auto !important; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;"> Degree </th>
   <th style="text-align:center;"> DegreeAssociate's </th>
   <th style="text-align:center;"> DegreeBachelor's </th>
   <th style="text-align:center;"> DegreeMaster's </th>
   <th style="text-align:center;"> DegreePh.D </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> High School </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Associate's </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bachelor's </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Master's </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ph.D </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
</tbody>
</table>

Note that we do *not* need a fifth dummy variable to represent the "High School" category. This is because this information is already implicitly captured in the other four dummy variables; if `DegreeAssociate's`, `DegreeBachelor's`, `DegreeMaster's`, and `DegreePh.D` all equal zero, we know the employee must hold a high school diploma, so there is no need for an additional `DegreeHighSchool` variable. In general, a $k$-category variable can be represented with $k-1$ dummy variables. 

```{warning}
For regression modeling, categorical variables that take on $k$ values must be converted into $k-1$ binary dummy variables.
```

As noted above, the `lm()` command automatically creates dummy variables behind the scenes, so we can simply include `Degree` in our call to `lm()`:

```{code-cell}
modelDegree <- lm(Salary ~ Age + Rating + Gender + Degree, data = employees)
summary(modelDegree)
```

To interpret the coefficients on the dummy variables for degree, we must first acknowledge that they are all relative to the implicit baseline category, `"High School"`. The baseline (or reference) category is the one that is not given its own dummy variable; in this case we do not have a separate dummy for `"High School"`, so it is our baseline. With this in mind, we interpret the coefficients on our dummy variables as follows:

+ On average, employees with an Associate's degree are paid \$9,477.56 more than employees with a high school diploma, assuming all other variables in the model are kept constant.
+ On average, employees with a Bachelor's degree are paid \$33,065.81 more than employees with a high school diploma, assuming all other variables in the model are kept constant.
+ On average, employees with an Master's degree are paid \$40,688.57 more than employees with a high school diploma, assuming all other variables in the model are kept constant.
+ On average, employees with a Ph.D are paid \$53,730.61 more than employees with a high school diploma, assuming all other variables in the model are kept constant.
