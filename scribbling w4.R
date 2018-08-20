##EDITING TEXT VARIABLES

camera <- read.csv("https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD")
names(camera)
tolower(names(camera)) #of course did not change the actual value
names(camera)

?strsplit
splitnames <- strsplit(names(camera), "\\.")
splitnames
splitnames[[6]]
splitnames[[6]][2]

splitnames <- strsplit(names(camera), "\\.")
#makes all the characters empty

mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix = matrix(1:25, ncol = 5))

mylist[1]
mylist[[1]]
mylist$letters

splitnames[[6]][1]

firstelement <- function(x){x[1]}
sapply(splitnames, firstelement) #just grinding my fingers revising previous knowledge

names(camera)

?sub


sub("_", "------", names(camera))
sub("_", "", names(camera))
sub("street", "Superman", names(camera))

testname <- "this_is_a_test"
sub("_", "", testname)

gsub("_", "", testname  )



grep("Alameda", camera$intersection) #gives the idex of the observations containing this string
table(grepl("Alameda", camera$intersection)) #logical vector for this match 

grep("Alameda", camera$intersection, value = T) #gives the actual value instead of index


library(stringr)
nchar("Jeffery Leek " )
substr("Jeffery Leek ", 1, 4) #from character 1 to 4
paste("Ali", "Rabbani")
paste0("Ali", "Rabbani") #paste without space
str_trim("Ali      ")  #trims out all the space



##REGULAR EXPRESSIONS
install.packages("pdftools")

#let's make a whole lot of text for testing
library(pdftools)
mocking <- pdf_text("To-Kill-a-Mockingbird.pdf")
mocking <- strsplit(mocking, "\r\n", fixed = T)
mocking <- lapply(mocking, paste) #now each page is a element of a list, and everything divided by 
                                  #"." is a sub element of that list
mocking2 <- unlist(mocking)       #each line is an element

mocking2[5] 
head(mocking)
lapply(mocking, grep, "church")

#functions explained previously, now see how to write the argument expression 
grep("Cunningham", mocking2, value = T) #germany is a literal
grep("[Pp]resident", mocking2, value = T)
grep("^hello", mocking2, value = T) #  '^' followed by character string indicates the sentences starting with
grep("^and you", mocking2, value = T)
grep("morning.$", mocking2, value = T) # '$' used for sentence ending with. 
grep("[Kk][Ii][Ll][Ll]", mocking2, value = T) #either large or small letter
grep("kill", mocking2, value = T)
grep("^and [Ii]", mocking2, value = T) #extension of the above
grep("[0-9][A-Za-z]", mocking2, value = T)
grep("[?]$", mocking2, value = T)
grep("[,]$", mocking2, value = T)
grep("[^?., ]$", mocking2, value = T) #not ending with these
grep("1.5", mocking2, value = T) # "." does not suggest literal full stop, rather 1 and five separated by 'any possible character'
grep("1\\.5", mocking2, value = T) #Error: '\.' is an unrecognized escape in character string starting ""1[\."
  #\\ is working
grep("water|fire", mocking2, value = T) # or
grep("water|fire|air|earth", mocking2, value = T) # or or or or
grep("[Aa]merica|[Gg]erman", mocking2, value = T) # anything other than literals also
grep("^[Gg]ood|[Bb]ad", mocking2, value = T) #good at the beginning, bad anywhere
grep("^([Gg]ood|[Bb]ad)", mocking2, value = T) #either of them but at beginning
grep("said", mocking2, value = T)
grep("([Jj]\\.)? [Gg]rimes [Ee]verett", mocking2, value = T) #supposed to work like, either if J. present or not
  #but not working currently, and \ also giving an error
grep("Miss Jean Louise", mocking2, value = T)
grep("(Miss)? Jean Louise", mocking2, value = T) #now this is working
grep("Miss( Jean)?( Louise)?", mocking2, value = T)
grep("(.*)", mocking2, value = T) #any character, repeated any number of times, thus the whole novel, as opposed to 
  #lecture video which said that eveything inside the paranthesis
grep("[0-9]+ (.*)[0-9]+", mocking2, value = T) #atleast one of 0-9, followed by a space then any number of any character,
  #then any one of the numbers 0-9
grep("I( +[^ ]+){1,10} nothing", mocking2, value = T) #search class followed by space (atleast one), followed be 
  #at least one something other than space, repeated between 1-5 times, follpwed by space and nothing
grep("I( +[^ ]+){,5} nothing", mocking2, value = T) #now fine
  #m,n between m and n matches, m = exactly m matches, m, atleast m matches, ,m = atmost m
grep(" +([A-Za-z]+) +\\1 +", mocking2, value = T) 
grep(" +([A-Za-z]+) +\1 +", mocking3, value = T) #definitely not work, \ have not been working anyway
grep(" +([A-Za-z]+) +\\1 +", mocking3, value = T) #\\ is working
  #but still cannot  understand properly
grep("^s(.*)s$", mocking2, value = T) #starts with an s and ends with one too
grep("^s(.*?)s$", mocking2, value = T)  #did not understand the difference


##WORKING WITH DATES

d1 = date()
d1
class(d1)
d2 = Sys.time()
d2
class(d2)

#format() is the opposite of strptime()
#former subsets formated time as per your need, latter reads arbitrarily written time into POSIXTlt format

format(d2, "%a, %d %B %Y") #to write stored date in the way / format you want

x <- c("1jan1960", "2jan1960", "31march1960", "30july1960") ; z <- as.Date(x, "%d%b%Y")
z
as.POSIXlt(z)
#opposite of the above, reading random format into time in r
weekdays(d2)
weekdays(z)
months(d2)
months(z)
julian(z)


install.packages('lubridate')
library(lubridate)

ymd("19910821")
dmy('21081991') #much easier to read and to input data
  
dmy_hms('14081947 161553', tz = "Asia/Karachi") #much much easier

wday(dmy(x)) #dmlubridate is awesome
wday(dmy(x), label = T)


library(swirl)
swirl()


##QUIZ

#1

housing <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
names <- names(housing)
splitnames <- strsplit(names, "wgtp")
splitnames[123]

#2
gdp <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
                skip = 5, nrows = 190, header = F, stringsAsFactors = F) %>%
  select(V1,V2, V4:V5) %>%
  rename(countrycode = V1, ranking = V2, country = V4, milusd = V5)
gdp$milusd <- gsub(",", "", gdp$milusd) %>% as.numeric(gdp$milusd)
head(gdp$milusd) ; class(gdp$milusd)
mean(gdp$milusd)

#3
grep("^United", gdp$country)

#4 
edu <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
head(edu)[, 1:3]
grep("[Yy]ear", colnames(edu), value = T)
names(gdp)
names(edu)

gdpedu <- merge(x = gdp, y = edu, by.x = "countrycode", by.y = "CountryCode")
head(gdpedu)
head(gdpedu$Special.Notes)
gdpedu[, "Special.Notes"]

fiscal <- grep("Fiscal year end" , gdpedu$Special.Notes, value = T)
length(grep("June", fiscal))
#or simply
length(grep("Fiscal year end(.*)June" , gdpedu$Special.Notes, value = T))

#5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

in2012 <-  grep("2012", sampleTimes, value = T)
library(lubridate)
in2012 <- ymd(in2012)
logic <- wday(in2012, label = T) == "Mon"
length(in2012[logic])


rm(list = ls())
