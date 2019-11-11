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


# Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions in the learning14 data
# basedata already has gender, age, attitude and points so I'll copy basedata to a new analysis_dataset
analysis_dataset <- basedata

# Creating combination variables for questions related to deep, strategic and surface learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")

#Scaling all combination variables to the original scales by taking the mean and putting them in as columns in analysis_dataset
deep_columns <- select(basedata, one_of(deep_questions))
analysis_dataset$deep <- rowMeans(deep_columns)

surface_columns <- select(basedata, one_of(surface_questions))
analysis_dataset$surf <- rowMeans(surface_columns)

strategic_columns <- select(basedata, one_of(strategic_questions))
analysis_dataset$stra <- rowMeans(strategic_columns)


# Exclude observations where the exam points variable is zero. (The data should then have 166 observations and 7 variables) 
analysis_dataset2 <- filter(analysis_dataset, Points > 0)

# Reduce the dataset to gender, age, attitude, deep, stra, surf and points
columns_to_keep <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

analysis_dataset3 <- select(analysis_dataset2, one_of(columns_to_keep))

#checking the structure of the data, seems right has 166 obs. 7 variables as instructed.
str(analysis_dataset3)
# 'data.frame':	166 obs. of  7 variables:
# $ gender  : Factor w/ 2 levels "F","M": 1 2 1 2 2 1 2 1 2 1 ...
# $ Age     : int  53 55 49 53 49 38 50 37 37 42 ...
# $ Attitude: int  37 31 25 35 37 38 35 29 38 21 ...
# $ deep    : num  3.58 2.92 3.5 3.5 3.67 ...
# $ stra    : num  3.38 2.75 3.62 3.12 3.62 ...
# $ surf    : num  2.58 3.17 2.25 2.25 2.83 ...
# $ Points  : int  25 12 24 10 22 21 21 31 24 26 ...


# Data Wrangling step 4.
getwd()
#getwd() indicates that my iods project folder is already my current working directory

#setwd() to set my directory to the data folder to save the csv there.
setwd("C:/Users/OMISTAJA/Documents/IODS-project/data")

#write the csv
write.csv(analysis_dataset3, file ="learning2014.csv")

#Demonstrate that you can also read the data again by using read.table() or read.csv().
#(Use `str()` and `head()` to make sure that the structure of the data is correct).
str(read.csv("learning2014.csv"))
head(read.csv("learning2014.csv"))