#lists all of the .csv files found in the directory and stores that list in an object called “csv_files”
setwd("C:/Users/jones/OneDrive/Desktop/data_course_JONES/")

csv_files <- list.files(path = "C:/Users/jones/OneDrive/Desktop/data_course_JONES/Data",
           recursive = FALSE,
           pattern = ".csv")
csv_files
#how many files match that description using the length() function
length(csv_files)

#Open the wingspan_vs_mass.csv file and store the contents as an R object named “df” using the read.csv() function
df <- read.csv("C:/Users/jones/OneDrive/Desktop/data_course_JONES/Data/wingspan_vs_mass.csv")

#Inspect the first 5 lines of this data set using the head() function
head(df, 5)

#Find any files (recursively) in the Data/ directory that begin with the letter “b” (lowercase)
base_directory <- "C:/Users/jones/OneDrive/Desktop/data_course_JONES/Data"
begin_with_b <- list.files(path = base_directory,
                        recursive = TRUE,
                        pattern = "^b")
begin_with_b

#Write a command that displays the first line of each of those “b” files
for (file in begin_with_b) {
  full_path <- file.path(base_directory, file)
  con <- file(full_path, "r")
  
  print(readLines(con, n=1))
  close(con)
}

#Do the same thing for all files that end in “.csv”
for (file in csv_files) {
  full_path <- file.path(base_directory, file)
  con <- file(full_path, "r")
  
  print(readLines(con, n=1))
  close(con)
}

