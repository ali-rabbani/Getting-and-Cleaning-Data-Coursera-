# Getting and Cleaning Data - Course Project

This is my submission of peer reviewed course project of getting and cleaning data

This repository contains the following files
* `README.md` this file, which provides an overview of the data set and how it was created.
* `CodeBook.md` the code book, which describes the contents of the data set (data, variables and transformations used to generate the data).
* `run_analysis.R` the R script that was used to create the data set, explained below
* `tidydata.txt` and `tidydata.csv` contains the dataset

##Creating the dataset
The R script saved by the name of, `run_analysis.R`, was used to create data. It does the following:

1. Downloads and extracts the dataset if it does not already exist in the directory
2. Loads the activity and feature names
3. Subsets feature names, keeping only those which reflect a mean or standard deviation
3. Loads both the training and test data, keeping only subset of features
4. Makes a neat dataset by binding subject, avtivity and data for both test and train
5. Merges the two datasets (train and table)
6. Converts the `activity` and `subject` columns into factors
7. Creates a tidy dataset that consisting of the average (mean) value of each
   selected variable for each subject and activity pair.

The end result is saved in the file `tidy.txt` and `tidy.csv`

The `tidy_data.txt` in this repository was created by running the `run_analysis.R` script using R version 3.5.1 (2018-07-02) on Windows 10 64-bit edition.
This script requires the `reshape2` package
