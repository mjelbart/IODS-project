# Author: Michael Jelbart
# Date: 11/11/2019
# Description: Introduction to Open Data Science 2019, Week 2: Regression and model validation
#loading the dplyr library to access the select() function
library(dplyr)

# Reading the data into memory
# The data has headers
# tab (\t) the is separator
basedata <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header=TRUE, sep="\t")

# dim() tells me the data has 183 rows and 60 columns
dim(basedata)

# str() shows all 60 variables and a sample of the responses
str(basedata)

analysis_dataset

# Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions in the learning14 data

#Adding the single question variables to the lrn14 data frame
analysis_dataset <- learning14$gender
analysis_dataset$age <- learning14$age
lrn14$points <- learning14$Points

# Creating combination variables for questions related to attitude, deep, strategic and surface learning
attitude_questions <- c("Da", "Db", "Dc", "Dd", "De", "Df", "Dg", "Dh", "Di", "Dj")
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")

#Scaling all combination variables to the original scales by taking the mean and putting them in columns of lrn14
attitude_columns <- select(learning14, one_of(attitude_questions))
lrn14$attitude <- rowMeans(attitude_columns)

deep_columns <- select(learning14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

surface_columns <- select(learning14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

strategic_columns <- select(learning14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)


# Exclude observations where the exam points variable is zero. (The data should then have 166 observations and 7 variables) 
lrn14_withoutPointsZero <- filter(lrn14, points > 0)

# Checking lrn14, it has all the questions in it plus the combination ones. 
str(lrn14_withoutPointsZero)
# I'll reduce the dataset to gender, age, attitude, deep, stra, surf and points
columns_to_keep <- c("gender","Age","Attitude", "deep", "stra", "surf", "points")




