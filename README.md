run_analysis

Script loads al the data with read.table to one vector each file.
Features files contain column names and are asigned to the tables.
Subject vector is named as "subject".
Any column name containing mean() or std() is marked and used to subset the tables
Data files are combined in one.
Mean of the selected data is calculated and writen to file.

