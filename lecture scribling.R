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
