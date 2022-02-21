library(tidyverse)
employees <- read_csv("_build/data/employee_data.csv")
employees$Salary <- parse_number(employees$Salary)
employees$Start_Date <- parse_date(employees$Start_Date, format = "%m/%d/%Y")
degreeLevels <- c("High School", "Associate's", "Bachelor's", "Master's", "Ph.D")
employees$Degree <- parse_factor(employees$Degree, levels = degreeLevels, ordered = TRUE)
carbs <- read.csv("_build/data/carbs.csv")

binom.test(540, 1000, p = 0.5, alternative = "greater")

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
