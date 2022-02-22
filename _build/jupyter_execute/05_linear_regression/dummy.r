library(tidyverse)
employees <- read_csv("../_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
employees$Degree<-as.factor(employees$Degree)
employees <- within(employees, Degree <- relevel(Degree, ref = "High School"))
modelAge <- lm(Salary ~ Age, data=employees)

employees$male_dummy <- ifelse(employees$Gender == "Male", 1, 0)
head(employees)

modelMaleDummy <- lm(Salary ~ Age + Rating + male_dummy, data = employees)
summary(modelMaleDummy)

modelMaleDummy <- lm(Salary ~ Age + Rating + Gender, data = employees)
summary(modelMaleDummy)

modelDegree <- lm(Salary ~ Age + Rating + Gender + Degree, data = employees)
summary(modelDegree)
