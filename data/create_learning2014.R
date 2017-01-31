# Sampsa Huttunen, 26.1.2017, My first R Script

# Access the dplyr library
library(dplyr)

# reading data from a file
JYTOPKYS3_data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = TRUE)

# viewing JYTOPKYS3_data: a dataset containing information of 183 individuals
View(JYTOPKYS3_data)

# inspecting JYTOPKYS3_data
dim(JYTOPKYS3_data)

# inspecting JYTOPKYS3_data
str(JYTOPKYS3_data)

# inspecting JYTOPKYS3_data
summary(JYTOPKYS3_data)

# Changing name of Age to age
colnames(JYTOPKYS3_data)[57] <- "age"

# Changing name of Attitude to attitude
colnames(JYTOPKYS3_data)[58] <- "attitude"

# Changing name of POints to points
colnames(JYTOPKYS3_data)[59] <- "points"

# print out the column names in data
colnames(JYTOPKYS3_data)

# choosing questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06", "D15", "D23", "D31")
surface_questions <- c("SU02", "SU10", "SU18", "SU26", "SU05", "SU13", "SU21", "SU29", "SU08", "SU16", "SU24", "SU32")
strategic_questions <- c("ST01", "ST09", "ST17", "ST25", "ST04", "ST12", "ST20", "ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(JYTOPKYS3_data, one_of(deep_questions))
JYTOPKYS3_data$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(JYTOPKYS3_data, one_of(surface_questions))
JYTOPKYS3_data$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(JYTOPKYS3_data, one_of(strategic_questions))
JYTOPKYS3_data$stra <- rowMeans(strategic_columns)

# creating a set of specific columns
keep_columns <- c("gender", "age", "attitude", "deep", "stra", "surf", "points")

# create a new dataset by choosing 'keep_columns' from the original dataset
analysis_dataset <- select(JYTOPKYS3_data, one_of(keep_columns))

# print out the column names in the new dataset
colnames(analysis_dataset)

# exclude observations where points = 0
analysis_dataset <- filter(analysis_dataset, points != 0)

# checking the number of observations and variables in the new dataset
dim(analysis_dataset)

setwd("i:/Google Drive/Helsingin yliopisto/Intro to Open Data Science/IODS-project")

# Write dataset to csv file
write.csv(analysis_dataset, file = "data/analysis_dataset.csv")

# read dataset from a csv file to 'read_dataset'
read_dataset <- read.csv("data/analysis_dataset.csv", header = TRUE, row.names = 1)

# checking the dataset structure
str(read_dataset)
head(read_dataset)
View(read_dataset)
