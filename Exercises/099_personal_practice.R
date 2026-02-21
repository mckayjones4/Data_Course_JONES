# Personal practice#
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
