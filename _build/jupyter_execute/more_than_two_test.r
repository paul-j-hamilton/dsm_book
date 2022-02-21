library(tidyverse)
employees <- read_csv("_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
degreeLevels <- c("High School", "Associate's", "Bachelor's", "Master's", "Ph.D")
employees$Degree <- parse_factor(employees$Degree, levels = degreeLevels, ordered = TRUE)
carbs <- read.csv("_build/data/carbs.csv")

waterData <- read.csv("_build/data/waterheater.csv")
set.seed(201)
head(sample_n(waterData, 6))

summary(aov(waterData$Time ~ waterData$City))

sales <- read.csv("_build/data/juicebox.csv")
set.seed(202)
head(sample_n(sales, 6))

summary(aov(sales$sales ~ sales$emphasis))

pairwise.t.test(sales$sales, sales$emphasis, p.adjust.method = "bonf")

chisq.test(x = c(43, 53, 60, 44), p = c(0.25, 0.25, 0.25, 0.25))

wsj <- read.csv("_build/data/wsj_table.csv")
set.seed(202)
head(sample_n(wsj, 6))

prop.table(table(wsj$status, wsj$region), 2)

chisq.test(wsj$status, wsj$region)
