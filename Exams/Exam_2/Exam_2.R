# Exam 2
library(tidyverse)
library(janitor)
library(stringr)
library(easystats) # for comparing stat models

# 1. read in unicef data
dat <- read.csv('unicef-u5mr.csv')

# 2. make unicef data tidy
clean_dat <- dat %>%
  pivot_longer(cols = starts_with('U5MR'),
               names_to = 'year',
               values_to = 'mortality_rate') %>%
  mutate(year = str_sub(year, start = 6)) %>%
  clean_names()

# 3. plot each country's U5MR over time
plot1 <- clean_dat %>%
  ggplot(aes(x = year,
             y = mortality_rate,
             group = country_name)) +
  geom_line(na.rm = TRUE) +
  facet_wrap(~continent) + 
  scale_x_discrete(breaks = c(1960, 1980, 2000), labels = c(1960, 1980, 2000))

# 4. save this plot as LASTNAME_Plot_1.png
ggsave('JONES_plot_1.png', plot = plot1, width = 10, height = 10)

# 5. Create another plot that shows the mean U5MR for all the countries within a given continent at each year
plot2 <- clean_dat %>%
  group_by(year, continent) %>%
  summarize(means = mean(mortality_rate, na.rm=T)) %>%
  ggplot(aes(x = year,
             y = means,
             group = continent,
             color = continent)) +
  geom_path() +
  scale_x_discrete(breaks = c(1960, 1980, 2000), labels = c(1960, 1980, 2000))


# 6. Save that plot as LASTNAME_Plot_2.png
ggsave('JONES_plot_2.png', plot = plot2, width = 10, height = 10)

# 7. Create three models of U5MR
mod1 <- glm(mortality_rate~year, data = clean_dat)

mod2 <- glm(data = clean_dat, formula = mortality_rate~year+continent)

mod3 <- glm(data = clean_dat, formula = mortality_rate~year*continent)
mod3
# 8. Compare the three models with respect to their performance
compare_performance(mod1, mod2, mod3) %>% plot()

# mod3 is the best overall, but lacks BIC values.
## mod3 has the lwoest error (RMSE) and largest correlation (R2) value

# 9. Plot the 3 models' predictions
clean_dat$pred1 <- predict(mod1, clean_dat)
clean_dat$pred2 <- predict(mod2, clean_dat)
clean_dat$pred3 <- predict(mod3, clean_dat)

clean_dat %>%
  pivot_longer(starts_with('pred')) %>%
  ggplot(aes(x = year,
             y = mortality_rate,
             color = continent,
             factor = continent)) +
  geom_point(aes(y = value)) +
  geom_smooth(method = 'glm') +
  facet_wrap(~name) +
  scale_x_discrete(breaks = c(1960, 1980, 2000), labels = c(1960, 1980, 2000)) +
  labs(title = "Model Predictions", y = "predicted U5MR")

#10. BONUS -Predict what the U5MR would be for Ecuador in the year 2020.
## the real value for Ecuador in 2020 was 13 under-5 deaths per 1000 live births
## how far off was the model prediction?

ecuador <- 13/1000

country <- clean_dat %>%
  filter(country_name == "Ecuador")

# Ensure year is numeric
clean_dat <- clean_dat %>%
  mutate(
    year = as.numeric(year),
    continent = factor(continent)   # ensure factor
  )

# Subset Ecuador data
ecuador <- clean_dat %>%
  filter(country_name == "Ecuador")

# Create new data frame for prediction
ecuador_2020 <- tibble(
  country_name = "Ecuador",
  year = 2020,
  continent = "Americas"
)

mod3 <- glm(mortality_rate ~ year * continent, data = clean_dat)

# Predict using best model (mod3)
ecuador_pred <- predict(mod3, newdata = ecuador_2020)

# Compare to real value
real_2020 <- 13
error <- ecuador_pred - real_2020

ecuador_pred # -10.58018
error # -23.58018 (value is negative, so the model underpredicted)



