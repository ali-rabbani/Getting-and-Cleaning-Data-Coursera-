##mySQL
library(RMySQL)
ucscdb <- dbConnect(MySQL(), user = "genome", 
                    host = "genome-mysql.soe.ucsc.edu")
result <- dbGetQuery(ucscdb, "show databases;"); dbDisconnect(ucscdb)
head(result)
hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19" ,
                  host = "genome-mysql.soe.ucsc.edu")
alltables <- dbListTables(hg19)
length(alltables)
alltables[1:5]
dbListFields(hg19, "HInv")
dbGetQuery(hg19, "select count(*) from HInv")
HInv <- dbReadTable(hg19, "HInv")
head(HInv, 10)

informationsql <- dbConnect(MySQL(), user = "genome", host = "genome-mysql.soe.ucsc.edu", db = 'information_schema')
dbDisconnect(informationsql)
infotables <- dbListTables(informationsql)
head(infotables)
dbListFields(informationsql, 'character_sets')
dbGetQuery(informationsql, "select count(*) from character_sets")
information <- dbReadTable(informationsql, 'character_sets')
head(information)
table(information$MAXLEN)
query <- dbSendQuery(informationsql, "select * from character_sets where MAXLEN between 2 and 3")
charMAX <- fetch(query)
charMAX
charMAXsmall <- fetch(query, n= 5)
charMAXsmall
dbClearResult(query)
dbDisconnect(informationsql)

#final run summarizing all the commands of this particular lecture
ucscdb <- dbConnect(MySQL(), user = 'genome', 
                    host = 'genome-mysql.soe.ucsc.edu')
ucscdblist <- dbGetQuery(ucscdb, "show databases;")
dbDisconnect(ucscdb)
head(ucscdblist, 20)
informationschdb <- dbConnect(MySQL(), user = "genome", db = 'information_schema',
                              host = "genome-mysql.soe.ucsc.edu")
infodblist <- dbListTables(informationschdb)
head(infodblist)
dbListFields(informationschdb, 'character_sets')
dbGetQuery(informationschdb, 'select count(*) from character_sets')
charactersets <- dbReadTable(informationschdb, 'character_sets')
charactersets
table(charactersets$MAXLEN)
query <- dbSendQuery(informationschdb, 'select * from character_sets where MAXLEN between 2 and 4')
subcharactersets <- fetch(query)
subcharactersets
quantile(subcharactersets$MAXLEN)
smallcharactersets <- fetch(query, n = 5)
smallcharactersets
dbClearResult(query)
dbDisconnect(informationschdb)

##Read from HDF5

source('http://bioconductor.org/biocLite.R')
biocLite('rhdf5')
library(rhdf5)

created = h5createFile("example.h5")
created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")

A <- matrix(1:10, 5, 2)
h5write(A, 'example.h5', 'foo/Awesome')
B <- array(seq(0.1, 2.0, by = .1), dim = c(5, 2, 2))
h5write(B, 'example.h5', 'foo/foobaa/Best')
attr(B, 'scale') <- 'liter'
B
df <- data.frame(x = 1:5, y = seq(0, 1, length.out = 5),z =  c('a', 'b', 'c', 'd', 'e'), stringsAsFactors = F)
df
h5write(df, 'example.h5', 'df')
readA <- h5read('example.h5', 'foo/Awesome')
readdf <- h5read('example.h5', 'df')
readA
readdf
h5write(c(11, 12, 13, 14), 'example.h5', 'foo/Awesome', index = list(1:4, 1 ))
h5read('example.h5', 'foo/A')



## Reading from the web
library(XML)
con = url('https://scholar.google.com.pk/citations?user=ffQSH1MAAAAJ&hl=en')
htmlcode <- readLines(con)
close(con)

#This did not work for me, don't know what happened
url <- 'https://scholar.google.com.pk/citations?user=ffQSH1MAAAAJ&hl=en'
htmlabuji <- htmlTreeParse(url, useInternal = T  )
rootabuji <- xmlRoot(htmlabuji)  ##cant understand for now
xpathSApply(htmlabuji, '//title' ,xmlValue) ## not giving the desired result
xpathSApply(htmlabuji, "//td[@id='col-citedby']", xmlValue) ## again not the result


#Now this is working
htmlabuji <- htmlTreeParse(htmlcode, useInternalNodes = T)

#for subsetting
rootabuji <- xmlRoot(htmlabuji)
rootabuji[[1]]
names(rootabuji[[2]][[1]])

#using xpath
xpathSApply(htmlabuji, "//title", xmlValue)
xpathSApply(rootabuji, "//title", xmlValue)
xpathSApply(htmlabuji, "//a[@class = 'gsc_a_at']", xmlValue)  
#same way as extracting from xml, useful if you know the source code values

#using httr package
install.packages('httr')
library(httr)
