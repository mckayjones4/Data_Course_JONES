# # Data description
library(tidyverse)
library(skimr)
df <- read_csv("cleaned_covid_data.csv")
skimr::skim(df)
# TASKS:

## I.
##  Read the cleaned_covid_data.csv file into an R data frame. (20 pts)
df <- read_csv("cleaned_covid_data.csv")

  
# II.
# Subset the data set to just show states that begin with "A"
# and save this as an object called A_states. (20 pts)
  # + Use the *tidyverse* suite of packages
  # + Selecting rows where the state starts with "A" is tricky
  #   (you can use the grepl() function or just a vector of those states if you prefer)
A_states <- df %>%
  filter(grepl("^A", Province_State))

print(A_states$Province_State)

# **III.**
#  **Create a plot _of that subset_ showing Deaths over time, with a separate facet for each state. (20 pts)**
#  + Create a scatterplot
# + Add loess curves WITHOUT standard error shading
# + Keep scales "free" in each facet
A_states %>%
  mutate(Last_Update = as.Date(Last_Update)) %>%
  ggplot(aes(x = Last_Update,
             y = Deaths)) + 
  geom_point(size = 0.1, shape = 23) + 
  geom_smooth(method = "loess", se = F, color="darkred") +
  facet_wrap(~Province_State, scales = "free")

# **IV.** (Back to the full dataset)
# **Find the "peak" of Case_Fatality_Ratio for each state and save this as a new data frame object called state_max_fatality_rate. (20 pts)**
#  I'm looking for a new data frame with 2 columns:
# + "Province_State"
# + "Maximum_Fatality_Ratio"
# + Arrange the new data frame in descending order by Maximum_Fatality_Ratio
## This might take a few steps. Be careful about how you deal with missing values!
state_max_fatality_rate <- df %>%
  group_by(Province_State) %>%
  filter(!is.na(Case_Fatality_Ratio)) %>%
  summarize(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio)) %>%
  arrange(desc(Maximum_Fatality_Ratio))

View(state_max_fatality_rate)

# **V.**
# **Use that new data frame from task IV to create another plot. (20 pts)**
# + X-axis is Province_State
# + Y-axis is Maximum_Fatality_Ratio
# + bar plot
# + x-axis arranged in descending order, just like the data frame (make it a factor to accomplish this)
# + X-axis labels turned to 90 deg to be readable
##Even with this partial data set (not current), you should be able to see that (within these dates), different states had very different fatality ratios.
state_max_fatality_rate %>%
  mutate(Province_State = factor(Province_State, levels = Province_State)) %>%
  ggplot(aes(x = as.factor(Province_State),
             y = Maximum_Fatality_Ratio)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Maximum Fatality Ratios in the US",
       x = "State",
       y = "Max Fatality Ratio") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 1, hjust = 1, size = 8))

# **VI.** (BONUS 10 pts)
# **Using the FULL data set, plot cumulative deaths for the entire US over time**
# + You'll need to read ahead a bit and use the dplyr package functions group_by() and summarize() to accomplish this.
df %>%
  group_by(Last_Update) %>%
  summarize(cumulative_d = sum(Deaths)) %>%
  ggplot(aes(x = Last_Update,
             y = cumulative_d)) +
  geom_bar(stat = 'identity', position = 'dodge', color = "darkred") +
  labs(title = "Cumulative COVID-19 Deaths in the United States",
       x = "Time",
       y = "Cumulative Deaths") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = 'italic', size = 12))

