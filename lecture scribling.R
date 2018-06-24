checkmakedir <- function(dirname){
    if(file.exists(dirname)){
        message("Directory already exists")
    }
    else {dir.create(dirname)}
}

wd <- getwd()

fileurl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

download.file(url = fileurl, destfile =  "D:/Documents/Coursera/Data Science/3. Getting and Cleaning Data/camea.csv", 
              method = "curl")

##because downloadable files can change
datedownloaded <- date()

cameradata <- read.table("camea.csv", sep = ",",  header = T)

cameradata <- read.table(file= "camea.csv", sep = ",", header = T, skip = 5, nrows = 10)

fileurl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD&bom=true&format=true"

download.file(url = fileurl, destfile = "camera.xlsx", method = "curl")

doc <- xmlTreeParse("food.xml")

rootnode <- xmlRoot(doc)

xmlName(rootnode)

names(rootnode)

rootnode[[1]]
rootnode[[3]]
rootnode[[1]][[3]]
rootnode[[3]][[1]]
?xmlValue

xmlSApply(rootnode, xmlValue)

xpathSApply(rootnode, "//price", xmlValue) ##error, not excecuting

fileurl <- "http://www.espn.go.com/nfl/team/_/name/bal/baltimore-ravens"

doc <- htmlTreeParse(fileurl, useInternal = T)

scores <- xpathSApply(doc,"//li[@class= 'score']", xmlValue) ##error, results different than lectures
teams <- xpathSApply(doc,"//li[@class= 'team-name']", xmlValue) ##same
teams
scores
xpathSApply(doc,"//li[@class= 'nextGame']", xmlValue) ##same


fileurl <- "http://www.espn.com/nfl/team/roster/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileurl, useInternal = T)
xpathSApply(doc, "//li[@class= 'sub']", xmlValue)

install.packages('data.table')
library(data.table)

dt <- data.table("x" = rnorm(9), "y" = rep(c("a", "b", "c"), each = 3), "z" = rbinom(9, 5, 0.5))
dt

dt[c(2, 3)] ## gives expected result of 2nd and 3rd column as opposed to the lecture

k = {print(10); 5}
k

listdt <- dt[ , list(mean(x), sum(z))]

cdt <- dt[ , c(mean(x), sum(z))]

class(listdt)
class(cdt)

df <- data.frame("x" = rnorm(9), "y" = rep(c("a", "b", "c"), each = 3), "z" = rbinom(9, 5, 0.5))

class(df)

df[ , list(mean(x), sum(z))]        #gets error
df[ , list(mean("x"), sum("z"))]    #gets error

dt[ , table(z)]

dt[ , a:= z/x]
dt #changed the value of dt without assigning the value
df[ , a:= z/x] # gets error
