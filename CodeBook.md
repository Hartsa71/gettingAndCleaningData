---
title: "CodeBook"
output: html_document
---


This document defines the variables in tidyData.csv file which is produced as a result of the Getting and Cleaning Data course project.

This course project handles the smaller part of the bigger project where the experiment was carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope the data was gathered. 

Columns of the data as as following: "","id","action","xMean","bodyAccXMean","bodyAccYMean","bodyAccZMean","bodyGyroXMean","bodyGyroYMean","bodyGyroZMean","totalBodyAccXMean","totalBodyAccXYean","totalBodyAccZMean"

* Where the first column ("") is the running id number of data rows
* The second ("id") is the identification number of the test subject
* The action is the activity of the test subject executed during measurement data collection
* The rest of the columns are means of the measurement values

Data was merged to gether by the rowvise from 12 different files and from two different data sets. Original data format for accelerometer and gyroscopic data was in space separated format. some of the directions were handled as positive numbers when data had two space bar character between the actual numbers, Those double speces were truncated to one before handling the data. Also that format produced an empty column as the first data for every row. That was also deleted.

