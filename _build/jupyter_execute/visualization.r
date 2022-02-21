library(tidyverse)
employees <- read_csv("_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
degreeLevels <- c("High School", "Associate's", "Bachelor's", "Master's", "Ph.D")
employees$Degree <- parse_factor(employees$Degree, levels = degreeLevels, ordered = TRUE)

hist(employees$Salary)

boxplot(employees$Salary)

boxplot(employees$Salary ~ employees$Degree)

plot(employees$Age, employees$Salary)

barplot(table(employees$Division))

barplotTable <- prop.table(table(employees$Gender,employees$Division), 2)
barplot(barplotTable, legend=rownames(barplotTable))

pie(table(employees$Division))
