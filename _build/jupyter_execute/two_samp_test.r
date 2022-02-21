library(tidyverse)
employees <- read_csv("_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
degreeLevels <- c("High School", "Associate's", "Bachelor's", "Master's", "Ph.D")
employees$Degree <- parse_factor(employees$Degree, levels = degreeLevels, ordered = TRUE)
carbs <- read.csv("_build/data/carbs.csv")

gss <- read.csv("_build/data/gss_data.csv")
head(gss[,c("ID", "WRKGOVT", "HRS", "INCOME", "CUREMPYR")])

t.test(gss$INCOME ~ gss$WRKGOVT, alt = "greater")

t.test(gss$CUREMPYR ~ gss$WRKGOVT)

t.test(carbs$carb_only, carbs$carb_protein, alt = "less")

# In red, plot the distance run by each runner after the carb-only drink
plot(1:nrow(carbs), carbs$carb_only, col="red",
      xlab="Runner", ylab="Distance")
# In green, plot the distance run by each runner after the carb-protein drink      
points(1:nrow(carbs), carbs$carb_protein, col="green")
# Add a legend
legend("topleft", pch=c(1,1), col=c("red", "green"), legend=c("Carb Only", "Carb Protein"))
# Draw a line between the carb-only and carb-protein distance for each runner
for(i in 1:nrow(carbs)) {
  if (carbs$carb_protein[i]>carbs$carb_only[i]){
    lines(c(i,i),c(carbs$carb_only[i],carbs$carb_protein[i]),col="green")
  }
  if (carbs$carb_protein[i]<=carbs$carb_only[i]){
    lines(c(i,i),c(carbs$carb_only[i],carbs$carb_protein[i]),col="red")
  }
}

t.test(carbs$carb_only, carbs$carb_protein, alt = "less", paired = TRUE)

prop.test(x = c(45, 48), n = c(75, 90))
