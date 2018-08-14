##Subsetting and Sorting

set.seed(13425)

x <- data.frame("var1" = sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
x <- x[sample(1:5), ]; x$var2[c(1, 3)] <- NA
x
x[ , 1]
x[, "var1"]
x[c(1, 2), "var2"]
x[x$var1 >=3, ]
x[(x$var1>=3 & x$var3 <=12), ]
x[(x$var1>=3 | x$var3 <=12), ]
x[x$var2 <=8, ] #goes crazy when NAs present
x[which(x$var2 <= 8), ]
which(x$var2 <= 8) ## gives indices instead of actual values
?sort
sort(x$var1) #gives the actual values 
sort(x$var1, decreasing = T)
sort(x$var2)  ##does not give the NA values
sort(x$var2, na.last = T)
sort(x$var2, na.last = F)
?order
order(x$var2) 
order(x$var3) ##GIVES THE INDICES instead of actual values, after arranging
x[order(x$var1), ]   #sort whole rows according to the col of var1
x[sort(x$var1), ]   #just gets col of var1 in order, others remain same. 
                    #actual rows disturbed. Can not be used to order table

identical(x[order(x$var1), ], 
          x[sort(x$var1), ]
)                   #False
x[order(x$var2, x$var3), ]  #first var2, if 2 same values then according to var3

install.packages("plyr")
library(plyr)
?arrange
arrange(x, var1)
arrange(x, desc(var1))

identical(x[order(x$var1), ], arrange(x, var1)) #False ,
                #both gives similar results except that the order subsetting preserves
                #the row number indices, but 'arrange' func of 'plyr' package resets it
x$var4 <- round(rnorm(5, 10, 5), 0)
x
y <- cbind(x, rbinom(5, 10, 0.2))
y

##Summarizing Data

urll <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"

?download.file
download.file(url = urll, destfile = "restdata.csv", method = "curl")
read.csv("restdata.csv")
?read.csv
restdata <- read.csv(file = urll, stringsAsFactors = F)
head(restdata)
tail(restdata)
colnames(restdata)
nrow(restdata)
summary(restdata)
str(restdata)
quantile(restdata$councilDistrict, na.rm = T)
?quantile
quantile(restdata$councilDistrict, probs = c(.5, .6))
?table
table(restdata$zipCode)
table(restdata$zipCode, useNA = "ifany") #will make a heading of NA if there is any
table(restdata$zipCode, useNA = "always")#will make a heading of NA regardless of presence
table(restdata$zipCode, restdata$councilDistrict) #will make contingency table
is.na(restdata) #will make the whole table of logical operation
colSums(is.na(restdata))
any(is.na(restdata))
all(restdata$zipCode>1)
table(restdata$zipCode==21212)  #fine for 1
table(restdata$zipCode==c(21212,21213)) #gives error for more than one
table(restdata$zipCode %in% 21212)
table(restdata$zipCode %in% c(21212, 21213, 21214)) #this gives correct answer
nrow(restdata[restdata$zipCode %in% c(21212, 21213), ])

restdata[restdata$zipCode %in% c(21212, 21213), ] # can be used for subsetting 
                                                  # instead of using |
restdata[(restdata$zipCode == 21212 | restdata$zipCode ==21213), ]
nrow(restdata[(restdata$zipCode == 21212 | restdata$zipCode ==21213), ])
data("UCBAdmissions")
df <- as.data.frame(UCBAdmissions)
head(df)
df
UCBAdmissions
summary(df)
dim(UCBAdmissions)
?xtabs
colnames(df)
xtabs(Freq ~ Gender + Admit, data = df)
xtabs(Freq ~ Dept + Admit, data = df)

sum(df[df$Dept == "B"  & df$Admit == "Rejected", "Freq"])

xtabs(Admit ~ Gender + Dept, data = df) 
##Error in Summary.factor(1:2, na.rm = TRUE) : 
##'sum' not meaningful for factors
str(warpbreaks)
head(warpbreaks)
nrow(warpbreaks)
xtabs(breaks ~ tension + wool, data = warpbreaks)
xt <- xtabs(breaks ~ ., data = warpbreaks) ## using "." instead of variable names will make
# cross tabs of all the variables. 2 X 2 is easy to understand, as more are added
# multidimensional arrays are made which are difficult to understand

warpbreaks$replicate <- rep(1:9, length =  nrow(warpbreaks))
head(warpbreaks)
xt <- xtabs(breaks ~ ., data = warpbreaks)
?ftable
ftable(xt) #converts multidimentional table into 2 x 2 table

object.size(UCBAdmissions)


## CREATING NEW VARIABLES

?seq
seq(1, 10, by = 3)
seq(1, 10, by = 2)
seq(1, 10, length.out = 4)
x <- round(rnorm(10, 20, 5), 0)
x
seq_along(x)
seq(along = x)  #both will give the index values of all the variables

colnames(restdata)
head(restdata$neighborhood)

restdata2 <- restdata # just in case

restdata$nearme <- restdata$neighborhood %in% c("Frankford", "Clifton Park")
head (restdata$nearme)
restdata[restdata$nearme == T, "name"]
table(restdata$nearme)

?ifelse
restdata$zipwrong <- ifelse(restdata$zipCode < 0, TRUE, FALSE)
table(restdata$zipwrong)

?cut
restdata$zipgroups <- cut(restdata$zipCode, breaks = quantile(restdata$zipCode), 
                          labels = c("first", "second", "third", "fourth"))
table(restdata$zipgroups)


install.packages("Hmisc")
library(Hmisc)
?cut2
restdata$zipgroups2 <- cut2(restdata$zipCode, g = 4)
table(restdata$zipgroups2)

restdata$zcf <- factor(restdata$zipCode)
head(restdata$zcf)
table(restdata$zcf)

?relevel

library(plyr)
?mutate
restdata3 <- mutate(restdata, zipgroups3 <- cut2(restdata, g=4))


##RESHAPING DATA

install.packages("reshape2")
library(reshape2)
library(stringi)
library(stringr)
install.packages("stringr")


colnames(mtcars)
rownames(mtcars)
head(mtcars, 3)
mtcars$carname <- rownames(mtcars)
head(mtcars, 3)
?melt
carmelt <- melt(mtcars, id = c('carname', 'gear', 'cyl'), measure.vars = c('mpg', 'hp'))
head(carmelt)
tail(carmelt)
?dcast
cyldata <- dcast(carmelt, cyl ~ variable)
cyldata
geardata <- dcast(carmelt, gear ~ variable)
geardata

cyldatahp <- dcast(carmelt, cyl ~ variable.names('hp'))
cyldatahp

cyldata2 <- dcast(carmelt, cyl ~ variable.names('hp', 'mpg'))
cyldata2

cylmean <- dcast(carmelt, cyl ~ variable, mean)
round(cylmean, 0) 

gearsd <- round(dcast(carmelt, gear ~ variable, sd),1)
gearsd

gearmean <- round(dcast(carmelt, gear ~ variable, mean), 1)
gearmean
class(gearmean)


head(InsectSprays)
table(InsectSprays$spray)

?tapply
tapply(InsectSprays$count, InsectSprays$spray, sum)
tapply(InsectSprays$count, InsectSprays$spray, sum, simplify = F) #provides a list

?split
spins <- split(InsectSprays$count, InsectSprays$spray)
spins
spinsd <- split(InsectSprays$count, InsectSprays$spray, drop = T)
spinsd

lapply(spins, sum)
unlist(lapply(spins, sum))
sapply(spins, sum)

library(plyr)
?ddply
ddply(InsectSprays, .(spray))
ddply(mtcars, .(gear))


ddply(InsectSprays, .(spray), summarise, sum = sum(count)) 
#func(dataset, summarize, spray, by summing the count variable)

ddply(InsectSprays, .(spray), summarize, mean = round(mean(count), 1))
ddply(InsectSprays, 'spray', summarize, sum =sum(count))
  
?ave
ave(mtcars$mpg, mtcars$gear, mean) #will calculate the mean mpg of the cars of that particular
  # gear, and gives this value for each observation/row. 
#tapply will give mean for each factor
#ave will give the same value, but will print for each observation according to factor
round(ave(mtcars$mpg, mtcars$gear), 0)
cbind(mtcars$gear, round(ave(mtcars$mpg, mtcars$gear), 0))
cbind(gear = mtcars$gear, mpg = round(ave(mtcars$mpg, mtcars$gear), 0))
tapply(mtcars$mpg, mtcars$gear, mean)
round(tapply(mtcars$mpg, mtcars$gear, mean), 0)

ave(InsectSprays$count, InsectSprays$spray, FUN = sum) #sum by each factor (spray)
ave(InsectSprays$count, FUN = sum) #sums all

spraysums <-  ddply(InsectSprays, .(spray), summarise, sum = ave(count, FUN = sum))
#for ave func, factor argument was not needed as ddply was already summarizing spray (factor variable)
head(spraysums)
tail(spraysums)


colnames(mtcars)
head(mtcars, 2)
mtcars$carname <- rownames(mtcars)
meltcars <- melt(mtcars, id = c('carname', 'cyl', 'gear'), measure.vars = c('mpg', 'qsec', 'hp'))
dcast(meltcars, cyl ~ variable, mean)
round(dcast(meltcars, cyl ~ variable, mean), 1)

##MANAGING DATA WITH dplyr- INTRODUCTION

install.packages('dplyr')
library(dplyr)
chicago <- readRDS("chicago.rds")
colnames(chicago)
str(chicago)
table(chicago$city)

?select
head(select(chicago, tmpd))
head(select(chicago, c(city, tmpd)))
head(select(chicago, city, dptp, tmpd, date))
head(select(chicago, city:date))
head(select(chicago, -(city:date)))


?filter
head(chicago)
head(filter(chicago, tmpd >= 40))
head(filter(chicago, tmpd >40 & dptp > 40))

?arrange
head(arrange(chicago, tmpd))
head(arrange(chicago, -tmpd))# == head(arrange(chicago, desc(tmpd)))

?rename
chicago <- rename(chicago, temp = tmpd, dew = dptp, pm25 = pm25tmean2, pm10 = pm10tmean2)
names(chicago)
chicago <- rename(chicago, o3 = o3tmean2, no2 = no2tmean2)
names(chicago)

?mutate
chicago <- mutate(chicago, pm25md = pm25 - mean(pm25, na.rm = T))
tail(chicago)

chicago <- mutate(chicago, tempcat = factor(1*(temp >= 80), labels = c('cold', 'hot')))
head(filter(chicago, temp > 78))

summarize(chicago, maxtemp = max(temp, na.rm = T), mean25 = mean(pm25, na.rm = T))

hotcold <- group_by(chicago, tempcat)
head(hotcold) 

summarize(hotcold, maxtemp = max(temp, na.rm = T), mean25 = mean(pm25, na.rm = T))
 

l <- as.POSIXlt(Sys.time())  #stored time as detailed list of information 
c <- as.POSIXct(Sys.time())  #stored time as a single very long number (seconds from 1-1-1970)
unclass(c)
unclass(l)

names(chicago)
chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
year <- group_by(chicago, year)
summarize(year, meantemp = mean(temp, na.rm = T), mean25 = mean(pm25, na.rm = T))

#pipeline operator %>%

chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>%
  group_by(month) %>% summarize(meantemp = mean(temp, na.rm = T), mean25 = mean(pm25, na.rm = T))


## MERGING DATA

names(mtcars)
mtcars <- mutate(mtcars, carname = row.names(mtcars))
mtcars2 <- mtcars %>% select(carname, mpg, disp, drat, cyl) %>% arrange(mpg)
mtcars3 <- mtcars %>% select(carname, cyl, hp, wt, mpg) %>% arrange(cyl)

head(mtcars2)
head(mtcars3)

head(merge(mtcars2, mtcars3))  #merge by all the common names
head(merge(mtcars2, mtcars3, by = "carname")) #keep common names other than mentioned separate
head(merge(mtcars2, mtcars3, by = c("carname", "cyl")))

#now lets distort the data then merge

mtcars2n <- mtcars2
mtcars2n$mpg <- 1:32
mtcars3n <- mtcars3
mtcars3n$cyl <- 101:132

head(mtcars2)
head(mtcars2n)


head(mtcars3)
head(mtcars3n)

head(merge(mtcars2n, mtcars3n, all = T))
head(merge(mtcars2n, mtcars3n, by = 'carname'))
head(merge(mtcars2n, mtcars3n, by = c('carname', 'cyl'), all = T))
head(merge(mtcars2n, mtcars3n, by= 'mpg', all = T))

?join
join(mtcars2, mtcars3)
join(mtcars2, mtcars3, by = 'carname') #similar to merge but not specifying x and y
join(mtcars2n, mtcars3n) #variables of 2 are complete, unmatched in 3 are empty
join(mtcars3n, mtcars2n) # vice versa
#merge has better control



df1 <- data.frame(id = sample(1:10), x = rnorm(10))
df2 <- data.frame(id = sample(1:10), y = rnorm(10))
df3 <- data.frame(id = sample(1:10), z = rnorm(10))

arrange(join(df1, df2), id)

dflist <- list(df1, df2, df3)
?join_all
join_all(dflist)                #and that is the reason to use join
arrange(join_all(dflist), id)
