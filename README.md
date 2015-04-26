#Coursera's Get and Clean Data - Course Project

## Human Activity Recognition Using Smartphones Data Set

###Raw Data Set Information:

The raw data collected for this project is from experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.




###Step 1: Merge the training and test data sets to create one data set

The raw data set is provided in two --  training and test -- sets.  In step 1, the two data sets have been merged.  The two sets are combined using rbind().

###Step 2: Provide descriptive activity names 

(Note: In the project description, this is step 3.)
The data set includes activity ids (1..6).  A separate reference data file provides the activity labels corresponding to these activity ids.  The activity label information is added as a column to the data set while retaining the activity id column.  This is done using the merge() command.

###Step 3: Extract mean and standard deviations of measurements

Exclude columns that do not deal with mean and std deviations of measurements.  An analysis of the variable names reveals that all the measurement means contain the word "mean" in them and the standard deviations contain "std()".  The appropriate columns are identified using dplyr and regular expressions.

###Step 4: Provide descriptive labels for the variables

An automated "translation" of cryptic variable names into descriptive names is performed with the help of gsub() method.

###Step 5: Create a second and tidy data set that takes the averages of the measurements

dplyr library's group_by() and summarise_each() methods are used to generate the necessary averages of all the columns for each combination of activity and subject.  
