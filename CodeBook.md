CREATED BY: Khoi Phan - pkhoi176@gmail.com

DESCRIPTION: After run the script, we have two variable ("wearableData" and "wearableTidy") in the workspace and two txt files ("wearableData.txt" and "wearableTidy.txt"):

- "wearableData" and "wearableData.txt":
	+ Number of variables: 68
	+ Number of records: 10299
- "wearableTidy" and "wearableTidy.txt"
	+ Number of variables: 68
	+ Number of records: 180
- Detail about variables: the first two variables are the subject and activity, the last 66 variables is the he measurements on the mean and standard deviation for each measurement read file "feature_info.txt" for more information about the measurement.

- How the script works:
	+ Read "features.txt" for column names and position.
	+ Using "gsub" to find the column names that has "mean()" or "std()" as the requirement stated that "2. Extracts only the measurements on the mean and standard deviation for each measurement."
	+ The point is use "colClasses" in function read.table to skip unecessary columns so we need a variable colIdx that has the length of feature and value of "NULL" - means skip - and NA.
	+ Then we just need to load subject data and activity data (to replace the index of activity data by the name, use merge function).
	+ The first dataset was created by add columns that hold subject and activity info to the loaded raw dataset then concertrated train and test dataset together.
	+ The second dataset was created using aggregate function to group the data by subject and activity, then use mean to calculate the average of each variable for each activity and each subject.
