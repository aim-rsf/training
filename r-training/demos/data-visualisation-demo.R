# 1. set-up

# only run the below commands if you don't have the "figures" folder already or
# if you haven't installed `viridisLite` yet
#dir.create("figures")
#install.packages("viridisLite")

# load packages
library(tidyverse)
library(lubridate)
library(viridisLite)

# I load the `maps` package towards the end of the script in an optional sectionß

# the dates dataset that I shared on 15 Nov 2022 had mistakes
# if you haven't downloaded the newer version, please download it again
# download.file(url = "https://raw.githubusercontent.com/aim-rsf/training/main/r-training/data/dates.tsv",
#               destfile = "data_raw/dates.tsv")

covid_data <- read_csv("data_raw/covid-data.csv")
dates <- read_tsv("data_raw/dates.tsv")

covid_data_dates <- inner_join(covid_data, dates, by = "year_week")

# 2. data wrangling

# pivoting
# pivot_longer, pivot_wider

covid_uk <- covid_data %>% 
  filter(country == "United Kingdom") %>% 
  select(country, indicator, weekly_count, year_week)

covid_uk %>% 
  pivot_wider(names_from = indicator,
              values_from = weekly_count) %>% 
  view()

# clean data
countries <- unique(str_subset(covid_data$country, pattern = "total", negate = TRUE))

covid_data_clean <- covid_data_dates %>% 
  filter(country %in% countries) %>% 
  select(country, continent, population, indicator, weekly_count, from_date, to_date) %>%
  pivot_wider(names_from = indicator,
              values_from = weekly_count) %>%
  rename(cases_count = cases,
         deaths_count = deaths) %>% 
  mutate(cases_rate = (cases_count/population)*100000,
         deaths_rate = (deaths_count/population)*100000,
         year = year(to_date),
         month = month(to_date))

# export data
write_csv(covid_data_clean, file = "data_clean/covid_data_clean.csv")
write_tsv(covid_data_clean, file = "data_clean/covid_data_clean.tsv")

# 3. data visualisation

# data %>% 
#   ggplot(aes()) +
#   geom_function()

covid_data_clean %>% 
  filter(country == "United Kingdom") %>% 
  ggplot(aes(x = to_date, y = cases_count)) +
  geom_line(size = 1.1, colour = "tomato", linetype = "dotted")

covid_data_clean %>% 
  filter(country == "United Kingdom" | country == "Netherlands" | country == "Germany") %>% 
  ggplot(aes(x = to_date, y = cases_count, colour = country)) +
  geom_line(size = 1.1) +
  scale_colour_viridis_d()

# exercise 1 solution
covid_data_clean %>%
  filter(country == "Denmark" | country == "Sweden", year  == 2020) %>% 
  ggplot(aes(x = to_date, y = cases_rate, colour = country)) +
  geom_line(size = 1.2) +
  scale_colour_viridis_d()

# you can run this command to disable scientific notation
#options(scipen = 999)

# scatter plots
covid_data_clean %>% 
  filter(deaths_rate > 0) %>% 
  ggplot(aes(x = cases_count, y = deaths_count)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~year)

# bar plots

countries_selection <- c(
  "Argentina",
  "United Kingdom",
  "Greece",
  "South Korea",
  "Canada",
  "Australia",
  "Mexico",
  "South Africa",
  "Russia",
  "Kenya"
)

bar_plot <- covid_data_clean %>% 
  filter(country %in% countries_selection,
         year == 2021,
         month == 7) %>%
  group_by(country) %>% 
  summarise(month_rate = sum(cases_count/population*100000)) %>% 
  ungroup() %>% 
  mutate(country = fct_reorder(country, month_rate)) %>% 
  ggplot(aes(x = country, y = month_rate)) +
  geom_col() +
  coord_flip()

# exercise 2 solution

covid_data_clean %>% 
  drop_na() %>% 
  filter(country %in% countries_selection,
         year == 2020) %>% 
  group_by(country) %>% 
  summarise(deaths_year = sum(deaths_count)) %>%
  ungroup() %>% 
  mutate(country = as.factor(country),
         country = fct_reorder(country, deaths_year)) %>%
  ggplot(aes(x = country, y = deaths_year)) +
  geom_col() +
  coord_flip()

# exercise 2 + extra challenge

covid_data_clean %>% 
  drop_na() %>% 
  filter(country %in% countries_selection) %>% 
  group_by(country, year) %>% 
  summarise(deaths_year = sum(deaths_count)) %>%
  ungroup() %>% 
  mutate(country = as.factor(country),
         country = fct_reorder(country, deaths_year)) %>%
  ggplot(aes(x = country, y = deaths_year)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~year)

ggsave(filename = "figures/barplot.png", plot = bar_plot)

# NB: this is code I *did not have time to show during the workshop*
# adding labels and titles

covid_data_clean %>% 
  drop_na() %>% 
  filter(country %in% countries_selection,
         year == 2020) %>% 
  group_by(country) %>% 
  summarise(deaths_year = sum(deaths_count)) %>%
  ungroup() %>% 
  mutate(country = as.factor(country),
         country = fct_reorder(country, deaths_year)) %>%
  ggplot(aes(x = country, y = deaths_year)) +
  geom_col() +
  coord_flip() +
  labs(title = "Total deaths in 2020 for selected countries",
       x = "",
       y = "Total deaths in 2020")

# themes
# see also exercise 3 for more available themes (https://aim-rsf.github.io/training/r-training/rmd-scripts/data-visualisation#29)

covid_data_clean %>% 
  drop_na() %>% 
  filter(country %in% countries_selection,
         year == 2020) %>% 
  group_by(country) %>% 
  summarise(deaths_year = sum(deaths_count)) %>%
  ungroup() %>% 
  mutate(country = as.factor(country),
         country = fct_reorder(country, deaths_year)) %>%
  ggplot(aes(x = country, y = deaths_year)) +
  geom_col() +
  coord_flip() +
  labs(title = "Total deaths in 2020 for selected countries",
       x = "",
       y = "Total deaths in 2020") +
  theme_bw()

# customisation

covid_data_clean %>% 
  drop_na() %>% 
  filter(country %in% countries_selection,
         year == 2020) %>% 
  group_by(country) %>% 
  summarise(deaths_year = sum(deaths_count)) %>%
  ungroup() %>% 
  mutate(country = as.factor(country),
         country = fct_reorder(country, deaths_year)) %>%
  ggplot(aes(x = country, y = deaths_year)) +
  geom_col() +
  coord_flip() +
  labs(title = "Total deaths in 2020 for selected countries",
       x = "",
       y = "Total deaths in 2020") +
  theme_minimal() +
  # move the title more to the left so it aligns with the start of the whole plot
  theme(plot.title.position = "plot",
        # make the font size bigger
        axis.text = element_text(size = 12))

# advanced 1
# an example of how to set local aesthetics
covid_data_clean %>% 
  drop_na() %>% 
  filter(country %in% countries_selection) %>% 
  group_by(country, year) %>% 
  summarise(deaths_year = sum(deaths_count),
            cases_year = sum(cases_count)) %>%
  ungroup() %>% 
  mutate(country = as.factor(country),
         country = fct_reorder(country, deaths_year)) %>%
  ggplot() +
  # this shows the cases in the background
  geom_col(aes(x = country, y = cases_year), fill = "gray", alpha = 0.6) +
  # and this shows the deaths highlighted in red
  geom_col(aes(x = country, y = deaths_year), fill = "tomato") +
  coord_flip() +
  facet_wrap(~year)

# advanced 2
# maps

# install.packages("maps")
library(maps)

# to create a world map plot
world_map <- map_data("world")
ggplot(world_map, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill="lightgray", colour = "white")

# to add the covid data in the world map plot
covid_data_small <- covid_data_clean %>% 
  filter(to_date == "2022-06-12") %>% 
  select(region = country, cases_rate)

covid_map_data <- left_join(world_map, covid_data_small, by = "region")

covid_map_data %>% 
  ggplot(aes(long, lat, group = group))+
  geom_polygon(aes(fill = cases_rate ), color = "white")+
  scale_fill_viridis_c()

# food for thought: some countries (e.g. the USA) appear as grey in the map
# this would suggest that we don't have data for them
# however, this is not actually true
# can you figure out what the problem is?
