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

#5. Find how many files fit that description (145)
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
