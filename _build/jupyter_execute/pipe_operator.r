library(tidyverse)

# Read in data
employees <- read_csv("_build/data/employee_data.csv")

# Step 1
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format="%m/%d/%Y")

# Step 2
employeesCollege <- filter(employees, Degree %in% c("Bachelor's", "Master's", "Ph.D"), !is.na(Salary))

# Step 3
employeesTargetCols <- select(employeesCollege, Degree, Salary)

# Step 4
employeesWithRankSorted <- arrange(employeesTargetCols, desc(Salary))

head(employeesWithRankSorted)

# Read in the data 
employees <- read_csv("_build/data/employee_data.csv")

employeesWithRankSortedPipe <- employees %>%

     mutate(Salary = parse_number(Salary),                                           # Step 1
            Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")) %>%

     filter(Degree %in% c("Bachelor's", "Master's", "Ph.D"), !is.na(Salary)) %>%     # Step 2

     select(Degree, Salary) %>%                                                      # Step 3

     arrange(Salary)                                                             # Step 4

head(employeesWithRankSortedPipe)
