library(pwr)
library(purrr)

inv.logit <- function(x) {
    1 / (1 + exp(-x))
}

data_causal_inf <- function(n, tau = 1, b = 2, base = 100) {
    ## DGP
    age <- rnbinom(n, 10, 0.3)
    ps <- inv.logit(0.2*(age- mean(age)))
    Y0s <- round(base + b * age + rnorm(n, 0, 3))
    Y1s <- round(Y0s + tau)
    Z <- map_dbl(ps, ~ sample(c(0,1), 1, F, c(1-., .)))
    Y <- Z * Y1s + (1-Z) * Y0s
    return(list(age = age, Y = Y, Z = Z, ps = ps))
}

data_causal_inf_rand_exp <- function(n, tau = 1, b = 2, base = 100) {
    ## DGP
    age <- rnbinom(n, 10, 0.3)
    ps <- inv.logit(0.2*(age- mean(age)))
    Y0s <- round(base + b * age + rnorm(n, 0, 3))
    Y1s <- round(Y0s + tau)
    Z <- rbinom(n, 1, 0.5)
    Y <- Z * Y1s + (1-Z) * Y0s
    return(list(age = age, Y = Y, Z = Z, ps = ps))
}

set.seed(7)
n <- 500

causal_int_obs <- data_causal_inf(n, tau = 0.9123, b = - 1.0314)

Age <- causal_int_obs$age; StreamingMinutes <- causal_int_obs$Y; AccountType <- ifelse(causal_int_obs$Z, "Premium", "Free")
musicfi <- data.frame(Age, AccountType, StreamingMinutes)

causal_int_obsrand <- data_causal_inf_rand_exp(n=500, tau = 0.9123, b = - 0.5314)

Age <- causal_int_obsrand$age; StreamingMinutes <- causal_int_obsrand$Y; AccountType <- ifelse(causal_int_obsrand$Z, "Premium", "Free")
musicfiExp <- data.frame(Age, AccountType, StreamingMinutes)

# Create separate data frames for free and premium users
musicfiExpFree = subset(musicfiExp, AccountType=="Free")
musicfiExpPremium = subset(musicfiExp, AccountType=="Premium")

# Calculate the sample standard deviation of streaming minutes for free and premium users
s0 = sd(musicfiExpFree$StreamingMinutes)
s1 = sd(musicfiExpPremium$StreamingMinutes)

# Calculate the estimate of the pooled standard deviation
s = sqrt((s0^2 + s1^2)/2)

d = 2/s

pwr.t.test(d=d, power=0.8)
