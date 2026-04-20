library(tidyverse)
library(skimr)
library(GGally)
library(easystats)
library(modelr)
library(broom)

dat <- read.csv('FacultySalaries_1995.csv')

glimpse(dat)

dat_clean <- dat %>%
  filter(Tier != 'VIIB') %>%
  pivot_longer(ends_with('Salary'), names_to = 'professor_type',
               names_prefix = "Avg",
               values_to = 'avg_salary') %>%
  mutate(professor_type = sub("ProfSalary", "", professor_type))
  

img_1 <- dat_clean %>%
  ggplot(aes(x = professor_type,
             y = avg_salary,
             fill = professor_type)) +
  geom_boxplot() +
  facet_wrap(~Tier) +
  theme_minimal() +
  labs(x = 'Rank', y = "Salary") +
  guides(fill = guide_legend(title = "Rank")) +
  theme(axis.text.x = element_text(angle = 45))

ggsave('Fig1.png', plot = img_1, width = 3, height = 5)

## Anova model

mod_anova <- aov(data = dat_clean, avg_salary~State+Tier+professor_type)

summary(mod_anova)
         

## Part 3

jun_dat <- read.csv("Juniper_Oils.csv")

glimpse(jun_dat)

chems <- c("alpha-pinene","para-cymene","alpha-terpineol","cedr-9-ene","alpha-cedrene","beta-cedrene","cis-thujopsene","alpha-himachalene","beta-chamigrene","cuparene","compound 1","alpha-chamigrene","widdrol","cedrol","beta-acorenol","alpha-acorenol","gamma-eudesmol","beta-eudesmol","alpha-eudesmol","cedr-8-en-13-ol","cedr-8-en-15-ol","compound 2","thujopsenal")

jun_dat2 <- jun_dat %>%
  rename_with(~ gsub("\\.", "-", .x))

compounds <- jun_dat2 %>%
  select(starts_with('compound')) %>%
  rename_with(~ gsub("\\-", " ", .x))

jun_dat3 <- jun_dat2 %>%
  select(-starts_with('compound')) %>%
  bind_cols(compounds)

jun_dat4 <- jun_dat3 %>%
  pivot_longer(chems, names_to = 'chemical',
               values_to = 'concentration')

img_2 <- jun_dat4 %>%
  ggplot(aes(x = YearsSinceBurn,
             y = concentration)) +
  geom_smooth() +
  facet_wrap(~chemical, scales = 'free_y')

img_2  


models <- jun_dat4 %>%
  group_by(chemical) %>%
  do(tidy(glm(concentration ~ YearsSinceBurn, data = .)))

sig_chems <- models %>%
  filter(term == "YearsSinceBurn",
         p.value < 0.05) %>%
  arrange(p.value)

sig_chems
