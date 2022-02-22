library(tidyverse)
employees <- read_csv("../../_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")

retiredEmployees <- filter(employees, Retired == TRUE)
head(retiredEmployees)
dim(retiredEmployees)

dim(retiredEmployees)

print(dim(retiredEmployees))

employeesSub <- filter(employees, 
                       Retired == FALSE, Start_Date >= "1995-01-01", Division != "Operations")
head(employeesSub)
dim(employeesSub)

dim(employeesSub)

print(dim(employeesSub))

employeesSubOr <- filter(employees, 
                         Degree == "Master's" | Start_Date <= "2000-12-31" | Salary < 100000)
head(employeesSubOr)
dim(employeesSubOr)

dim(employeesSubOr)

print(dim(employeesSubOr))

employeesGrad <- filter(employees, Degree == "Master's" | Degree == "Ph.D")
head(employeesGrad)
dim(employeesGrad)

dim(employeesGrad)

print(dim(employeesGrad))

employeesCollege <- filter(employees, Degree %in% c("Bachelor's", "Master's", "Ph.D"))
head(employeesCollege)
dim(employeesCollege)

dim(employeesCollege)

print(dim(employeesCollege))

employees100k <- filter(employees, Salary >= 100000)
head(employees100k)

employees100kNA <- filter(employees, Salary >= 100000 | is.na(Salary))
head(employees100kNA)

tail(employees100kNA)
