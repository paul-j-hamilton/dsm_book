library(tidyverse)
employees <- read_csv("_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
degreeLevels <- c("High School", "Associate's", "Bachelor's", "Master's", "Ph.D")
employees$Degree <- parse_factor(employees$Degree, levels = degreeLevels, ordered = TRUE)
modelAge <- lm(Salary ~ Age, data=employees)

confint(modelAge)

summary(modelAge)

newData <- data.frame(Age = 40)
predict(modelAge, newData, interval = "predict")

plot(modelAge, which=1)

hist(residuals(modelAge))

plot(modelAge, which = 2)
