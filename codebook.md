main.R finds averages on all concerned variables on two datasets and writes them into a text file

refer to comments for proper STEP# reference

STEP 1: all data is merged
STEP 2: significant data is extracted (mean and standard deviation)
STEP 3+4: names are properly assigned
STEP 5: new dataset of all activity and subject averages into a text file

Variables:
[1] "activities"     "features"       "fileUrl"        "full_data"      "means_data"     "somethingNew"   "stats_features"
 [8] "subj_test"      "subj_train"     "subject_data"   "x_data"         "x_test"         "x_train"        "y_data"        
[15] "y_test"         "y_train" 

"data" datasets are merged from "train" and "test" datasets
"features" applies the name changes to "x_data" while "stats_features" extracts statistic data from STEP 2.
