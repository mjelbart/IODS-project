# Chapter 6

# 1. Load the dataset

BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep = " ")

RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = "\t")

str(BPRS)
str(RATS)

# write the datasets to my data folder

write.csv(BPRS, file="data/bprs.csv", row.names = TRUE)

write.csv(RATS, file="data/rats", row.names = TRUE)




# 2. Convert the categorical variables of both data sets to factors. (1 point)
# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)



# 3. Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS. (1 point)
# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5,5)))

glimpse(BPRS)


# Convert to long form
RATSL <-  RATS %>% gather(key = WD, value = rats, -ID, -Group)
RATSL

# Extract the week number
RATSL <-  RATSL %>% mutate(week = as.integer(substr(WD, 3,4)))



# 4. Now, take a serious look at the new data sets and compare them with their wide form versions:
# Check the variable names, 
# view the data contents and structures, and 
# create some brief summaries of the variables. 

glimpse(BPRS)
glimpse(BPRSL)
glimpse(RATS)
glimpse(RATSL)

str(BPRS)
str(BPRSL)
str(RATS)
str(RATSL)

summary(BPRS)
summary(BPRSL)
summary(RATS)
summary(RATSL)

# Make sure that you understand the point of the long form data 
# and the crucial difference between the wide and the long forms before proceeding the to Analysis exercise. (2 points)
