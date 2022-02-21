v4 <- c(2, 3, 4, 5)                 # Numeric atomic vector
v5 <- c(TRUE, TRUE, FALSE)          # Logical atomic vector
v6 <- c("R is fun!", "I hate R")    # Character atomic vector
v7 <- c(8, 9, 10, NA)               # Numeric atomic vector with missing value

length(v4)

print(length(v4))

length(v5)

print(length(v5))

length(v6)

print(length(v6))

length(v7)

print(length(v7))

sum(v4)

print(sum(v4))

sum(v5)

print(sum(v5))

sum(v7)

print(sum(v7))

sum(v7, na.rm = TRUE)

print(sum(v7, na.rm = TRUE))

mean(v4)

print(mean(v4))

min(v5)
max(v5)

print(min(v5))
print(max(v5))

mean(v7, na.rm = TRUE)

print(mean(v7, na.rm = TRUE))
