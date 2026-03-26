#Assignment_6####
library(tidyverse)
library(gganimate)

dat <- read.csv("../../Data/BioLog_Plate_Data.csv")
# Clean this data into tidy (long) form
dat_2 <- dat %>%
  pivot_longer(cols = starts_with('Hr'),
               names_to = 'Time',
               values_to = 'Absorbance') %>%
  mutate(Time = case_when(Time == 'Hr_24' ~ 24,
                         Time == 'Hr_48' ~ 48,
                         Time == 'Hr_144' ~ 144))

# Create a new column specifying whether a sample is from soil or water
dat_3 <- dat_2 %>%
  mutate(Type = case_when(Sample.ID == 'Clear_Creek' ~ 'Water',
                          Sample.ID == 'Waste_Water' ~ 'Water',
                          Sample.ID == 'Soil_1' ~ 'Soil',
                          Sample.ID == 'Soil_2' ~ 'Soil'))

# Genereates a plot that matches this one
dat_3 %>%
  filter(Dilution == 0.1) %>%
  ggplot(aes(x = Time,
         y = Absorbance,
         color = Type)) + 
  geom_smooth(position = 'identity', se = F) + 
  facet_wrap(~Substrate)

# Generate an animated plot that matches this one (absorbance values are mean of all 3 replicates for each group)
dat_3 %>%
  filter(Substrate == 'Itaconic Acid') %>%
  group_by(Sample.ID, Dilution, Time) %>%
  summarize(mean_abs_val = mean(Absorbance)) %>%
  ggplot(aes(x = Time,
             y = mean_abs_val,
             color = Sample.ID)) +
  geom_line() +
  facet_wrap(~ Dilution)+
  transition_reveal(Time)
