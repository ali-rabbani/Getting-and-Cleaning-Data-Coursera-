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



## After consultation

nrow(housing[which(housing$VAL == 24), ])
nrow(subset(housing, VAL == 24))
table(housing$VAL ==24)
nrow(housing[(housing$VAL ==24 & !is.na(housing$VAL)), ])

## Question 3

download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", 
              destfile = "ngap.xlsx", mode = 'wb')
library(xlsx)
dat <- read.xlsx("ngap.xlsx", sheetIndex = 1, rowIndex =  18:23, colIndex =  7:15)
sum(dat$Zip*dat$Ext,na.rm=T)


## Question 4

download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",
              destfile = "brest.xml")
library(XML)
doc <- xmlTreeParse("brest.xml", useInternalNodes = T)
names(doc)
xmlValue(doc)
doc[[1]]
rootdoc <- xmlRoot(doc)
names(rootdoc)
rootdoc[[1]][[1]]
xmlSApply(rootdoc, xmlValue)
sum(xpathSApply(rootdoc, "//zipcode", xmlValue) == "21231")


## Question #5
library(data.table)
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", 
              destfile = "house.csv")


DT <- fread("house.csv")

time1 <- system.time(DT[,mean(pwgtp15),by=SEX])
time2 <- system.time(tapply(DT$pwgtp15,DT$SEX,mean))
time3 <- system.time(mean(DT$pwgtp15,by=DT$SEX))
time4 <- system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
time5 <- system.time(mean(DT[DT$SEX==1,]$pwgtp15))  
time6 <- system.time(mean(DT[DT$SEX==2,]$pwgtp15))

names(time1)
time1['user.self']

usertime <- data.frame(script = c('time1','time2','time3','time4','time5','time6'), 
            usertime =    c(time1['user.self'],
            time2['user.self'],
            time3['user.self'],
            time4['user.self'],
            time5['user.self'],
            time6['user.self']
))

usertime[which.min(usertime$usertime), ]
