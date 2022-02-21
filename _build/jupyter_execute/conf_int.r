library(tidyverse)
employees <- read_csv("_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
degreeLevels <- c("High School", "Associate's", "Bachelor's", "Master's", "Ph.D")
employees$Degree <- parse_factor(employees$Degree, levels = degreeLevels, ordered = TRUE)

binom.test(30, 100)

t.test(employees$Salary)

maleEmployees <- filter(employees, Gender=="Male")
t.test(maleEmployees$Salary)

femaleEmployees <- filter(employees, Gender=="Female")
t.test(femaleEmployees$Salary)
