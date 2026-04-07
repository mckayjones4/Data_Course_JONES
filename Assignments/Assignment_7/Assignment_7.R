##### Assignment 7 ####
#load required packages
library(tidyverse)
library(skimr)
library(janitor)

# read in the Utah_Religions_by_County dataset
dat <- read.csv('Utah_Religions_by_County.csv')

# look at the data
skim(dat)

# clean data into a 'tidy' shape
tidy_dat <- dat %>%
  clean_names() %>%
  pivot_longer(-c(1:4), names_to = 'religions', values_to = 'percentage')


# first, look at the relationship between population and the proportion of people who are religious
tidy_dat %>%
  ggplot(aes(x = pop_2010,
             y = religious,
             color = county)) +
  geom_point(stat = 'identity') # kind of a messy graph

# this figure shows how the percentage of a certain religion changes as the population increases
## wrapped by religion
tidy_dat %>%
  ggplot(aes(x = pop_2010,
             y = percentage)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  facet_wrap(~religions, scales = 'free_y') #free y scales helps us see some more relationships

# 1. Does population of a county correlate with the proportion of
## any specific religious group in that county?
cor.test(tidy_dat$pop_2010, tidy_dat$religious, method = 'pearson')  

# correlation for every religion
cor_pop_religions <- tidy_dat %>%
  group_by(religions) %>%
  summarize(correlation = cor(pop_2010, percentage, use = 'complete.obs')) %>%
  arrange(desc(abs(correlation)))

#view the correlations
cor_pop_religions #strongest correlation is with muslim religion

# this graph at how the proportion of non_religious individuals
## is affected by proportions of speicifc religions
tidy_dat %>%
  ggplot(aes(x = percentage,
             y = non_religious)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  facet_wrap(~religions, scales = 'free')

# 2. Does proportion of any specific religion in a given county
## correlate with the proportion of non-religious people?
cor_prop_religion <- tidy_dat %>%
  group_by(religions) %>%
  summarize(correlation = cor(percentage, non_religious, use = 'complete.obs')) %>%
  arrange(desc(abs(correlation)))


  
