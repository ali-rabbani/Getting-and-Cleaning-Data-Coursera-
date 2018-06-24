## I am at week 1 of the getting and cleaning data
## for week 1 quiz I am working on this dataset

download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", 
              destfile = "housing.csv")
housing <- read.csv("housing.csv")

## the question is to find the number of houses with values $1000000 and above
## according to the code book (https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf)
## variable VAL with value 24 means the price given above
## so I worte the script as follows

nrow(housing[housing$VAL == 24, ])

## the answer was wrong, so I printed
housing[housing$VAL == 24, ]

## and whole of the dataframe was filled with whole lot of NAs


## But the same formula works very well for other data sets

nrow(mtcars[mtcars$cyl == 4, ])
mtcars[mtcars$cyl == 4, ]
## What am I missing here?