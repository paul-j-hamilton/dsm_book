library(tidyverse)
employees <- read_csv("_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
degreeLevels <- c("High School", "Associate's", "Bachelor's", "Master's", "Ph.D")
employees$Degree <- parse_factor(employees$Degree, levels = degreeLevels, ordered = TRUE)

head(employees)

plot(employees$Age, employees$Salary, 
        main="Salary vs Age",
        xlab="Age",
        ylab="Salary")

cor(employees$Age, employees$Salary, use = "complete.obs")

print(cor(employees$Age, employees$Salary, use = "complete.obs"))

cor.test(employees$Age, employees$Salary)

cor(employees[,c("Age", "Rating", "Salary")], use = "complete.obs")
