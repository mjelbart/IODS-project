# Staring by checking my working directory
getwd()

# Reading in the data
students2014 <- read.table("learning2014.txt", header=TRUE, sep=",")

# Explore the structure of the data
str(students2014)

# Explore the dimensions of the data 
dim(students2014)

students2014


# describe the dataset briefly, assuming the reader has no previous knowledge of it. 
# There is information related to the data here. (0-2 points)
#(Introduction to Social Statistics, fall 2014 - in Finnish),
#international survey of Approaches to Learning
#Data collected: 3.12.2014 - 10.1.2015/KV
#Data created: 14.1.2015/KV, in English 9.4.2015/KV,Florence,Italy



summary(students2014)