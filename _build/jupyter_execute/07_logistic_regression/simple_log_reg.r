library(tidyverse)
library(ggplot2)
deposit <- read_csv("../_build/data/marketing.csv")

depositLog <- glm(subscription ~ duration, data = deposit, family = "binomial")
summary(depositLog)

suppressWarnings(print(ggplot(deposit, aes(x=duration, y=subscription)) + geom_point()  +
  geom_smooth(method='glm', se=F, method.args = list(family=binomial), size=2) + theme_bw() +
  xlim(-500, 3000) + ylim(-0.2, 1.2) +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"))))

newData <- data.frame(duration = 2500)
predict(depositLog, newData, type = "response")

print(predict(depositLog, newData, type = "response"))

depositLogDummy <- glm(subscription ~ loan, data = deposit, family = "binomial")
summary(depositLogDummy)
