#### 1/15/26 ####

list.files('Data/', pattern='t$', recursive = T) #654
 
list_of_files_start_with_b <- list.files('Data/', recursive = T)

dat <- read.csv('Data/1620_scores.csv')

list.files("Data/", pattern='.csv', recursive=T) #145

dat[1:2]

readLines('Data/6napoleans.txt')


#know while loops in R
while (condition)


fruit = c('strawberry', 'mango', 'peach')

for (i in fruit) {
  print(paste('i like', i))
  #print(i)
}

for (i in 1:100) { 
  print(i)
  print(i+1)
  print('\n')
}

#4. lists all the .csv files in the Data directory
csv_files <- list.files('Data/', pattern='.csv', recursive = T)

#5. Find how many files fit that description (15)
length(csv_files)

#6. Store the wingspan_vs_mass.csv file in a 'df' object
df <- read.csv('Data/wingspan_vs_mass.csv')

#7. Inspect the first 5 lines
head(df, 5)

base_directory <- "C:/Users/jones/OneDrive/Desktop/Data_Course_JONES/Data"

#8. Find files that begin with the letter 'b'
begin_with_b <- list.files('Data/', pattern="^b", recursive = T)

#9. List the first line of every file that begins with b
for (file in begin_with_b) {
  full_path <- file.path(base_directory, file)
  con <- file(full_path, "r")
  
  print(readLines(con, n=1))
  close(con)
}

#10. Print the first line of every .csv file
for (file in csv_files) {
  full_path <- file.path(base_directory, file)
  con <- file(full_path, "r")
  
  print(readLines(con, n=1))
  close(con)
}


#### 1/20/26 ####
# 1. Read 'wingspan_vs_mass.csv' using both
# relative path and absolute path
# 2. how many rows and columns in the file?

getwd() #get working directory

#read relative path
df <- read.csv('Data/wingspan_vs_mass.csv')

#read absolute path
absolute <- read.csv('C:/Users/jones/OneDrive/Desktop/Data_Course_JONES/Data/wingspan_vs_mass.csv')

nrow(test) #1000 rows

ncol(test) #6 columns

dim(test)

log <- c(TRUE, FALSE)

num1 <- c(1, 2, 3)
num2 <- c('1,', '2', '3')

is.numeric(num1)
is.numeric(num2)
is.numeric(log)

as.character(num2)

as.character(log)

#file extension
.Rproj
.R

# types of objects in R
# 1. vector (one dim, same type)
str(df)

vec <- c('1', 2, T) #if you have a character in a vector, all other elements will become a character
is.character(vec)

# 2. matrix (two dim, same type of data)
matrix(c(1:6), nrow = 3, ncol = 2)

matrix()

#4. data frame
df$mass + 100
df$mass * 100
df$mass_plus_2000 = df$mass + 100
df_1 <- data.frame(name=c('Chloe', 'Sam', 'Sophia', 'Marcus'),
                   fruit = c('grape', 'kiwi', 'peach', 'blueberry'),
                   calories = c(1, 3, 4, 5))

# 4. array (multiple dim, same time)
array(c(1:12), dim = c(2, 2, 3))

# 5. list (multi dim, different type, different length)
list_a <- list(df,
     number = c(1:6),
     fruit = 'strawberry')

list_a$number

# 6. function (store a function)
list()

this_is_my_function <- function(x, y){
  out = x + y
  print(out)
}

this_is_my_function(1, 2)

fruit <- c("apple", "peach", "strawberry")

fruit[1]
fruit[2]
fruit[3]

for (i in fruit){
  print(i)
  #i = apple
  #i = peach
  #i = strawberry
}

as.numeric()
as.logical()
as.character()
as.factor()

color = c('light blue', 'orange', 'green', 'gray74', 'gray72', 'mint green',
          'red', 'blue', 'pink', 'purple', 'red4', 'yellow')
length(color)
as.factor(color)

#1/22/36####
# 1. create a data frame with your favorite fruits
# 2. add calories to the data frame
# 3. write a loop to print name of fruit
# 4. write a loop to print out 'calories_100'
df_2 <- data.frame(name=c('Chloe', 'Sam', 'Sophia', 'Marcus'),
                   fruit = c('grape', 'kiwi', 'peach', 'blueberry'),
                   calories = c(1, 3, 4, 5))

df_2$calories_100 <- df_2$calories+100

for (i in df_2$fruit){
  print(i)
}

for (i in df_2$calories_100){
  print(i)
}

for (i in 1:nrow(df_2)){
  print(df_2[i, 2]) #2 is fruit
  print(df_2[i, 4]) #4 is calories_100
}

for (i in df_2$new_col){
  print(i)
}

for (i in 1:nrow(df_2)){
  out <- paste('The calories of', df_2$fruit[i], 'is', df_2$calories_100[i])
  print(out)
}
#make a new object
out <- paste('The calories of', df_2$fruit[1], 'is', df_2$calores_100[1])


# 1. save mtcars dataset to a new object
# 2. save cars with mpg > 20 to a new obj called "good_cars"

#prints R datasets
data()

mtcars
cars <- data.frame(mtcars)
out <- 1:nrow(cars)

for (i in 1:nrow(cars)){
  if (cars$mpg[i] > 20.0){
    good_cars <- 
  }  
}


#1/27/26####
# 1. get the car with cyl equal to 4 (save to a new obj)
# 2. save both mpg > 20 and cyl equal to 4 into a new object
cars <- data.frame(mtcars)

# when using a square bracket, always make sure to include a comma
cars[1, ]

# get the cars with cyl equal to four
good_car <- cars[cars$cyl == 4, ]

# filter for cars with mpg > 20
super_good_car <- good_car[good_car$mpg > 20]

# combine step 1 and 2 into one line (you can use & to add as many conditions as you would like)
good_car <- cars[cars$cyl == 4 & cars$mpg > 20, ]
View(good_car)

# 3. what are the data types of each cols?
type(cars[1, ])

# sapply applies a function to every element in a list (or other data type)
sapply(cars, class)
#dimensions
dim(cars)
str(cars)

## convert all columns to character
char_car <- as.character(cars)
str(char_car)
cars_char <- data.frame(lapply(cars, as.character), stringsAsFactors = FALSE)

#only change mpg to character
# dollar sign covers the column, if the column does not exist, it makes a new column
cars$mpg <- as.character(cars$mpg)

for (col in names(good_car)) {
  #print(col)
  #print(good_car[, col])
  good_car[ , col] <- as.character(good_car[, col])
}

?lapply

str(good_car)

new_data <- apply(good_car, 2, as.character)

#installing packages
install.packages('qrcode')
library(qrcode)
url <- 'https://ais-que.uvu.edu/que/si/begin.php?center=281'
code <- qr_code(url)
plot(code)


#install tidyverse
install.packages('tidyverse')
library(tidyverse)

filter()
stats::filter()

# 1. get the car with cyl equal to 4 (save to a new obj)
# 2. save both mpg > 20 and cyl equal to 4 into a new object
cars$mpg %>% #pipe |

str(cars)  

mean(cars$mpg)
#achieves the same thing. %>% applies a function to a specified object
cars$mpg %>%
  mean()
  #filter(mpg > 20)

# Do 1. with %>%
new_car <- cars %>%
  filter(mpg>20) %>%
  filter(cyl == 4)

# save cars with mpg > 22, cyl = 4, wt <3
## and hp < 90 in new obj
new_object <- cars %>%
  filter(mpg>22) %>%
  filter(cyl == 4) %>%
  filter(wt<3) %>%
  filter(hp<90)

new_object2 <- cars[cars$cyl == 4 & cars$mpg > 22 & cars$wt<3 & cars$hp<90, ]

write.csv(new_object, 'Data/new_car.csv')

#1/29/26####
#install palmerpenguins package
install.packages('palmerpenguins')
#open 'penguins' dataset
library(palmerpenguins)
penguins <- penguins

# save penguins with bill length > 40 into a new object
big_bill <- penguins[penguins$bill_length_mm > 40, ]


# calculate the average body mass of them
mean(big_bill$body_mass_g, na.rm = TRUE)


#do the same thing in tidyverse
library(tidyverse)
big_bill2 <- penguins %>%
  filter(bill_length_mm > 40)

mean(big_bill2$body_mass_g, na.rm = TRUE)

#just one function
penguins %>%
  filter(bill_length_mm > 40) %>%
  pluck("body_mass_g") %>%
  mean()

## calculate body mass of male and female penguins
## of those bill length > 40
penguins %>%
  filter(bill_length_mm > 40) %>%
  filter(sex == "male") %>%
  pluck("body_mass_g") %>%
  mean()

penguins %>%
  filter(bill_length_mm > 40) %>%
  filter(sex == "female") %>%
  pluck("body_mass_g") %>%
  mean()
  
#pluck gives you a list

penguins %>%
  filter(bill_length_mm > 40) %>%
  group_by(sex) %>%
  summarize(average_body_mass = mean(body_mass_g),
            no_of_penguins = n(),
            max_mass = max(body_mass_g),
            min_mass = min(body_mass_g)) %>%
  arrange(desc(max_mass))
  
#find the fattest penguins (body mass > 5000)
# count how many male and females
# return the max body of male and female
penguins %>%
  filter(body_mass_g > 5000) %>%
  group_by(sex) %>%
  summarize(count = n(),
             max_mass = max(body_mass_g))

# add new column to data to tell if they are fat or not
penguins$fatties <- penguins$body_mass_g > 5000
View(penguins)

#add new column with mutate
penguins %>%
  mutate(len_times_dpt = bill_length_mm * bill_depth_mm) %>%
  View()

# combine mutate() and case_when() (if statement in tidyverse)
penguins %>%
  mutate(fat_status = case_when(body_mass_g > 5000 ~ 'FAAAT',
                                body_mass_g < 3000 ~ 'Skinny',
                                body_mass_g < 5000 & body_mass_g > 3000 ~ 'neutral')) %>%
  View()

# add new column to data to highlight penguins with bill bills
penguins %>%
  mutate(big_bill = case_when(bill_length_mm > 50 ~ 'Long bill',
                              bill_length_mm < 40 ~ 'short bill',
                              bill_length_mm < 50 & bill_length_mm > 40 ~ 'neutral bill')) %>%
  View()
  

#2/3/2025####
# using penguin data
# add a new column (fatstat) 
## for penguins with weight more than 5000g -->
# for penguins less than or equal to 5000g and more than 3000 g -->
# 

library(tidyverse)
penguin <- penguins
peng_2 <- penguin %>%
  mutate(fatstat = case_when(body_mass > 5000 ~ 'Heavy',
                             body_mass <= 5000 & body_mass > 3000 ~ 'Medium',
                             body_mass <= 3000 ~ 'Light'))

View(peng_2)

#making plots
plot()
hist()
barplot()
boxplot()

names(peng_2)
plot(peng_2$bill_len, peng_2$body_mass)

ggplot(aes(x = bill_len,
           y = body_mass),
       data = peng_2) + 
  geom_point()

#doing the same thing with tidyverse
peng_2 %>%
  ggplot(aes(x = bill_len,
             y = body_mass,
             color = sex,
             shape = species)) + 
  geom_point() + 
  theme_minimal()

# take a look at your new penguin data
# make a cool graph
peng_2 %>%
  ggplot(aes(x = sex,
             y = flipper_len)) +
  geom_boxplot() + 
  theme_minimal()

geom_area()

peng_2 %>%
  ggplot(aes(x = species,
             y = body_mass)) + 
  geom_bar(stat = "identity", position = 'stack')

#default position is stack

## calculate the total weight of Gentoo penguins
peng_2 %>%
  filter(species == 'Gentoo') %>%
  summarise(total_value = sum(body_mass, na.rm = TRUE))

peng_2 %>%
  filter(species == 'Gentoo') %>%
  pluck('body_mass') %>%
  sum(na.rm = T)

## plot average body mass of penguins by sex and species
peng_2 %>%
  ggplot(aes(x = species,
             y = body_mass,
             color = sex)) + 
  geom_bar(stat = 'identity', position = 'dodge', alpha = 0.05)
  

#total weight of all the penguins
peng_2 %>%
  summarize(total_value = sum(body_mass, na.rm = T))

# plot average body mass of penguins by sex and species
peng_2 %>%
  group_by(species, sex) %>%
  summarize(avg_mass = mean(body_mass, na.rm = T)) %>%
  ggplot(aes(x = species,
           y = avg_mass,
           fill = sex)) +
  geom_bar(stat = 'identity', position='dodge')

#2/5/2026####
# plot how many penguins observed on each island
# and their species
## (bonus) how many of them are male, female, etc.

peng <- penguins
library(tidyverse)

p <- peng %>%
  group_by(island, species, sex) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = species,
             y = count,
             fill = sex)) +
  geom_bar(stat = 'identity', position = 'dodge') + 
  #facet_wrap(~ island)

#look at the structure of p
str(p)

p + facet_wrap(sex~island)

#logical operators

penguins %>%
  filter(body_mass > 5000)

#what the previous function (filter()) is doing. Returns T/F. Filter keeps T.
penguins$body_mass > 5000

penguins %>%
  filter(!is.na(sex)) %>% View()

!is.na(penguins$sex)

# are penguins with bigger flippers heavier?
## any differences between species?
# make a plot to show that (make sure no NA for sex)

penguins %>%
  #summarize(average <- mean(flipper_len))
  #filter(flipper_len > 215) %>%
  filter(!is.na(sex)) %>%
  ggplot(aes(x = flipper_len,
         y = body_mass,
         color = species, 
         shape = sex)) +
  geom_point() +
  geom_smooth(method = "lm", color = "blue", se = F) + 
  labs(Title = 'Realationship b/t Flippers and Weight',
      x = 'Flipper (mm)',
      y = 'Weight (g)',
      color = 'Breed') + 
  scale_x_continuous(limits = c(150, 250), expand = c(0, 0)) + 
  scale_y_continuous(limits = c(2000, 8000), expand = c(0, 0)) +
  #stat_ellipse()
  #scale_color_viridis_d()
  scale_color_manual(values = c(Chinstrap = 'lightblue',
                                Gentoo = 'orange',
                                Adelie = 'green'))
  #scale_shape_manual(values = c(1, 10))



#In the directory Data_Course/Data/data-shell/names/ there are a number of subdirectories and csv files.
#Find all of those csv files and store their full absolute filepaths as a character vector in R.
base_directory <- "Data/data-shell/names/"
csv_files <- list.files(path = base_directory,
                        recursive = T,
                        full.names = T,
                        pattern = "\\.csv$")

print(csv_files)
#Read in and print just the first 2 lines from each of those files
file_list <- lapply(csv_files, read.csv)

for (df in file_list){
  print(head(df, n = 2))
}

#more compact:
lapply(csv_files, function(f) head(read.csv(f), 2))

#Find all the .txt files on your entire computer
list.files(path = "C:/Users/",
           recursive = T,
           pattern = "\\.txt$")

list.files(path = "C:/Users/jones/OneDrive/",
           recursive = T,
           pattern = "\\.txt$")

#Find all files on your computer that contain the character string “es” in the filename
list.files(path = "C:/Users",
           recursive = T,
           pattern = "es",
           full.names = T)

#2.10.2025####
#make a cool plot using penguin data (make sure no NA)
peng <- penguins
library(tidyverse)

plot_peng <- peng %>%
  filter(!is.na(year)) %>%
  filter(!is.na(sex)) %>%
  ggplot(aes(x = body_mass,
             y = bill_len,
             color = year,
             shape = sex)) + 
  geom_point() + 
  labs(title = "Bill Length vs. Body Mass",
       x = "Body mass (g)",
       y = "Bill Length (mm)") +
  scale_color_continuous(palette = c("pink3", "yellowgreen", "yellow4")) + 
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = 'italica', size = 20))
  
plot_peng + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold.italic", size = 20)) + 
  theme(axis.text = element_text(angle = 45, size = 16))


ggsave('my_plot.png', plot = plot_peng, width =10, height = 10)

peng %>%
  filter(!is.na(sex)) %>%
  ggplot(aes(x = flipper_len,
             y = body_mass,
             color = species)) +
  geom_point(color = "black") +
  geom_smooth()

setwd("Data/")
read.csv('wide_income_rent.csv')

# make a plot to show penguin weight change across 3 years
peng %>%
  filter(!is.na(body_mass)) %>%
  filter(!is.na(year)) %>%
  ggplot(aes(x = as.factor(year),
             y = body_mass,
             color = species)) +
  geom_boxplot() + 
  geom_jitter(width = 0.1, aes(color = species))


#2.17.26####
#read Data/DatasaurusDozen.tsv'
# make a good graph. First, know your data, and know your goal
dino <- read.table('Data/DatasaurusDozen.tsv')
library(readr)
dino <- read_tsv('Data/DatasaurusDozen.tsv')

library(tidyverse)

str(dino)

head(dino)

dim(dino)

unique(dino$dataset)

dino %>%
  group_by(dataset) %>%
  summarize(mean_x = mean(x),
            mean_y = mean(y),
            sd_x = sd(x),
            sd_y = sd(y),
            max_x = max(x),
            max_y = max(y))

dino %>%
  ggplot(aes(x = x,
         y = y,
         color = dataset)) +
  geom_point() + 
  facet_wrap(~ dataset)

library(GGally)
ggpairs(dino)

# install gapminder, gganimate, gifski
# take a look at gapminder and make some cool graphs
install.packages("gapminder")
install.packages("gganimate")

install.packages("gifski")

library(gapminder)
library(gganimate)
library(gifski)

peng <- penguins

dat_gap <- gapminder
ggpairs(dat_gap)

dim(dat_gap)

names(dat_gap)

View(dat_gap)

unique(dat_gap)

str(dat_gap)
range(dat_gap$year)
unique(dat_gap$year)

p <- dat_gap %>%
  group_by(continent) %>%
  ggplot(aes(x = continent,
             y = lifeExp)) + 
  geom_boxplot() + 
  labs(title = "Life Expectancy by Continent",
       x = "continent",
       y = "Life Expectancy")

animate(p, fps = 10, duration = 5)

dat_gap %>%
  ggplot(aes(x = year,
             y = lifeExp,
             color = continent)) + 
  geom_point(aes(size = pop)) +
  facet_wrap(~ continent) + 
  transition_component(year)

p <- dat_gap %>%
  ggplot(aes(x = year,
             y = lifeExp,
             color = continent)) + 
  geom_point(aes(size = pop)) +
  facet_wrap(~ continent) + 
  transition_time(year) + 
  labs(title = 'Year: {frame_time}')


anim_save("country_anim.gif", animation = p, renderer = gifski_renderer())


#2.19.26####
mice <- read.csv('SilicosisandSilicaInducedAutoimmunityintheDiversityOutbredMouse.csv')
library(tidyverse)

names(mice)
View(mice)

p <- mice %>%
  group_by(Sex) %>%
  ggplot(aes(x = Tansoral.Exposure,
             y = Total.Lung.Score,
             color = Sex)) +
  geom_boxplot() +
  labs(Title = "Total Lung score, grouped by Silicon Dose",
       x = "Tansoral Exposure",
       y = "Total Lung Score")
  
p + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold.italic", size = 20))

ggsave('my_plot.png', plot = p, width =10, height = 10)

#Create a plot showing how GDP and life expectancy have
## changed across different countries over the years
## label country
## (bonus label country of interest)
library(gapminder)
library(gganimate)
library(gifski)

country_data <- gapminder

View(country_data)

country_data %>%
  ggplot(aes(x = gdpPercap,
             y = lifeExp,
             color = continent)) +
  geom_point() +
  geom_text(aes(label = country, vjust = -0.5, hjust = -0.5)) +
  theme(legend.position = 'bottom') + 
  transition_time(year)

# make a new col
# only label countries we are interested in

cool_countries <- c("Rwanda", "Cambodia", "Kuwait", "New Zealand", "United Kingdom", "China", "Norway", "Sri Lanka")

country_data %>%
  mutate(cool_country = case_when(country %in% cool_countries ~ country)) %>%
  ggplot(aes(x = gdpPercap,
             y = lifeExp,
             color = continent)) +
  geom_point() +
  geom_text(aes(label = cool_country)) +
  theme(legend.position = 'bottom') + 
  transition_time(year)

# data cleaning
## read in 'wide_income_rent.csv' and make a plot to show
# rent in each state
dat <- read.csv('Data/wide_income_rent.csv')

dat2 <- t(dat)
dat3 <- as.data.frame(dat2)

#change 1st row into column name
dat4 <- dat3[-1, ]
View(dat4)

colnames(dat4) = c('income', 'rent')

dat4$state = rownames(dat4)

dat4 %>%
  ggplot(aes(x = state,
         y = rent)) +
  geom_bar(stat = 'identity')

# pivot_longer() and pivot_wide() functions in tidyverse
?pivot_longer() #increases number of rows, decreases number of columns
?pivot_wider() #increases number of columns, decreases number of rows

dat %>%
  pivot_longer(-variable, names_to = 'state', values_to = 'USD') %>%
  View()

dat_test <- data.frame(
  ID = c(22, 33, 45, 60),
  H = c(145, 155, 160, 132),
  W = c(32, 22, 134, 50))

dat_test %>%
  pivot_longer(c(H, W), names_to = 'measure', values_to = 'value')

dat_long <- dat_test %>%
  pivot_longer(-ID, names_to = 'measure', values_to = 'value')

dat_test %>%
  pivot_longer(cols = everything(), names_to = 'measure', values_to = 'value')

dat_long %>%
  pivot_wider(names_from = 'measure', values_from = 'value')

#make a plot
dat %>%
  pivot_longer(-variable, names_to = 'state', values_to = 'USD') %>%
  pivot_wider(names_from = 'variable', values_from = USD) %>%
  ggplot(aes(x = state,
             y = rent)) +
  geom_bar(stat = 'identity')

#make table1 to table2
table1 %>%
  pivot_longer(c(cases, population), names_to = 'type', values_to = 'count')

# make table2 like table1
table2 %>% 
  pivot_wider(names_from = 'type', values_from = 'count')

#3/3/2026####
table1
table2

# 1 observation each row
## col = 1 variable

#make table2 clean/tidy
table2 %>%
  pivot_wider(names_from = 'type', values_from = 'count')

table3 %>%
  separate(rate, into = c('cases', 'population'), convert = T) %>%
  mutate(rate = cases/population) %>%
  select(-rate)

#fix these data frames
table4a
table4b

table4a_2 <- table4a %>%
  pivot_longer(-country, names_to='year', values_to='cases')

table4b_2 <- table4b %>%
  pivot_longer(-country, names_to = 'year', values_to = 'population')

# join two data frames together
full_join(table4a_2, table4b_2)

full_join(table4a_2, table4b_2, by='country')

table5 %>%
  separate(rate, into = c('cases', 'population'), convert = T) %>%
  mutate(year = paste0(century, year) %>% as.numeric()) %>%
  select(-century)

c(table5$century, table5$year)
#paste puts a space in between

#paste0 does not give a space
paste0(table5$century, table5$year)

# read 'messy_bp.xlsv'
library(readxl)

path <- 'Data/messy_bp.xlsx'

dat <- read_xlsx(path, skip=3)

dat2 <- dat %>%
  mutate(DOB = as.Date(paste(`Year birth`, `Month of birth`, `Day birth`, sep = "-"),
           format = "%Y-%m-%d")) %>%
  select(-`Month of birth`, -`Year birth`, -`Day birth`)

dat %>%
  select(-c("HR...9", "HR...11", "HR...13")) %>%
  pivot_longer(cols = "BP...8", "BP...8")

bp <- dat %>%
  select(-starts_with('HR')) %>%
  pivot_longer(cols = starts_with('BP'),
                            names_to = 'visit',
                            values_to = 'BP') %>%
  mutate(visit = case_when(visit == 'BP...8' ~ 1,
                         visit == 'BP...10' ~ 2,
                         visit == 'BP...12' ~ 3)) %>%
  separate(BP, into = c('systolic', 'dia'))

# clean HR data and put them back
hr <- dat %>%
  select(-starts_with('BP')) %>%
  pivot_longer(cols = starts_with('HR'),
               names_to = 'visit',
               values_to = 'HR') %>%
  mutate(visit = case_when(visit == 'HR...9' ~ 1,
                           visit == 'HR...11' ~ 2,
                           visit == 'HR...13' ~ 3))

dat_clean = full_join(bp, hr)

# janitor helps clean up names with spaces
library(janitor)

dat_clean %>%
  clean_names() %>% names()

dat_clean2 <- dat_clean %>%
  clean_names() %>%
  mutate(DOB = as.Date(paste(year_birth, month_of_birth, day_birth, sep = '-')))

dat_clean2 %>%
  ggplot(aes(x = DOB, y = hr)) + 
  geom_line() +
  facet_wrap( ~ race)


dat_clean_3 <- dat_clean %>%
  clean_names() %>%
  mutate(DOB = paste(year_birth, month_of_birth, day_birth, sep = '-') %>% as.Date()) %>%
  mutate(race = case_when(race == 'Caucasian' | race == 'WHITE' ~ 'White',                        race == 'WHITE' ~ 'White',
                          TRUE ~ race))

#make sure previous script worked correctly
dat_clean_3$race %>% unique()

dat_clean_3 %>%
  ggplot(aes(x = visit, y = hr)) + 
  geom_path() +
  facet_wrap(~ race)

#blood pressure plot
dat_clean_3 = dat_clean_3 %>%
  mutate(systolic = systolic %>% as.numeric(),
         dia = dia %>% as.numeric())

dat_clean_3 %>%
  ggplot(aes(x = visit, color = race)) +
  geom_path(aes(y = systolic)) +
  geom_path(aes(y = dia)) +
  facet_wrap(~ race)

dat_clean_4 <- dat_clean_3 %>%
  pivot_longer(cols =c('systolic', 'dia'), names_to = 'bp_type',
               values_to = 'bp')

View(dat_clean_4)

dat_clean_4 %>%
  ggplot(aes(x = visit, y = bp, color = bp_type)) +
  geom_path() +
  facet_wrap(~ race)

dat_clean_4 %>%
  ggplot(aes(x = visit, y = bp, color = bp_type)) +
  geom_path() +
  facet_wrap(~ hispanic)

#3/19/2026####
#load required packages
library(tidyverse)
library(janitor)
library(skimr)

#load the bird data
birds <- read.csv('Data/Bird_Measurements.csv')

#gives a summary
birds <- read_csv('Data/Bird_Measurements.csv')
skim(birds)

#clean data
keepers <- c("Family", "Species_number", "Species_name", "English_name", 
             "Clutch_size", "Egg_mass") %>%
  str_to_lower()

str_squish() #remove whitespace

# separate male data
male <- birds %>%
  clean_names() %>%
  select(keepers, starts_with("m_"), -ends_with('_n')) %>% 
  mutate(sex = 'male')

# separate female data
female <- birds %>%
  clean_names() %>%
  select(keepers, starts_with("f_"), -ends_with('_n')) %>% 
  mutate(sex = 'female')

#separate unsexed data
unsexed <- birds %>%
  clean_names() %>%
  select(keepers, starts_with("unsexed_"), -ends_with('_n')) %>% 
  mutate(sex = 'unsexed')

#make sure that the names match
names(male) <- names(male) %>% str_remove('m_')
names(female) <- names(female) %>% str_remove('f_')
names(unsexed) <- names(unsexed) %>% str_remove('unsexed_')

identical(names(male), names(female))

# combine the data
clean_data <- full_join(male, female) %>%
  full_join((unsexed))

# make your own function
say_hello <- function(argument){
  # code to execute
  print("Hello")
}

say_hello()

add_numbers <- function(x, y){
  results <- x + y
  return(results)
}

odd_or_even <- function(x){
  if(x %% 2 == 0){
    return(paste(x, "is even"))
  }
  else{
    return(paste(x, "is odd"))
  }
}

clean_bird_data <- function(dat){
  ## data cleaning
  keepers = c('Family', 'Species_number', 'Species_name', 'English_name', 
              'Clutch_size', 'Egg_mass') %>% 
    str_to_lower()
  
  # separate male data
  male = dat %>% 
    clean_names() %>% 
    select(keepers, starts_with('m_'), -ends_with('_n')) %>% 
    mutate(sex = 'male') 
  
  # separate female data
  female = dat %>% 
    clean_names() %>% 
    select(keepers, starts_with('f_'), -ends_with('_n')) %>% 
    mutate(sex = 'female') 
  
  # separate unsexed data
  unsexed = dat %>% 
    clean_names() %>% 
    select(keepers, starts_with('unsexed_'), -ends_with('_n')) %>% 
    mutate(sex = 'unsexed') 
  
  # rename the col names
  names(male) <- names(male) %>% str_remove('m_')
  names(female) <- names(female) %>% str_remove('f_')
  names(unsexed) <- names(unsexed) %>% str_remove('unsexed_')
  
  real_clean_data = male %>% 
    full_join(female) %>% 
    full_join(unsexed)
  
  return(real_clean_data)
}

real_clean_data <- clean_bird_data(birds)

View(real_clean_data)

#3/24/2026####
# download 'height.xlsx'
## clean
library(readxl)
library(measurements)
dat <- read_excel("Data/height.xlsx")


clean <- dat %>%
  pivot_longer(cols = c(male, female), names_to = 'sex', values_to = 'height') %>%
  separate(height, into = c("feet", "inches"), convert = T) %>% # convert changes chars into numeric
  mutate(total_inches = feet*12 + inches) %>%
  mutate(cm = total_inches*2.54) %>%
  mutate(cm_convert = conv_unit(total_inches, from = 'in', to = 'cm'))#same thing, from 'measurements' package

clean %>%
  ggplot(aes(x = sex,
             y = cm_convert)) +
  geom_boxplot()

clean %>%
  ggplot(aes(x = cm, fill = sex)) +
  geom_density(alpha = 0.5)

t.test(cm ~ sex, data = clean)

glm(formula = cm ~ sex, data = clean)

clean$sex = relevel(factor(clean$sex), ref='male')

mod = glm(cm~sex, clean)

#3/26/26####
#load required packages
library(tidyverse)
library(janitor)
library(skimr)
library(ggplot2)

## does displ affect cty?
dat <- mpg

dat %>%
  ggplot(aes(x = displ, y = cty)) +
  geom_point(color = "blue") + #scatterplot
  stat_smooth(method = "lm", se = T, color="red")
  
#correlation tests
corr <- cor.test(dat$displ, dat$cty)
cor.test(dat$displ, dat$cty, method = 'spearm')

# how much does displ affect cty?
mod <- glm(cty ~ displ, data = dat)

dat %>%
  ggplot(aes(x = displ, y = cty)) +
  geom_point() +
  geom_smooth(method = 'glm') +
  scale_x_continuous(limits = c(0, 10), expand = c(0, 0)) +
  annotate('text', x = 5, y = 30,
           label = 'cty = (-2.63)*displ+25.99',
           size = 3)

mod$coefficients
mod$fitted.values

mod$residuals

#very useful package
library(easystats)
performance(mod)
report(mod)
#report on correlation test
report(corr)

# build a better model for 'cty'
## prove it's a better model
mod2 <- glm(cty ~ displ + cyl, data = dat)

mod3 <- glm(cty ~ displ + cyl + manufacturer, data = dat)

mod_max <- glm(cty~displ + manufacturer + model + year +cyl + trans, data = dat)

#compare each model's performance
performance(mod)
performance(mod2)
performance(mod3)

compare_performance(mod, mod2, mod3, mod_max)

compare_performance(mod, mod2, mod3, mod_max) %>% plot()

#3/31/26####
# build a model to predict cty as a function of displ
## mpg dataset (ggplot)
library(ggplot2)
library(easystats)
dat <- mpg

mod <- glm(data = dat,
           formula = cty~displ)
summary(mod)
report(mod)
performance(mod)

predict(mod, dat)

mod$fitted.values[1]

plot(predict(mod, dat), mod$fitted.values)

predict(mod, data.frame(displ=1:100))
dat$displ %>% range()

dat$pred = predict(mod, dat)
plot(dat$cty, dat$pred)

mod2 <- glm(cty~displ+cyl,
            data = dat)
summary(mod2)

mod3 <- glm(cty~displ + cyl + displ:cyl,
            data = dat)

dat %>%
  ggplot(aes(x = displ, y = cty, color = factor(c(cyl)))) +
  geom_point() + 
  geom_smooth(method = 'glm')

dat %>%
  ggplot(aes(x = displ, y = cty)) +
  geom_point() + 
  geom_smooth(method = 'glm')

mod5 <- glm(cty~displ + cyl + year + displ:cyl + displ:year + displ:year,
            data = dat)

# predict cty using 3 models and compare the results
model <- glm(cty~year, data = dat)
plot(predict(model, dat), mod$fitted.values)

model2 <- glm(cty~year + hwy + drv,
              data = dat)
plot(predict(model2, dat), mod$fitted.values)

dat$pred1 <- predict(mod, dat)
dat$pred2 <- predict(mod2, dat)
dat$pred3 <- predict(mod3, dat)

dat %>%
  gplot(aes(x = displ, y = pred1, color = factor(cyl))) +
  geom_point() +
  geom_smooth(method = 'glm')

dat %>%
  pivot_longer(starts_with('pred')) %>%
  ggplot(aes(x = displ, y = cty, color = factor(cyl))) +
  geom_point(aes(y = value), color = 'black') +
  geom_smooth(method = 'glm') +
  facet_wrap(~name)

