CREATED BY: Khoi Phan - pkhoi176@gmail.com

INSTRUCTION: place the script inside the extracted folder and run it by RStudio of R commandline.

NOTES:
	- The workflow of the script has been explained throughfully by the comments in its content. Therefore, in this readme I only summarize the main steps in this script:
		+	Step 1: loading the raw data by spectify what column we need to reduce reading overhead and memory consumption, also load necessary datas. List of file involved:
			- 'features_info.txt': Shows information about the variables used on the feature vector.
			- 'features.txt': List of all features.
			- 'activity_labels.txt': Links the class labels with their activity name.
			- 'train/X_train.txt': Training set.
			- 'train/y_train.txt': Training labels.
			- 'test/X_test.txt': Test set.
			- 'test/y_test.txt': Test labels.
		+	Step 2: add subject and activity column to each dataset and then append the test set to the train set.
		+	Step 3: create tidy dataset using aggregate funtion.
