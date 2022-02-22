library(tidyverse)
employees <- read_csv("../_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")

mean(employees$Salary, na.rm = TRUE)

print(mean(employees$Salary, na.rm = TRUE))

median(employees$Salary, na.rm = TRUE)

print(median(employees$Salary, na.rm = TRUE))

quantile(employees$Salary, na.rm = TRUE)

print(quantile(employees$Salary, na.rm = TRUE))

sd(employees$Salary, na.rm = TRUE)
var(employees$Salary, na.rm = TRUE)

print(sd(employees$Salary, na.rm = TRUE))
print(var(employees$Salary, na.rm = TRUE))

table(employees$Division)

prop.table(table(employees$Division))

table(employees$Division, employees$Degree)

prop.table(table(employees$Division, employees$Degree))

prop.table(table(employees$Division, employees$Degree), margin = 1)

prop.table(table(employees$Division, employees$Degree), margin = 2)
