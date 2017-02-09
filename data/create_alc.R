# Sampsa Huttunen, 8.2.2017, Wrangling Student Alcohol Consumption study dataset by Fabio Pagnotta & Hossain Mohammad Amran. 
# Data source: https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION

#Set working directory
setwd("I:/Google Drive/Helsingin yliopisto/Intro to Open Data Science/IODS-project/data")

# Access dplyr
library(dplyr)

# Read data from math file to 'mat' and from Portugese file to 'por'
mat = read.table("student-mat.csv", sep = ";", header = TRUE)
por = read.table("student-por.csv", sep = ";", header = TRUE)

# Explore structure and dimensions of the new datasets
dim(mat)
dim(por)
colnames(mat)
colnames(por)
head(mat)
head(por)
str(mat)
str(por)
summary(mat)
summary(por)
glimpse(mat)
glimpse(por)

# mat has 395 observations and 33 variables
# por has 649 observations and 33 variables

# Determing common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# Join datasets mat and por and add suffixes to variables
mat_por <- merge(mat, por, by = join_by, suffixes = c(".mat",".por"))

# Explore structure and dimensions of the new combined dataset 'mat_por'
dim(mat_por)
colnames(mat_por)
head(mat_por)
str(mat_por)
summary(mat_por)
glimpse(mat_por)

# Dataset mat_por has 382 observations and 53 variables

# create a new dataset 'alc' with only the joined columns from mat_por
alc <- select(mat_por, one_of(join_by))

dim(alc)
# Dataset alc now has 382 observations and 13 variables
colnames(mat)

# the columns in the original datasets which were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

# Checking columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from mat_por with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc dataset
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc dataset
    alc[column_name] <- first_column
  }
}

dim(alc)
# Dataset alc now has 382 observations and 33 variables

# Check alc column names
colnames(alc)

# New column from averages of weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# New column where high_use = TRUE, if alc_use > 2, else FALSE
alc <- mutate(alc, high_use = alc_use > 2)

# Check dimensions of alc
dim(alc)
# alc now has 382 observations and 35 variables

# Check alc column names
colnames(alc)

# Taking a peek at alc... looks kosher
glimpse(alc)

# Save joined and modified data 'alc' to a file that looks good in an EUropean verion of Excel, but also has a decimal point instead of a comma
write.table(alc, file = "alcohol-joined.csv", sep = ";", qmethod="double", row.names=FALSE)


