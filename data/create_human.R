# Data Wrangling
# 2.
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

if (!require("devtools")) install.packages("devtools")
library(devtools)
install_github("husson/FactoMineR")
install.packages(FactoMineR)

# 3. Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables.

str(hd)
str(gii)

summary(hd)
summary(gii)

# 4. Look at the meta files and rename the variables with (shorter) descriptive names.
library(tidyverse)
hd1 <- hd %>% 
  rename(
    hdi = Human.Development.Index..HDI.,
    Life.Exp = Life.Expectancy.at.Birth,
    Edu.Exp = Expected.Years.of.Education,
    mean.edu = Mean.Years.of.Education,
    GNI = Gross.National.Income..GNI..per.Capita,
    gni.hdi = GNI.per.Capita.Rank.Minus.HDI.Rank
  )

gii1 <- gii %>% 
  rename(
    gii = Gender.Inequality.Index..GII.,
    Mat.Mor = Maternal.Mortality.Ratio,
    Ado.Birth = Adolescent.Birth.Rate,
    Parli.F = Percent.Representation.in.Parliament,
    seced.fem = Population.with.Secondary.Education..Female.,
    seced.mal = Population.with.Secondary.Education..Male.,
    lfpr.fem = Labour.Force.Participation.Rate..Female.,
    lfpr.mal = Labour.Force.Participation.Rate..Male.
  )
summary(gii1)

# 5. Mutate the “Gender inequality” data and create two new variables. 
# The first one should be the ratio of Female and Male populations with secondary education in each country. (i.e. edu2F / edu2M). 
# The second new variable should be the ratio of labour force participation of females and males in each country (i.e. labF / labM).

gii1 <- gii1 %>% mutate(Edu2.RM = seced.fem/seced.mal)
gii1 <- gii1 %>% mutate(Labo.FM = lfpr.fem/lfpr.mal)


# 6. Join together the two datasets using the variable Country as the identifier. 
# Keep only the countries in both data sets (Hint: inner join). 
# The joined data should have 195 observations and 19 variables. 
# Call the new joined data "human" and save it in your data folder.

human <- inner_join(hd,gii1,by="Country")
dim(human) 
write.csv(human, file="data/human.csv", row.names = FALSE)
summary(read.csv("data/human.csv", sep = ","))


# Week 5 data wrangling

# 5.0
human <- read.csv("data/human.csv", sep = ",")
str(human$GNI)

# 5.1
human <- mutate(human, GNI = as.numeric(human$GNI))

class(human$GNI)
human$GNI



# 5.2 
# defining columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")



# 5.3 Remove all rows with missing values
# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))

complete.cases(human_)



# 5.4 Remvoe  the observations which relate to regions instead of countries
# checking which observations relate to regions instead of countries
human$Country
# the last seven entries are for regions

# define the last indice we want to keep
# nrow provides the number of rows
last <- nrow(human) - 7

# choose everything until the last 7 observations
human_ <- human[1:last, ]



# 5.5 Define the row names of the data by the country names and remove the country name column from the data.
rownames(human_) <- human_$Country

# remove the Country variable (the countries are still the row names)
human_2 <- dplyr::select(human_, -Country)

# The data should now have 155 observations and 8 variables. 
str(human_2)
# Save the human data 
write.csv(human_2, file="data/human_2.csv", row.names = TRUE)

