library(tidyverse)
library(ggplot2)
deposit <- read_csv("../_build/data/marketing.csv")

depositLogMultiple <- glm(subscription ~ duration + campaign + loan + marital, 
                          data = deposit, family = "binomial")
summary(depositLogMultiple)
