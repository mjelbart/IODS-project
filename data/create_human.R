# Data Wrangling
# 2.
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


# 3. Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables.

str(hd)
str(gii)

summary(hd)
summary(gii)

# 4. Look at the meta files and rename the variables with (shorter) descriptive names.
library(tidyverse)
hd %>% 
  rename(
    Human.Development.Index..HDI. = hdi,
    Life.Expectancy.at.Birth = life.expec,
    Expected.Years.of.Education = expec.edu,
    Mean.Years.of.Education = mean.edu,
    Gross.National.Income..GNI..per.Capita = gni,
    GNI.per.Capita.Rank.Minus.HDI.Rank = gni.hdi
  )

gii %>% 
  rename(
    Gender.Inequality.Index..GII. = gii,
    Maternal.Mortality.Ratio = matmort,
    Adolescent.Birth.Rate = birth,
    Percent.Representation.in.Parliament = parliment,
    Population.with.Secondary.Education..Female. = seced.fem,
    Population.with.Secondary.Education..Male. = seced.mal,
    Labour.Force.Participation.Rate..Female. = lfpr.fem,
    Labour.Force.Participation.Rate..Male. = lfpr.mal
  )


# 5. Mutate the “Gender inequality” data and create two new variables. 
# The first one should be the ratio of Female and Male populations with secondary education in each country. (i.e. edu2F / edu2M). 
# The second new variable should be the ratio of labour force participation of females and males in each country (i.e. labF / labM).

mutate(gii,)

# 6. Join together the two datasets using the variable Country as the identifier. 
# Keep only the countries in both data sets (Hint: inner join). 
# The joined data should have 195 observations and 19 variables. 
# Call the new joined data "human" and save it in your data folder.

