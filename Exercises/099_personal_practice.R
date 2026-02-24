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
