library(tidyverse)
employees <- read_csv("_build/data/employee_data.csv")

parse_number("$1,500.25")

print(parse_number("$1,500.25"))

parse_number("€1.500,25", locale=locale(grouping_mark=".", decimal_mark=","))

print(parse_number("€1.500,25", locale=locale(grouping_mark=".", decimal_mark=",")))

employees$Salary <- parse_number(employees$Salary)

class(employees$Salary)

print(class(employees$Salary))

head(employees)

parse_date("25-06-99", format="%d-%m-%y")

print(parse_date("25-06-99", format="%d-%m-%y"))

parse_date("January 12, 2021", format="%B %d, %Y")

print(parse_date("January 12, 2021", format="%B %d, %Y"))

parse_date("08/18/95", format="%m/%d/%y")

print(parse_date("08/18/95", format="%m/%d/%y"))

parse_date("12Feb2003", format="%d%b%Y")

print(parse_date("12Feb2003", format="%d%b%Y"))

employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")

class(employees$Start_Date)

print(class(employees$Start_Date))
