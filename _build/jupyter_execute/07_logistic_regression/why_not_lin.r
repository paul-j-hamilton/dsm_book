library(tidyverse)
library(ggplot2)
deposit <- read_csv("../_build/data/marketing.csv")

head(deposit)

depositLinear <- lm(subscription ~ duration, data = deposit)
summary(depositLinear)

suppressWarnings(print(ggplot(deposit, aes(x=duration, y=subscription)) + geom_point()  +
  geom_smooth(method='lm', se=F,size=2) + theme_bw() +
  xlim(-500, 3000) + ylim(-0.2, 1.2) +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"))))
