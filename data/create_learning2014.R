# Author: Michael Jelbart
# Date: 11/11/2019
# Description: Introduction to Open Data Science 2019, Week 2: Regression and model validation

# Reading the data into memory
# The data has headers
# tab (\t) the is separator
mydata <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header=TRUE, sep="\t")

# dim() tells me the data has 183 rows and 60 columns
dim(mydata)

# str() shows all 60 variables and a sample of the responses
str(mydata)