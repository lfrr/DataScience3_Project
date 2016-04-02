
# Coursera Getting and Cleaning Data Course Project 
# lfrr 
# 02-04-2016 

# Original Data Source: 
# Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L.
# Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass
# Hardware-Friendly Support Vector Machine. International Workshop of Ambient
# Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

# The following R script downloads and cleans the data


# Download File -----------------------------------------------------------

setwd("C:/Users/lauta/Google Drive/DATA SCIENCE/R")
library(plyr)
library(dplyr)
data_file <- "data_accelerometer.zip"
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists(data_file)){
  download.file(data_url, data_file)
}
?unzip
if(!file.exists("UCI HAR Dataset")) {
unzip(data_file)
}
setwd("C:/Users/lauta/Google Drive/DATA SCIENCE/R/UCI HAR Dataset")
list.files()
list.files("./test")
list.files("./train")

# Read tables -------------------------------------------------------------

features <- read.table("features.txt", header = FALSE)
head(features)

activity <- read.table("activity_labels.txt")
head(activity)

subjecttrain <- read.table("./train/subject_train.txt")
subjecttest <- read.table("./test/subject_test.txt")
dim(subjecttrain)
dim(subjecttest)
xtrain <- read.table("./train/X_train.txt", header = FALSE)
ytrain <- read.table("./train/y_train.txt", header = FALSE)
dim(xtrain)
dim(ytrain)
xtest <- read.table("./test/X_test.txt")
ytest<- read.table("./test/y_test.txt")
dim(xtest)
dim(ytest)


# Merge measurements vertically -------------------------------------------
# merge train and test tables...
xtotal <- rbind(xtrain,xtest) %>% tbl_df() #requires dplyr!
ytotal <- rbind(ytrain, ytest) %>% tbl_df()
subjecttotal <- rbind(subjecttrain, subjecttest)  %>% tbl_df()
names(subjecttotal) <- "SubjectID"

# select std and mean from features table ---------------------------------
features_desired <- grep("-(mean|std)\\(\\)", features[,2])
length(features_desired)

# subset mean and std on x data-----------------------------------------------------

xselected <- select(xtotal, features_desired)
names(xselected) <- features[features_desired, 2]
View(xselected)


# y activity name ---------------------------------------------------------

ytotal <- inner_join(ytotal, activity, by = "V1")
ytotal <- select(ytotal, V2)
names(ytotal) <- "Activity"


# Merge data horizontally -------------------------------------------------

data <- cbind(subjecttotal, ytotal, xselected)


# make colnames more readable ---------------------------------------------

names(data) <- gsub("\\(\\)", "", colnames(data))
names(data) <- gsub("\\-", "", colnames(data))
names(data) <- gsub("^t", "time", colnames(data))
names(data) <- gsub("^f", "frequency", colnames(data))
data %>% tbl_df()
View(data)


# New data set with averages from every subjecto for every column ---------

?ddply
tidydata <- ddply(data, c("SubjectID", "Activity"), function(x){colMeans(x[, 3:68])})
tidydata %>% tbl_df() %>% View()
setwd("../")
?write.table
write.table(tidydata, file = "tidydata.txt", row.names = FALSE)

