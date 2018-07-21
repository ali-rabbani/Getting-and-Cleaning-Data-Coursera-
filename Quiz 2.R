##Question 1

install.packages("httpuv")
library(httpuv)
library(httr)
oauth_endpoints("github")
myapp <- oauth_app("github", 
                  key = "d99d10f365423b2036ba",
                  secret = "9b2c3f0531478c2cc81200067efb2a06a4d6b072")


github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)

url <- "https://api.github.com/users/jtleek/repos"

github <- GET(url, gtoken)
github
json1 <- content(github)

json2 <- jsonlite::fromJSON(toJSON(json1))

class(json2)

colnames(json2)

json2[json2$name == "datasharing", "created_at"]

#FINALLY


## Question 2

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url = url, destfile = "acsd.csv")
acs <- read.csv("acsd.csv")

match("AGEP", colnames(acs))

colnames(acs)
summary(acs$AGEP)

acs50 <- acs[acs$AGEP <50 , ]
subset1 <- acs[acs$AGEP <50, "pwgtp1"]

summary(subset)

install.packages("sqldf")
library(sqldf)

subset2 <- sqldf("select pwgtp1 from acs where AGEP< 50")

identical(subset1, subset2[,1])
#hehehohohaha

##Question 3

unq1 <- unique(acs$AGEP)
unq2 <- sqldf("select distinct AGEP from acs")

identical(unq1, unq2[,1])
#yeehaa

##Question 4

con <- url('http://biostat.jhsph.edu/~jleek/contact.html')
htmlcode <- readLines(con)
close(con)

for(i in c(10, 20, 30, 100)){
  temp <- integer()
  temp <- c(temp, nchar(htmlcode[i]))
  print(temp)
}
#tantanaaan

##Question 5

?read.fwf
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

download.file(url = url, destfile = "test.for")

test <- read.fwf(file = "test.txt", widths = c(15, 4, 9, 4, 9, 4, 9, 4, 4 ), skip = 4)
head(test)
#better yet
test1 <- read.fwf(file = url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"),
                  widths = c(15, 4, 9, 4, 9, 4, 9, 4, 4 ), skip = 4)
#calculated width by manually counting in the text file

sum(test[,4])

#hiphiphurraaayyyy
