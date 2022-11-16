#### 1. Setup ####

# install packages if you don't have them already
# install.package("tidyverse")

# load packages
library(tidyverse)

# we'll be using functions from various packages from the `tidyverse` today
# because these are part of the core `tidyverse` packages, we don't need to load them explicitly:

# `readr`: to read in our data
# `dplyr`: for general data wrangling functions
# `tidyr`: for reshaping data from the wide to the long data formats and vice versa
# `magrittr`: package which the pipe operator `%>%` comes from
# `stringr`: package with functions to manipulate strings

# We'll also use a couple of functions from the `lubridate` package, which allows us to work with dates
# you don't need to install the `lubridate` package as it is part of the `tidyverse`
# however, it isn't loaded by default, so you need to load it independently

library(lubridate)

# let's start with reading in our data
covid_data <- read_csv("data_raw/covid_data.csv")

# and have a look at the dataset contents
glimpse(covid_data)

# reminder that the dollar sign allows you to extract dataset columns as vectors
# the syntax for that is `dataset$column`
covid_data$country

# another super useful function we saw last week is the `summary()` function
# this is especially handy for numerical variables, as it calculates descriptive stats for them
summary(covid_data)

# in this case, the `summary()` function helps us see there are some unusual entries for the weekly counts
# in particular, this variable contains negative values, which doesn't really make sense
# because the `14_day_rate` is calculated from `weekly_count`, this also has confusing negative values

# the `summary` output also gives us an idea of how many missing values there are in each variable
# for example, we can see that the `note` variable is empty (it's all NAs)
# we can also see that there are missing values, e.g. in the `cumulative_count` column

#### 2. Missing values ####

# reminder that the `is.na()` function returns a logical vector
# with a `TRUE` value for missing data and a `FALSE` value for non-missing data
is.na(covid_data$cumulative_count)

# `which()` is a handy function that returns the index of TRUE values in a vector
which(is.na(covid_data$cumulative_count))

# we can then use those indices to subset the rows that contain NAs
covid_data[which(is.na(covid_data$cumulative_count)), ]

#### 3. Subsetting columns and rows ####

# since the `note` variable is empty, we can remove it
# reminder of how to do this with square brackets
# to keep only the first 10 variables
covid_data[, 1:10]
covid_data[1:10] # shorthand version of writing the above

# or to remove the 11th variable
covid_data[-11]

# now let's see how to do the same thing with `dplyr` functions
# I personally like the `dplyr` way better because I find it easier to read
# i.e., I think it's easier to understand the verb "select" than it is to understand the square brackets
# the first argument in the `select` function is the dataset from which we want to select columns
# and the second argument is the names of the columns we want to keep
# we separate the first from the seoncd argument with commas
# we also separate the names of the columns we want to keep using commas
select(covid_data, country:source)
select(covid_data, -note)
select(covid_data, country, continent, population, weekly_count, year_week)

# we can do something similar for selecting rows, which in tidy data are observations
# the `tidyverse` function to do that is `filter()`
# with `filter()`, the first argument is the dataset
# the second argument is the logical condition(s) we're using to filter our observations
# for example, if we only want observations from Cyprus:
filter(covid_data, country == "Cyprus")

# the `==` logical operator means "is identical"
# if we want the opposite of that we can use `!=`
# `!` as a logical operator means NOT

# so if we wanted all the observations NOT from Cyprus:
filter(covid_data, country != "Cyprus")

# other logical operators:
# > 
# <
# >=
# <=   

# we can also specify multiple conditions we want met
# here we're using `&` which stands for AND
filter(covid_data,
       country == "Cyprus" & indicator == "cases" & weekly_count > 50)

# this is equivalent to writing this:
filter(covid_data,
       country == "Cyprus",
       indicator == "cases",
       weekly_count > 50)

# basically, AND is the default here and you can use `,` and `&` interchangeable to list multiple conditions for `filter()`
# if instead of AND you want the OR relationship, you can use `|`
# so for example, if you want to keep observations that came from Cyprus OR Greece:
filter(covid_data,
       country == "Cyprus" | country == "Greece")


# as I mentioned before, `country` is an incorrect variable name
# there aren't only countries, but also whole continents represented
# we could rename the variable to be more accurate with `rename()`
# note that here the syntax for renaming is `new_name = old_name`
rename(covid_data, territory = country)

# you can also rename columns as you select them
select(covid_data, territory = country, continent, population, weekly_count, year_week)

# but I don't like the renaming solution
# that's because at the moment we have information about countries and about continents
# that feels confusing to me - I think these should be two different datasets

# WARNING: this bit is a little complicated!
# to filter my dataset such that the only observations I retain, actually come from *countries*
# I need a vector with the names of all the countries in the dataset
# how to do that?

# looking at the values of this vector
# the observations that are about areas bigger than a country have the word "total"
covid_data$country

# there's a function that returns the values in a vector that contain a certain string
# this function comes from the `stringr` package
# this returns the names of the continents in the dataset
str_subset(covid_data$country, pattern = "total")

# actually what I want is all the values that DON'T have the word "total" in them
# to achieve that, we can add the optional argument `negate = TRUE` of the `str_subset()` function
str_subset(covid_data$country, pattern = "total", negate = TRUE)

# this is quite hard to parse because of the sheer volume of values
# what we want is the unique values of the vector
# we can now save this in a vector called `countries`
countries <- unique(str_subset(covid_data$country, pattern = "total", negate = TRUE))

# what we want to do now is keep only the observations about these countries
# we've seen how to filter a tibble using one value of a variable
# but how do we do that with a vector of values?
# enter the %in% operator
filter(covid_data,
       country %in% countries)

# the `%in%` operator tells you if a value belongs to a vector or dataframe
# so it checks if the lefthand-side (`country`) value is present in the `countries` vector

#### 4. Linking function outputs to function inputs ####

# 1. interim datasets
covid_data_countries <- filter(covid_data,
                               country %in% countries)

select(covid_data_countries, -note)

# 2. nesting
select(filter(covid_data, country %in% countries), -note)

# 3. pipe %>%
covid_data %>% 
  filter(country %in% countries) %>% 
  select(-note) %>% 
  rename(weekly_n = weekly_count)

#### 5. Exercise 1 solution ####
covid_data %>% 
  filter(source == "TESSy COVID-19") %>% 
  select(country, indicator, year_week, weekly_count)

#### 6. Creating new columns ####

# mutate()
# a lot of the times, we'll want to create a new variable using information that we already have in the data
# in this dataset, we have a 14-day rate, but let's say we also want a weekly rate
# we can calculate that with the `weekly_count` information and the `population`

# from the ECDC:
# "The formula to calculate the 14-day cumulative number of reported COVID-19 cases per 100 000 population is 
# (New cases over 14 day period)/Population)*100 000.

# so the weekly rate per 100,000 is:
covid_data %>% 
  mutate(weekly_rate = weekly_count/population*100000) %>% 
  view()

#### 7. Split-apply-combine ####

# `group_by()` and `summarise()`
# a useful thing to do a lot of the times is
# 1. group our data
# 2. summarise it in some way
# 3. combine all the data together 

# so if we want to calculate
# the weekly minima and maxima for cases and deaths per country
# we want to group our data by `country` and `indicator` (containing the cases and deaths info)
# and then summarise using the `min()` and `max()` functions
# we can also give the new columns we're creating a new name
covid_data %>% 
  group_by(country, indicator) %>% 
  summarise(country_weekly_max = max(weekly_count),
            country_weekly_min = min(weekly_count))

# this gives us what we want for some countries (e.g. Austria)
# but not for all of them - most are NAs
# that's because most countries have at least one NA
# and R won't let us forget about it!
# so we need to explicitly drop the missing values
# we can use the `tidyr` function `drop_na()`
# and specify the missing values of which variable we want to drop
covid_data %>% 
  drop_na(weekly_count) %>% 
  group_by(country, indicator) %>% 
  summarise(country_weekly_max = max(weekly_count),
            country_weekly_min = min(weekly_count))

# R gives us a message that our data is still grouped
# grouping is easy to forget because it's not visible
# so it's always a good idea to add the `ungroup()` function after each `group_by()` function
covid_data %>% 
  drop_na(weekly_count) %>% 
  group_by(country, indicator) %>% 
  summarise(country_weekly_max = max(weekly_count),
            country_weekly_min = min(weekly_count)) %>% 
  ungroup()

# note that both `summarise()` and `summarize()` are parsed by R

# another example of using `group_by()` and `summarise()`
# here we're counting the number of observations we have for each country
# we do this using the `n()` function
covid_data %>% 
  group_by(country) %>% 
  summarise(observations_by_country = n()) %>% 
  ungroup() %>% 
  view()

# our countries are arranged alphabetically
# here, however, it'd be useful to see these countries arranged by the number of observations they have
# we do this with the `arrange()` function
# and the argument we pass to it is the column the values of which we want to use for the arranging
covid_data %>% 
  group_by(country) %>% 
  summarise(observations_by_country = n()) %>% 
  ungroup() %>% 
  arrange(observations_by_country) %>% 
  view()

# we see that small Pacific island nations have fewer observation in this dataset
# which is something important to be mindful of when analysing the data
# as we seem to have better data for some parts of the world than others
# the quality of the data will influence the quality of our inferences 

# there is also the shorthand function `count()` that combines:
# 1. `group_by()` and
# 2. `summarise(n())`
# this only works with `n()`!
covid_data %>% 
  count(country) %>% 
  view()

# functions that you can use within `summarise()`:
# `n()`
# `min()`
# `max()`
# `mean()`
# `sum()`
# `sd()`

#### 8. Joining data ####

# something that's often needed is merging two datasets together
# for example, in this case the date information we have is the week of the year
# that can be difficult to parse
# so we could merge this dataset with a dataset that contains information
# on when a a week started and when it ended

# first, let's download that dataset
download.file(url = "https://raw.githubusercontent.com/aim-rsf/training/main/r-training/data/dates.tsv",
              destfile = "data_raw/dates.tsv")

# it is a .tsv file (tab-seperated values file)
# the function to read in .tsv files is very similar to the function
# to read in .csv files
dates <- read_tsv("data_raw/dates.tsv")
glimpse(dates)

# we can use one of the `join` functions from `dplyr` to join our two datasets
# in this case I'm using the `full_join()` function
covid_data_dates <- full_join(covid_data, dates, by = "year_week")

# there are also `left_join()`, `right_join()`, `inner_join()`
# you can look these up in the help panel to see how they differ
# and when you might want to use each

#### 9. Working with dates ####

# if we have a look at the dataset again
# we see that the data type for the `from_date` and `to_date`
# columns are dates
glimpse(dates)

# the package that lets us work with dates is `lubridate`
# as R understands this data as dates
# we can ask it to select the year, month, and day from the date
year(dates$from_date)
month(dates$from_date)
day(dates$from_date)

# we can also create new columns for the year/month/day etc.
covid_dates %>% 
  mutate(year_week_start = year(from_date),
         month_week_start = month(from_date),
         day_week_start = day(from_date))
