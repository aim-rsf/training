#dir.create("data_raw")
#dir.create("data_clean")
#download.file(url = "https://opendata.ecdc.europa.eu/covid19/nationalcasedeath_archive/csv/data.csv",
#destfile = "data_raw/covid-data.csv")

#install.packages("tidyverse")

library(tidyverse)

# read in data
covid_data <- read_csv(file = "data_raw/covid-data.csv")
covid_data

view(covid_data)

# view data size
dim(covid_data)
nrow(covid_data)
ncol(covid_data)

# content of data
head(covid_data, n = 10)
tail(covid_data)

# summaries
str(covid_data)
glimpse(covid_data)
summary(covid_data)

# indexing and subsetting

covid_cases <- c(0, 1, 3, 1, 6, 51)
covid_cases[2]

# tibble[row, column]
covid_data[1, 1]
covid_data[1, 2]
covid_data[290, 1]

covid_data[1, ]
covid_data[1]
covid_data[5]
covid_data[, 5]

covid_data[1:6, ]

covid_data[, 1:6]

covid_data[1:6, 1:6]

covid_data[1]

covid_data[[1]]
covid_data$country_code

min_population <- min(covid_data$population)
max(covid_data$population)

# foctors
countries <- c("United Kingdom", "Netherlands", "Greece", "Germany", "Australia")
class(countries)

countries <- factor(c("United Kingdom", "Netherlands", "Greece", "Germany", "Australia"))
class(countries)

levels(countries)

countries <- factor(countries,
                    levels = c("Greece", "United Kingdom", "Netherlands", "Australia", "Germany"))
levels(countries)

nlevels(countries)

countries <- fct_recode(countries, `The Netherlands` = "Netherlands")

levels(countries)[2] <- "UK"
levels(countries)

ordered_factor <- factor(c("high", "medium", "low"),
                         levels = c("low", "medium", "high"),
                         ordered = TRUE)
ordered_factor

# converting factors

countries_chr <- as.character(countries)
class(countries_chr)

years <- factor(c(1456, 1987, 1887, 1654))
years_num <- as.numeric(years)
years_num
