# Information

run_analysis.R script cleans data measured with Samsung's accelerometers.

The original raw data and full description can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Steps: 
* The script checks if the data file has been downloaded. If not, it is downloaded and unziped.
* Then, train and test tables are read for subject, x and y data. features.txt and activity_labels.txt are read as well.
* Train and test measurements are merged vertically
* It is only needed mean and standard deviation values. So, their indices are extracted form features.txt. Those indices are used to subset the values from x table.
* y data is transformed to readable values using activity_labels.txt data.
* Afterwards, x, y and subject data are merged horizontally in a single data frame.
* Column names are modified to be more readable.
* Finally a new table is created with the average of each variable for each activity for each subject.

Variables: 
* `activity`, `features`, `subjecttrain`, `subjecttest`, `xtrain`, `ytrain`, `xtest` and `ytest` contain the tables imported from the files downloaded.
* `xtotal`,`ytotal`, `subjecttotal` vertical binds of train and test data.
* `features_desired` is a vector containing the indices of the columns with the means and standard deviations.
* `xselected` is the result of subsetting xtotal.
* `data`is the table containing all the wanted information and with desired column names.
* `tidydata` is a table containing the averages of each variable for each activity for each subject.


