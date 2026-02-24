# Consider the following data frame filled with random data:

df <- data.frame(Species = rep(c("Cat","Dog","Mouse"),each=10),
                 Length = 5+rnorm(30),
                 Width = 10+rnorm(30))                 

df # take a quick look at it


# The rest of the code (starting on line 25) is out of order. 
# Can you match the code below with the comments (lines 14 - 22) describing what is happening?


# Add a new column to the data frame that represents "area" ####
df$Area <- df$Length*df$Width

# Save just the "cat" area values as a new vector called cat_area ####
cat_rows <- which(df$Species == "Cat")
cat_area <- df[cat_rows,"Area"]

# Subset dat to just display the rows (all columns) where Species == Dog ####
dog_rows <- which(df$Species == "Dog")

# Save that "Dog" subset as it's own .csv file please. ####
dog <- df[dog_rows,]
write.csv(dog, "Dog_Subset.csv")

# Plot Length vs Width of the full dat data frame and color the points by species ####
plot(x=df$Length,y=df$Width,col=df$Species, pch=19)
