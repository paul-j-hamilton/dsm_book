library(tidyverse)
employees <- read_csv("../../_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")

employeesSortedAge <- arrange(employees, Age)
head(employeesSortedAge)

tail(employeesSortedAge)

employeesSortedAgeDesc <- arrange(employees, desc(Age))
head(employeesSortedAgeDesc)

tail(employeesSortedAgeDesc)

employeesSortedAgeDescName <- arrange(employees, desc(Age), Name)
head(employeesSortedAgeDescName)

tail(employeesSortedAgeDescName)
