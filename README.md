CourseraGaCD
============

Getting and Cleaning Data Coursera Repo

This code assumes the files from UCI's study are available in the working directory.

The first eight lines of code read the data into R for clean up and analysis.

Next, the "colnames" commands name the columns for the data frames we will be working with. I found this easier to do on the front end.

Line 19 creates an integer vector referencing items in the "features$V2" vector that contain the text "-mean()" or "-std()" so we can filter for just mean and standard deviation measurements.

Lines 22 and 23 filter using the vector from 19.

Lines 26 and 27 bind the Subject and Y (activity) data frames by "test" and "train".

Line 30 combines those data frames into one.

Lines 33 and 34 replace the activity numbers (found in the Y files) with their respective activities from the Activity Labels file.

For part two, the code begins on line 37. It creates an empty data frame with row labels for the means by activity.

Lines 40-42 run through the columns of AllData, calculating means by activity for each. These are then stored in the data frame created above.

Similar process for subjects in 45-49.

Line 52 combines the two data frames.

Line 54 adds column names.