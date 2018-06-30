##mySQL
ucscdb <- dbConnect(MySQL(), user = "genome", 
                    host = "genome-mysql.soe.ucsc.edu")
result <- dbGetQuery(ucscdb, "show databases;"); dbDisconnect(ucscdb)
result
hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19" ,
                  host = "genome-mysql.soe.ucsc.edu")
alltables <- dbListTables(hg19)
alltables[1:5]
dbListFields(hg19, "HInv")
dbGetQuery(hg19, "select count(*) from HInv")
HInv <- dbReadTable(hg19, "HInv")
head(HInv, 50)

informationsql <- dbConnect(MySQL(), user = "genome", host = "genome-mysql.soe.ucsc.edu", db = 'information_schema')
dbDisconnect(informationsql)
infotables <- dbListTables(informationsql)
head(infotables)
dbListFields(informationsql, 'character_sets')
information <- dbReadTable(informationsql, 'character_sets')
head(information)
table(information$MAXLEN)

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
df <- data.frame(1:5, seq(0, 1, length.out = 5), c('a', 'b', 'c', 'd', 'e'), stringsAsFactors = F)
df
h5write(df, 'example.h5', 'df')
readA <- h5read('example.h5', 'foo/A')
readdf <- h5read('example.h5', 'df')
readA
readdf
h5write(c(11, 12, 13, 14), 'example.h5', 'foo/A', index = list(4:5, 1:2 ))
h5read('example.h5', 'foo/A')
