library(tidyverse)
employees <- read_csv("../_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
degreeLevels <- c("High School", "Associate's", "Bachelor's", "Master's", "Ph.D")
employees$Degree <- parse_factor(employees$Degree, levels = degreeLevels, ordered = TRUE)

modelAgeRating <- lm(Salary ~ Age + Rating, data=employees)
summary(modelAgeRating)

plot(modelAgeRating, which = 1)

hist(residuals(modelAgeRating))
plot(modelAgeRating, which = 2)
