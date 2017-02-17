
#Set working directory
setwd("I:/Google Drive/Helsingin yliopisto/Intro to Open Data Science/IODS-project/data")

#Read the "Human development" and "Gender inequality" datas
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Explore the datasets
dim(hd)
colnames(hd)
str(hd)
summary(hd)
dim(gii)
colnames(gii)
str(gii)
summary(gii)

#Rename the variables
colnames(hd)[1] <- "HDI ranking"
colnames(hd)[2] <- "Country"
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "LifeExp"
colnames(hd)[5] <- "ExpEduYrs"
colnames(hd)[6] <- "MeanEduYrs"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNIminusHDIrank"

colnames(gii)[1] <- "GII ranking"
colnames(gii)[2] <- "Country"
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "MMR"
colnames(gii)[5] <- "ABR"
colnames(gii)[6] <- "FemaleParliament"
colnames(gii)[7] <- "EduFemale"
colnames(gii)[8] <- "EduMale"
colnames(gii)[9] <- "LabourFemale"
colnames(gii)[10] <- "LabourMale"

#Check the new variable names
colnames(hd)
colnames(gii)

#Mutate the Gender inequality data and create two new variables
gii$EduRatio <- gii$EduFemale / gii$EduMale
gii$LabourRatio <- gii$LabourFemale / gii$LabourMale

#Checking variable names and structure of Gender inequality data
colnames(gii)
str(gii)

# Joining the datasets using Country as identifier
human <- inner_join(hd, gii, by = "Country")

#Checking variable names and structure of the new combined dataset
colnames(human)
str(human)

#Checking dimensions of the new dataset: 195 observations and 19 variables
dim(human)

# Save joined and modified data 'human' to a file that looks good in an European version of Excel, but also has a decimal point instead of a comma
write.table(human, file = "human.csv", sep = ";", qmethod="double", row.names=FALSE)


