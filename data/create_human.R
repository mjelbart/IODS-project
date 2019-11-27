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
hd1 <- hd %>% 
  rename(
    hdi = Human.Development.Index..HDI.,
    life.expec = Life.Expectancy.at.Birth,
    expec.edu = Expected.Years.of.Education,
    mean.edu = Mean.Years.of.Education,
    gni = Gross.National.Income..GNI..per.Capita,
    gni.hdi = GNI.per.Capita.Rank.Minus.HDI.Rank
  )

gii1 <- gii %>% 
  rename(
    gii = Gender.Inequality.Index..GII.,
    matmort = Maternal.Mortality.Ratio,
    birth = Adolescent.Birth.Rate,
    parliment = Percent.Representation.in.Parliament,
    seced.fem = Population.with.Secondary.Education..Female.,
    seced.mal = Population.with.Secondary.Education..Male.,
    lfpr.fem = Labour.Force.Participation.Rate..Female.,
    lfpr.mal = Labour.Force.Participation.Rate..Male.
  )
summary(gii1)

# 5. Mutate the “Gender inequality” data and create two new variables. 
# The first one should be the ratio of Female and Male populations with secondary education in each country. (i.e. edu2F / edu2M). 
# The second new variable should be the ratio of labour force participation of females and males in each country (i.e. labF / labM).

gii1 <- gii1 %>% mutate(FemtoMal_edu = seced.fem/seced.mal)
gii1 <- gii1 %>% mutate(FemtoMal_work = lfpr.fem/lfpr.mal)


# 6. Join together the two datasets using the variable Country as the identifier. 
# Keep only the countries in both data sets (Hint: inner join). 
# The joined data should have 195 observations and 19 variables. 
# Call the new joined data "human" and save it in your data folder.

human <- inner_join(hd,gii1,by="Country")
dim(human) 
write.csv(human, file="data/human.csv", row.names = FALSE)
summary(read.csv("data/human.csv", sep = ","))