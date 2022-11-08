#  create directories

# dir.create("data_raw")
# dir.create("data_clean")
# dir.create("scripts")

# install packages
# install.package("tidyverse)

# load packages
library(tidyverse)

# download data
download.file(url = "https://opendata.ecdc.europa.eu/covid19/nationalcasedeath_archive/csv/data.csv",
              destfile = "data_raw/covid-data.csv")

# read in data
covid_data <- read_csv(file = "data_raw/covid-data.csv")
covid_data

view(covid_data)

# inspecting dataframes
# size
dim(covid_data)
nrow(covid_data)
ncol(covid_data)

# content
head(covid_data)
tail(covid_data)

# variable names
names(covid_data)

# summaries
str(covid_data)
glimpse(covid_data)
summary(covid_data)

# recap
covid_cases <- c(0, 1, 3, 1, 5, 61)
covid_cases[2]

# tibble[row, data]
# one cell
covid_data[1, 1]
covid_data[1, 6]

# one column
covid_data[1]

# one row
covid_data[1, ]

# multiple elements
covid_data[1:6, 1:6]
covid_data[1, 1:6]

covid_data[1:6]
covid_data[1:6, ]

covid_data[-1]

covid_data[[1]]
covid_data$country

# factors
countries <- factor(c("Greece", "United Kingdom", "Germany", "Australia", "Netherlands", "Greece"))

levels(countries)
nlevels(countries)

# relevelling
countries <- factor(countries,
                    levels = c("Greece", "United Kingdom", "Netherlands", "Germany", "Australia"))

levels(countries)

countries <- fct_recode(countries,
                        `The Netherlands` = "Netherlands")
levels(countries)

levels(countries)[2] <- "UK"
levels(countries)

# ordered factors
ordered_factor <- factor(c("high", "medium", "low"),
                         levels = c("low", "medium", "high"),
                         ordered = TRUE)
ordered_factor

# converting factors
as.character(countries)

year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))
as.numeric(year_fct)

date_data <- read_csv(file = "./data/dates.csv")

str(date_data)
library(lubridate)
ymd(date_data$to-date)
