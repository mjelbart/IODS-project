# Author: Michael Jelbart
# Date: 16/11/2019
# Description: Introduction to Open Data Science 2019, Week 3: Logistic Regression 
# using data available through https://archive.ics.uci.edu/ml/datasets/Student+Performance

getwd()
library(dplyr)

# 3. Reading in the data sets and exploring the stucture and dimensions.
student_math <- read.table("data/student-mat.csv", header=TRUE, sep=";")
student_port <- read.table("data/student-por.csv", header=TRUE, sep=";")
dim(studentmath)
str(studentmath)
dim(studentport)
str(studentport)

# 4a. Joining the two datasets using the variables "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet" as (student) identifiers.
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")

student_combo <- inner_join(student_math, student_port, by = join_by, suffix = c(".math", ".port"))

# a note on inner_join - return all rows from x where 
# there are matching values in y, and all columns from x and y. 
# If there are multiple matches between x and y, all combination of the matches are returned.

# 4b. Keeping only the students present in both data sets - ??? I'm not sure on this.

# the structure and dimensions of the joined data.
dim(student_combo)
str(student_combo)
glimpse(student_combo)


# 5. Copy the solution from the DataCamp exercise 'The if-else structure' to combine the 'duplicated' answers in the joined data

# create a new data frame with only the joined columns
alc <- select(student_combo, one_of(join_by))

# create a new data frame with the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(student_combo, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)


# 6. Take the average of the answers related to weekday and weekend alcohol consumption
# to create a new column 'alc_use' to the joined data. 
# Then use 'alc_use' to create a new logical column 'high_use' 
# which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise).

