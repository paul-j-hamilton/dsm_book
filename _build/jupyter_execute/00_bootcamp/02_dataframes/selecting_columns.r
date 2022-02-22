library(tidyverse)
employees <- read_csv("../../_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")

employeesTargetCols <- select(employees, Degree, Division, Salary)
head(employeesTargetCols)

employeesExcludedCols <- select(employees, -Age, -Retired)
head(employeesExcludedCols)
