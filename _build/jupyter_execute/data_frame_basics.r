library(tidyverse)
employees <- read_csv("_build/data/employee_data.csv")

nrow(employees)

print(nrow(employees))

ncol(employees)

print(ncol(employees))

dim(employees)

print(dim(employees))

head(employees)

print(head(employees))

tail(employees)

print(tail(employees))

str(employees)

print(str(employees))

mean(employees$Age)
min(employees$Age)
max(employees$Age)

print(mean(employees$Age))
print(min(employees$Age))
print(max(employees$Age))
