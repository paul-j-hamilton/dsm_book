library(tidyverse)
employees <- read_csv("_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")

table(employees$Division)

prop.table(table(employees$Division))

table(employees$Division, employees$Degree)

prop.table(table(employees$Division, employees$Degree))

prop.table(table(employees$Division, employees$Degree), margin = 1)

prop.table(table(employees$Division, employees$Degree), margin = 2)
