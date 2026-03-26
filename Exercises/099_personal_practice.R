# Personal practice
#Week 2 Practice (from 'https://gzahn.github.io/data-course/')####
# in the directory Data_Course/Data/data-shell/names/ there are a number
## of subdirectories and csv files. Find all the csv files and store their full
## absolute filepaths as a charcter vector in r
base_dir <- 'Data/data-shell/names/'
csv_files <- list.files(base_dir, pattern = "\\.csv$", recursive = T, full.names = T)

# read in and print the first 2 lines from each of these files
for(file in csv_files) {
  csv_obj <- read.csv(file)
  print(head(csv_obj, 2))
}

# find all .txt files on your entire computer
base_directory <- "C:/Users/jones/"
txt <- list.files(base_directory, pattern = '\\.txt$', recursive = T)

# find all files that contain the character string 'es' in the filename
es_files <- list.files(base_directory, pattern = 'es', recursive = T)



#Subsetting####
# Notes about vectors in R:
## In R, vectors start from '1' and not from '0'
## atomic vectors: elements of this vector are all the same type
## recursive vector: lists (because lists can have lists inside of lists)

# subsetting w/ atomic vectors (with [[ and $ operators)
x <- c(2.1, 4.2, 3.3, 5.4)

# positive integers return elements at specified positions
x[c(3,1)] #returns 3.3 and 2.1
x[order(x)] # [1] 2.1 3.3 4.2 5.4

# duplciated indices yield duplicated values
x[c(1, 1)] # 2.1 2.1

#real numbers are silently truncated to integers
x[c(2.1, 2.9)] # 4.2, 4.2

# Negative integers omit elements at specified positions
x[-c(3,1)] #4.2 5.4

# Logical vectors
x[c(TRUE, TRUE, FALSE, FALSE)]
x[x > 3]

# if the logical vector is shorter than the vector being subsetted, it will be recycled to be the same length
x[c(TRUE, FALSE)]
# is equivalent to this:
x[c(TRUE, FALSE, TRUE, FALSE)] #BOTH 2.1 3.3

# a missing value in the index always yields a missing value in the output
x[c(TRUE, TRUE, NA, FALSE)] # 2.1 4.2 NA

# nothing returns the empty vector. This isn't useful for vectors,
## but it is very useful for matrices, data frames, and arrays.
x[]

# zero returns a zero-length vector
x[0] #numeric(0)

# if the vector is named, you can use character vectors to return elements w/ matching names
(y <- setNames(x, letters[1:4]))
y[c("d", "c", "a")]
 
# subsetting lists works the same way as subsetting an atomic vector
# matrices and arrays
a <- matrix(1:9, nrow = 3)
colnames(a) <- c("A", "B", "C")
# print the first two rows [rows, columns]
a[1:2, ]

#print rows 1 and 3, columns B and A
a[c(TRUE, FALSE, TRUE), c("B", "A")]

# print header (row 0) and NOT the 2 (B) columns
a[0, -2]

# arrays in R are stored in column-major order
(vals <- outer(1:5, 1:5, FUN = "paste", sep = ","))
vals[c(4, 15)]

vals <- outer(1:5, 1:5, FUN = "paste", sep = ",")
select <- matrix(ncol = 2, byrow = TRUE, c(
  1, 1,
  3, 1,
  2, 4
))
vals[select] # "1,1" "3,1" "2,4"

# subsetting in data frames
# data frames possess the cahracteristics of both lists and matrices;
## if you subset with a single vector, they behave like lists
## if you subset with two vectors, they behave like matrices
df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df[df$x == 2, ]
df[c(1, 3), ]

# there are two ways to select columns from a data frame
# like a list:
df[c("x", "z")]
# like a matrix:
df[, c("x", "z")]

# when selecting a single column, matrix subsetting simplifies by default
str(df[, "x"])
# list subsetting does not simplify by default (when selecting a single columns)
str(df["x"])

# fix common data frame subsetting errors
mtcars[mtcars$cyl == 4, ]
mtcars[-(1:4), ]
mtcars[mtcars$cyl <= 5, ]
mtcars[mtcars$cyl %in% c(4, 6), ]

x <- outer(1:5, 1:5, FUN = "*")
x[upper.tri(x)]

mtcars[1:20, ]

# make a diagonal function
diagonal_function <- function(x) {
  x[row(x) == col(x)]
}

diagonal_function(x)
diag(x)
# [[ is similar to [, except it can only return a single value and it allows you to pull pieces out of a list
## $ is a useful shortland for [[
# you need [[ when working with lists
a <- list(a = 1, b = 2)
a[[1]]
a[["a"]]
# if you do supply a vector it indexes recursively
b <- list(a = list(b = list(c = list(d=1))))
b[[c("a", "b", "c", "d")]]

# because data frames are lists of columns, you can use [[ to extract a column from data frames
mtcars[[1]]
mtcars[["cyl"]]

# $ is a shorthand operator, where x$y is equivalent to x[["y", exact = FALSE]]

mod <- lm(mpg ~ wt, data = mtcars)
summary(mod)
mod$residuals

#Subsetting and assignment####
x <- 1:5
x[c(1, 2)] <- 2:3
x # [1] 2 3 3 4 5

# the length of the LHS needs to match the RHS
x[-1] <- 4:1
x # [1] 2 4 3 2 1

df <- data.frame(a = c(1, 10, NA))
df$a # [1]  1 10 NA
df$a[df$a<5] <- 0
df$a # [1]  0 10 NA

# subsetting w/ nothing is useful because it preserves the original object class and structure
## mtcars will remain as a data frame
mtcars[] <- lapply(mtcars, as.integer)
# mtcars becomes a list
mtcars <- lapply(mtcars, as.integer)

x <- list(a = 1, b = 2)
x[["b"]] <- NULL
str(x)

y <- list(a = 1)
y["b"] <- list(NULL)
str(y)

# applications: lookup tables (character subsetting)
x <- c("m", "f", "u", "f", "f", "m", "m")
lookup <- c(m = "Male", f = "Female", u = NA)
lookup[x]
unname(lookup[x])

# applications: matching and merging by hand (integer subsetting)
grades <- c(1, 2, 2, 3, 1)

info <- data.frame(
  grade = 3:1,
  desc = c("Excellent", "Good", "Poor"),
  fail = c(F, F, T)
)
# duplicating the into table so we have a row for each value in grades
## using match
id <- match(grades, info$grade)
info[id, ]
## using rownames
rownames(info) <- info$grade
info[as.character(grades), ]

df <- data.frame(x = rep(1:3, each = 2), y=6:1, z=letters[1:6])
#randomly reorder df
df2 <- df[sample(nrow(df)), 3:1]

df2[order(df2$x), ]

df2[, order(names(df2))]

# selecting rows based on a condition (logical subsetting)
mtcars[mtcars$gear ==5, ]
# same:
subset(mtcars, gear ==5)

#Boolean algebra vs sets (logical & integer subsetting)
x <- sample(10) < 4
which(x)

# subsetting practice with NY air quality data
aq <- airquality

aq %>%
  mutate(Date = Month + (Day/10)) %>%
  ggplot(aes(x = Date,
             y = Solar.R)) +
  geom_histogram(stat = "identity")

aq %>%
  filter(!is.na(Temp)) %>%
  ggplot(aes(x = Wind,
             y = Ozone,
             color = Temp)) +
  geom_point() +
  geom_smooth()

# 5 Ways to Subset a df in R####
### import education expenditure data set and assign column names
education <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/robustbase/education.csv", stringsAsFactors = FALSE)
colnames(education) <- c("X","State","Region","Urban.Population","Per.Capita.Income","Minor.Population","Education.Expenditures")
View(education)

ed1 <- education[c(10:21),c(2,6:7)]
#same thing
ed2 <- education[which(education$Region==2),names(education) %in% c("State","Minor.Population","Education.Expenditures")]
#same (more simple)
ed3 <- subset(education, Region ==2, select = c("State","Minor.Population","Education.Expenditures"))

library(dplyr)
ed4 <- select(filter(education, Region==2), c(State,Minor.Population:Education.Expenditures))

#Pipes in R####
# if you are piping, load this package if you aren't loading tidyverse
library(magrittr)

# pipes work by performing a 'lexical transformation'
## pipes are fundamentally linear, so don't express relationships that are too complex
rnorm(100) %>%
  matrix(ncol = 2) %T>%
  plot() %>%
  str()

#Iteration in R####
library(tidyverse)

df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)


# How to plot anything in ggplot####
data("faithful")
library(ggplot2)
library(tidyverse)

# make the points larger squares and slightly transparent.
##See `?geom_point` for more information on the point layer.
##transparency is controlled with `alpha`, and shape with `shape`
##remember the difference between mapping and setting aesthetics
ggplot(faithful) + 
  geom_point(aes(x = eruptions, y = waiting),
             shape = "c", alpha = 0.8)

# Colour the two distributions in the histogram with different colours
faithful %>%
  mutate(group = ifelse(eruptions < 3, "short", "long")) %>%
  ggplot(aes(x = eruptions, fill = group)) +
  geom_histogram(position = "dodge") +
  scale_fill_manual(values = c("red4", "blue"))

# find the medican of each column
output <- vector("double", ncol(df))
for (i in seq_along(df)) {
  output[[i]] <- median(df[[i]])
}
output

# compute the mean for each column in mtcars
means <- vector("double", ncol(mtcars))
for (i in seq_along(mtcars)) {
  means[i] <- mean(mtcars[[i]])
}
means

#same thing
sapply(mtcars, mean)

# determine the type of each columns in nycflights13::flights
library(nycflights13)

types <- vector("character", ncol(flights))

for (i in seq_along(flights)) {
  types[i] <- class(flights[[i]])
}

# compute the number of unique values in each columns in iris
unique_counts <- vector("integer", ncol(iris))

for (i in seq_along(iris)) {
  unique_counts[i] <- length(unique(iris[[i]]))
}

# generate 10 random normals from distributions with means of -10, 0, 10, and 100
means <- c(-10, 0, 10, 100)
# use a list when storing multiple numeric vectors
output_norms <- vector("list", length(means))

#rnorm(n, mean) generates random normals
for (i in seq_along(means)){
  output_norms[[i]] <- rnorm(10, mean = means[i])
}

# convert the song "99 bottles of beer on the wall" to a function.
song <- function(n, vessel = "bottles", liquid = "beer", surface = "the wall") {

for (i in n:1) {
  print(paste(i, vessel, "of", liquid, "on", surface))
  print(paste(i, vessel, "of", liquid))
  print("Take one down, pass it around")
}
  print(paste("no more", vessel, "of", liquid, "on", surface))
}

song(5)

# rowwise() in 'dplyr' package performs operations row-by-row (instead column/group wise default)

# factor exercises####
library(gapminder)
data("gapminder")
df <- gapminder

# add "Antarctica" to the levels of possible continents
levels(df$continent) <- c(levels(df$continent), 'Antarctica')
levels(df$continent)

# add 3 more continents to the factor levels
levels(df$continent) <- c(levels(df$continent), 'North America', 'South America', 'Central America')
levels(df$continent)

south <- c("Argentina", "Bolivia", "Brazil", "Chile", "Colombia", "Ecuador", "Paraguay", "Peru", "Uruguay", "Venezuela")
north <- c("United States", "Canada", "Mexico")
central <- c("Costa Rica", "El Salvador", "Guatemala", "Honduras", "Nicaragua", "Panama", "Dominican Republic")
# currently, all of these countries are in the 'Americas' continent group. Move them into their respective continents
df$continent[df$country %in% south] <- "South America"
df$continent[df$country %in% north] <- "North America"
df$continent[df$country %in% central] <- "Central America"

#clean up the 'continent' categories to remove "Americas" and "Antarctica"
df2 <- droplevels(df)
levels(df2$continent)

ggplot(df, aes(x = continent, y = lifeExp)) +geom_boxplot()

# remake the plot so the bars are in descending order
df %>%
  mutate(continent = fct_reorder(continent, lifeExp, .fun = median, .desc = T)) %>%
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot()

# 04_Characters ####
library(tidyverse)

vector = "Good morning! "
# how many characters?
nchar(vector) #14

x <- c("Open", "Sesame ")
y <- c("You", "Suck.")
nchar(x) # 4 7
nchar(c(x, y)) # 4 7 3 5

m <- "The capital of the United States is Washington, D.C."
unlist(str_split(m, " "))

#trunate a string to a specified maximum width 
str_trunc(m,11, ellipsis = "")
str_sub(m, start = 13, end = 25)

#extract Washington from m
str_sub(m, start = 37, end = 46)

paste(m, ", you idiot!", sep = '')
o <- "United States"
paste(o, ", you idiot!", sep = '')

d <- str_split(c(q, paste0(m,", you idiot!")), pattern = " ")

c(unlist(map(d,1)), "Heck!?")

unlist(map(d,2))

t <- c("a", "ab", "c", "d", "e", "fa")
grep("a",t) # 1 2 6
grepl("a",t)
f <- c("b", "ca", "at", "c", "e", "aa")
#lists within a list
v = list(f,t)

grep("a", v) # 1 2
grepl("a", v) # TRUE TRUE

grep("What",d) # integer(0)
grepl("What",d) # FALSE FALSE

q <- "What is the capital of the United States?"
str_replace(q, "a", "A")

# Change all spaces to underscores in the q vector
str_replace_all(q, " ", "_")

# 02_Regular Sequences
seq(1,10, by=2) # 1 3 5 7 9
seq(1, 10, by = 3) # 1 4 7 10

seq(9,45, by = 9)

seq(1,10, length.out=5)
seq(1,10, length.out=3)

x=1:5
rep(x,2)
rep(x,2, each=2)
rep(x,each=4)

x = "Hip"
y = "Hooray"
rep(c(rep(x,2),y),3)

# create a sequence with values (in this order)
rev(seq(50, 100, by=5)) # 100  95  90  85  80  75  70  65  60  55  50

Semester_Start = as.Date("2019-08-19")
Semester_End = as.Date("2019-12-05")
seq(Semester_Start, Semester_End,by="week")

midterm = seq(Semester_Start, Semester_End, length.out = 3) [2] # "2019-10-12"

# 03_Indexing
x = c('ss', 'aa', 'ff', 'kk', 'bb')
x[1]

x[c(1,3)] #'ss' 'ff'

d <- data.frame(Name = c("Betty", "Bob", "Susan"),
                Age = seq(20, 30, length.out = 3),
                Height_cm = c(490, 22, 0))

d[c("Name", "Age")]

#Just print Betty's row
d[c("Name", "Age", "Height_cm")][1,]

#Same thing
d[1,]

d$Name 
d$Age[2] #25

d$Age > 20

d[d$Age > 20,]

d[d$Height_cm < 100,]

d[1, c("Name", "Age")]


# Missing Values
X = c(NA, 3, 14, NA, 33, 17, NA, 41)
is.na(X)
X[!is.na(X)]

Y = 21:28
Z = data.frame(X, Y)

# replace all NAs with 0
Z[is.na(Z)] <- 0

P = c(X, 33, NA, 400, 12, 0, 15)
# replace all instances of "NA" with the number 10
P[is.na(P)] <- 10

W <- c(11, 3, 5, NA, 6)

A <- c(33, 21, 12, NA, 7, 8)
mean(A, na.rm = T)

#load 'Orange' dataset
data(Orange)
head(Orange)
O <- Orange

# Replace all values of age=118 with NA
O$age[O$age==118] <- NA

# same thing (in tidyverse)
O %>%
  mutate(age = ifelse(age == 118, NA, age))

c1 <- c(1, 2, 3, NA)
c2 <- c(2, 4, 6, 89)
c3 <- c(45, NA, 66, 101)
X <- data.frame(c1, c2, c3)

X
complete.cases(X)
# display only the rows with missing values
X[!complete.cases(X), ]

df <- data.frame(Name = c("NA", "Joseph", "Martin", NA, "Andrea"),
                 Sales = c(15, 18, 21, 56, 60),
                 Price = c(34, 52, 21, 44, 20),
                 stringsAsFactors = FALSE)


df_clean <- df[!is.na(df$Name) & df$Name != "NA", ]

#same thing in tidyverse
df_clean <- df %>%
  filter(!is.na(Name), Name != "NA")
df_clean




# 08_Loops####
# write a loop that iterates over the numbers 1 to 7 and prints the cube of each number
for(i in 1:7){
  print(i*i)
}

# write a loop that iterates over the column names of the iris dataset
## print each together w/ the number of characters in the column name in paranthesis
## Example: Sepal.Length (12) 
for (n in colnames(iris)){
  print(paste0(n, " (", nchar(n), ")"))
}

# write a while loop that prints out standard random normal numbers (rnorm()) but stops if you get a number > 1
x <- rnorm(1)

while (x <= 1) {
  print(x)
  x <- rnorm(1)
}

# simulate the coin flip 20 times (1 = heads, 0 = tails)
outcomes <- vector()
for (i in 1:20){
  outcomes[i] <- sample(0:1, 1)
}

# investigate the number of times before the produce 123*4 reaches above 10 million
n <- 1
product <- 1
iteration <- 0
while (product < 10000000){
  product <- product*n
  print(product)
  n=n+1
  iteration=iteration+1
}
print(iteration)

# use a while loop to simulate one stock price path starting at 100 and randomly normally distributed percentage jumps
## with mean 0 and sd 0.01 each period.
## How long does it take to reach above 150 or below 50?
price <- 100
time <- 0
while (price>50 & price<150) {
  price = price + rnorm(1, mean = 0, sd = 0.01)
  print(price)
  time = time+1
}

#06_logical_operations####
# output only the rows of mtcars where mpg is between 15 and 20
mtcars %>%
  filter(mtcars$mpg > 15 & mtcars$mpg < 20)

# output only rows where column cycl is equal to 6 and column am is not 0
mtcars %>%
  filter(mtcars$cyl==6 & mtcars$am!=0)

# output where column gear or carb has the value 4
mtcars %>%
  filter(mtcars$gear==4 | mtcars$carb==4)

# output only even rows of mtcars
even_rows <- mtcars[seq_len(nrow(mtcars)) %% 2==0, ]
even_rows

# same thing in tidyverse
mtcars %>%
  filter(row_number() %% 2 ==0)

# change every fourth element in column mpg to 0
mtcars %>%
  mutate(mpg = ifelse(row_number()%%4==0, 0, mpg))

#output only the rows of mtcars where columns vs amd am have the same value 1, solve this w/o == operator
mtcars %>%
  filter(vs==0 & am==0)

mtcars %>%
  filter(!xor(vs, am))

# output only rows of mtcars where at least vs or am have the value 1
mtcars %>%
  filter(xor(vs, am))

# change all values that are 0 in the column am in mtcars to 2
mtcars %>%
  mutate(am = ifelse(am==0, 2, am))

# add 2 to every element in the column 'vs' without using numbers
mtcars %>%
  mutate(vs = vs+(TRUE+TRUE))

# output only those rows of data where vs and am have different values
## solve this w/o using == or !=
mtcars %>%
  filter(xor(vs, am))

#Data Visualization####
ggplot(data = mpg, mapping=aes(x = displ, y=hwy, color=drv)) +
  geom_point() +
  geom_smooth(se = F)

ggplot(data = mpg, mapping=aes(x = displ, y = hwy)) +
  geom_point(mapping=aes(x=displ, y=hwy, color=drv))
  #geom_smooth(mapping=aes(x=displ, y=hwy, linetype = drv), se=F)

# geom_col represents actual values in the data
ggplot(data = diamonds, mapping=aes(x=cut, y = depth)) +
  geom_col()

# geom_bar() makes the height of the bar proportional to the number of cases in each group
ggplot(data = diamonds, mapping=aes(x=cut, fill = cut)) +
  geom_bar()

# in clarity, the bars are automatically stacked
diamonds %>%
  ggplot(aes(x=cut, fill = clarity)) +
  geom_bar()

# position = 'dodge' places overlapping objects directly beside one another
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x=cut, fill=clarity), position = 'dodge')

# to see where the 'mass' of data is (that is covered up by overplotting), use 'jitter'
## position='jitter' adds a small amount of random noise to each point
ggplot(data = mpg) +
  geom_point(mapping=aes(x=displ, y=hwy), position = 'jitter')

# coord_flip() switches the x and y axes
ggplot(data = mpg, mapping=aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip() +
  geom_image(aes(image=image), size=0.2) +
  theme_minimal()
  
# coord_quickmap() sets the aspect ratio correctly for map (really useful for spatial data)
nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill="white", colour = "black") +
  coord_quickmap()

data("CO2")
means <- CO2 %>%
  group_by(Type, Treatment, conc) %>%
  summarize(MeanUptake = mean(uptake), .groups = "drop")

ggplot(means, aes(x=conc, y=MeanUptake, color=Treatment)) +
  geom_point() +
  facet_grid(~Type)


#UGLY PLOT####
air <- airquality

library(ggimage)

img_path <- 'Data/ozone_hole.webp'

ugly <- air %>%
  filter(!is.na(Temp)) %>%
  ggplot(aes(x = Wind, y = Ozone)) +
  
  # Replace points with images
  geom_image(aes(image = img_path), size = 0.15) +
  
  # Make the smooth line ugly and thick
  geom_smooth(color = "limegreen", fill = "magenta", size = 4, linetype = 3) +
  
  # Add unreadable text labels in bad places
  geom_text(aes(label = Wind),
            size = 8,
            angle = 75,
            vjust = -10,
            hjust = 5,
            color = "yellow") +
  
  # Make the Temp legend hideous
  scale_color_gradientn(
    colors = c("hotpink", "cyan", "yellow", "chartreuse", "orange"),
    name = "TEMP??",
    labels = c("TOO COLD", "MEH", "WAY TOO HOT")
  ) +
  
  # Move axis labels to bizarre places
  labs(
    x = "WIND???",
    y = "OZONE MAYBE??",
    title = "OZONE OZONE",
  ) +
  
  # Push labels off the page
  theme(
    axis.title.x = element_text(size = 30, color = "red", vjust = -2),
    axis.title.y = element_text(size = 30, color = "blue", hjust = -1),
    axis.text.x = element_text(size = 18, angle = 120, hjust = -1, color = "purple"),
    axis.text.y = element_text(size = 18, angle = 45, vjust = 1, color = "darkgreen"),
    
    # Make background aggressively ugly
    plot.background = element_rect(fill = "yellow"),
    panel.background = element_rect(fill = "hotpink"),
    
    # Add thick, clashing gridlines
    panel.grid.major = element_line(color = "orange", size = 3),
    panel.grid.minor = element_line(color = "red", size = 2),
    
    # Make the legend huge and intrusive
    legend.position = "bottom",
    legend.background = element_rect(fill = "chartreuse"),
    legend.text = element_text(size = 20, face = "bold")
  )
ggsave('ugly_plot.png', plot = ugly, width =10, height = 10)

#cleaning BP data####
library(readxl)

path <- 'Data/messy_bp.xlsx'

dat <- read_xlsx(path, skip=3)

#clean DOB data
dat_clean <- dat %>%
  clean_names %>%
  mutate(DOB = as.Date(paste(year_birth, month_of_birth, day_birth, sep = '-')))

bp = dat_clean %>%
  select(-starts_with('HR')) %>%
  pivot_longer(cols = starts_with('BP'),
               names_to = 'visit',
               values_to = 'BP') %>%
  mutate(visit = case_when(visit == 'bp_8' ~ 1,
                           visit == 'bp_10' ~ 2,
                           visit == 'bp_12' ~ 3)) %>%
  separate(BP, into = c('sys', 'dia'))

hr <- dat_clean %>%
  select(-starts_with('bp')) %>%
  pivot_longer(cols = starts_with('hr'),
               names_to = 'visit',
               values_to = 'hr') %>%
  mutate(visit = case_when(visit == 'hr_9' ~ 1,
                           visit == 'hr_11' ~2,
                           visit == 'hr_13' ~3))


dat_clean_2 = full_join(bp, hr)

dat_clean_3 <- dat_clean_2 %>%
  select(-month_of_birth, -day_birth, -year_birth)

View(dat_clean_3)

dat_clean_4 <- dat_clean_3 %>%
  mutate(race = case_when(race == 'WHITE' ~ 'White',
                          race == 'Caucasian' ~ 'White',
                          TRUE ~ race))

dat_clean_4 %>%
  pivot_longer(cols = c('sys', 'dia'), names_to = 'bp_type',
               values_to = 'bp') %>%
  mutate(bp = bp %>% as.numeric()) %>%
  ggplot(aes(x = visit, y = bp, color = bp_type)) +
  geom_path() +
  facet_wrap(~hispanic)
