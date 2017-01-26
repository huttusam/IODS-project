# Sampsa Huttunen, 26.1.2017, My first R Script

# reading data from a file
JYTOPKYS3_data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = TRUE) 

# viewing JYTOPKYS3_data: a dataset containing information of 183 individuals
View(JYTOPKYS3_data) 

# inspecting JYTOPKYS3_data
str(JYTOPKYS3_data) 

# inspecting JYTOPKYS3_data
summary(JYTOPKYS3_data) 

# Access the ggplot2 library
library(ggplot2)

# to be continued ...
