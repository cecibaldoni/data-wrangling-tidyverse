# -------------------------------------------
# Data Wrangling with the {tidyverse}: Exercises
# Dataset: gapminder
# -------------------------------------------

# SETUP (Run this first)
install.packages("tidyverse")
install.packages("gapminder")

library(tidyverse)
library(gapminder)

data("gapminder")

# Exercise 1: Loading & Exploring Data
# -------------------------------------------

# 1. Preview the first rows of the dataset
head(gapminder)

# Questions:
# - How many variables are there?
# - What types of variables can you identify?

# 2. Inspect the structure of the data
glimpse(gapminder)

# Questions:
# - What are the variable types?
# - Which variables are numeric or categorical?

# 3. Get a statistical summary for numeric variables
summary(gapminder)

# Questions:
# - What's the range of life expectancy?
# - What's the median GDP per capita?

# 4. Explore distinct values of categorical variables
gapminder %>% distinct(continent)
gapminder %>% distinct(year)

# Questions:
# - How many continents are included?
# - Which years are represented?

# 5. Count observations per continent
gapminder %>% count(continent)

# Questions:
# - Which continent has the most countries?
# - Which continent has the fewest countries?


# Exercise 2: Selecting and Filtering Data
# -------------------------------------------

# 1. Select relevant columns for analysis
gapminder_selected <- gapminder %>% 
  select(country, continent, year, lifeExp, gdpPercap)

head(gapminder_selected)

# Questions:
# - Did selecting columns change the number of rows?
# - Why might we choose to select specific columns?

# 2. Filter data for European countries after the year 2000
gapminder_europe_recent <- gapminder_selected %>% 
  filter(continent == "Europe", year > 2000) %>%
  arrange(desc(lifeExp))

head(gapminder_europe_recent)

# Questions:
# - Which country has the highest life expectancy?
# - How many rows remain after filtering?


# Exercise 3: Creating & Modifying Variables
# -------------------------------------------

# 1. Create a new column for total GDP (GDP per capita multiplied by population)
gapminder_gdp <- gapminder %>% 
  mutate(gdp_total = gdpPercap * pop)

head(gapminder_gdp)

# Questions:
# - Does this new column appear correctly calculated?
# - Can you explain the calculation?

# 2. Rename the column "gdpPercap" to "GDP_per_capita"
gapminder_renamed <- gapminder_gdp %>%
  rename(GDP_per_capita = gdpPercap)

head(gapminder_renamed)

# Questions:
# - Why might renaming columns be useful?

# 3. Categorize life expectancy into groups ("Low", "Medium", "High")
gapminder_categorized <- gapminder_renamed %>% 
  mutate(life_category = case_when(
    lifeExp < 50 ~ "Low",
    lifeExp >= 50 & lifeExp < 70 ~ "Medium",
    lifeExp >= 70 ~ "High"
  ))

head(gapminder_categorized)

# Questions:
# - Check the new life_category column; do categories look reasonable?
# - How many categories were created?


# Exercise 4: Summarizing & Grouping Data
# -------------------------------------------

# 1. Calculate average life expectancy per continent for the year 2007
lifeExp_summary <- gapminder %>% 
  filter(year == 2007) %>% 
  group_by(continent) %>% 
  summarise(mean_lifeExp = mean(lifeExp))

lifeExp_summary

# Questions:
# - Which continent had the highest average life expectancy in 2007?
# - Which had the lowest?

# 2. Count the number of unique countries per continent
country_counts <- gapminder %>% 
  group_by(continent) %>% 
  summarise(country_n = n_distinct(country))

country_counts

# Questions:
# - How many countries does Africa have in this dataset?
# - Why might counting unique countries be important?

# BONUS: Visualizing Data with ggplot2
# -------------------------------------------

# 1. Scatter plot: GDP per capita vs life expectancy (log scale for GDP)
gapminder_2007 <- gapminder %>% 
  filter(year == 2007)

ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(size = 3, alpha = 0.7) +
  scale_x_log10() +
  labs(title = "GDP per Capita vs Life Expectancy (2007)",
       x = "GDP per Capita (log scale)",
       y = "Life Expectancy",
       color = "Continent")

# 2. Boxplot: Life expectancy by continent in 2007
ggplot(gapminder_2007, aes(x = continent, y = lifeExp, fill = continent)) +
  geom_boxplot() +
  labs(title = "Life Expectancy by Continent (2007)",
       x = "Continent",
       y = "Life Expectancy")

# 3. Line plot: Average life expectancy over time by continent
lifeExp_trend <- gapminder %>% 
  group_by(year, continent) %>% 
  summarise(mean_lifeExp = mean(lifeExp))

ggplot(lifeExp_trend, aes(x = year, y = mean_lifeExp, color = continent)) +
  geom_line(size = 1.2) +
  labs(title = "Average Life Expectancy Over Time by Continent",
       x = "Year",
       y = "Mean Life Expectancy",
       color = "Continent")