library(tidyverse)
employees <- read_csv("_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
degreeLevels <- c("High School", "Associate's", "Bachelor's", "Master's", "Ph.D")
employees$Degree <- parse_factor(employees$Degree, levels = degreeLevels, ordered = TRUE)
offices <- read.csv("_build/data/office.csv")
employees <- inner_join(employees, offices, by="ID")

summarise(employees,  meanSalary = mean(Salary, na.rm = TRUE),
                          sdSalary = sd(Salary, na.rm = TRUE),
                          minAge = min(Age),
                          maxAge = max(Age))

summarise(employees,  meanSalary = mean(Salary, na.rm = TRUE),
                          sdSalary = sd(Salary, na.rm = TRUE),
                          minAge = min(Age),
                          maxAge = max(Age),
                          nObs = n())

employees %>%

  group_by(office) %>%

  summarise(meanSalary = mean(Salary, na.rm=TRUE),
            sdSalary = sd(Salary, na.rm=TRUE),
            minAge = min(Age),
            maxAge = max(Age),
            nObs = n())

employees %>%

  group_by(office, Gender) %>%

  summarise(meanSalary = mean(Salary, na.rm=TRUE),
            sdSalary = sd(Salary, na.rm=TRUE),
            minAge = min(Age),
            maxAge = max(Age),
            nObs = n())
