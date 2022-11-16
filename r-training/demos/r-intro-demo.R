# math
3+5
12/5

# assigning values to objects
weight_kg <- 65
weight_Kg <- 55

2.2*weight_kg

weight_lb <- 2.2*weight_kg # formula to convert from kgs to lbs

weight_kg <- 80

# Exercise 1
weight_lb

weight_lb <- 2.2*weight_kg

# Exercise 2
weight <- 89
height <- 1.8

bmi <- weight/height^2

# functions
round(3.14159, digits = 0)
round(bmi, digits = 2)

round(digits = 2, 3.14159)

# vectors
covid_cases <- c(0, 1, 3, 1, 61)
countries <- c("United Kingdom", "the Netherlands", "Greece")

length(covid_cases)
length(countries)

typeof(covid_cases)
typeof(countries)

str(covid_cases)
str(countries)

countries <- c(countries, "Germany")
countries  

countries <- c("Australia", countries)  
countries  

# Exercise 3
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

num_logical  

# Subsetting vectors

covid_cases[2]
covid_cases

covid_cases[c(2, 1, 3, 2)]

covid_cases[c(FALSE, TRUE, TRUE, TRUE, TRUE)]
covid_cases > 0
covid_cases[covid_cases > 0]

# > greater than
# < smaller than
# ! not
# == identity

covid_cases[covid_cases > 0 & covid_cases < 10]

# missing values
covid_cases_na <- c(0, 1, 3, NA, 61)

min(covid_cases_na, na.rm = TRUE)
max(covid_cases_na, na.rm = TRUE)

is.na(covid_cases_na)
