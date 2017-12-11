#______________________Set URL____________________________________________________________________________________________
# use URLencode for encoding spaces in an URL
# you get entries only from the first page (page = '1'), to consider the other pages you have to change the parameter page

page <- '1'

allbacdiveIDs <- 'https://bacdive.dsmz.de/api/bacdive/bacdive_id/?page='
url_allbacdiveIDs<- URLencode(paste0(allbacdiveIDs,page,'&format=json'))

taxon <- 'https://bacdive.dsmz.de/api/bacdive/taxon/'
searchterm_genus <- 'Bacillus'
url_genus <- URLencode(paste0(taxon,searchterm_genus,'/?page=',page,'&format=json'))

searchterm_genus <- 'Bacillus'
searchterm_species <- 'subtilis'
url_species <- URLencode(paste0(taxon,searchterm_genus,'/',searchterm_species,'/?page=',page,'&format=json'))

searchterm_genus <- 'Bacillus'
searchterm_species <- 'subtilis'
searchterm_subspecies <- 'subtilis'
url_subspecies <- URLencode(paste0(taxon,searchterm_genus,'/',searchterm_species,'/',searchterm_subspecies,'/?page=',page,'&format=json'))


bacdiveID <- 'https://bacdive.dsmz.de/api/bacdive/bacdive_id/'
searchterm <- '1'
url_bacdiveID <- URLencode(paste0(bacdiveID,searchterm,'/?format=json'))

cultureno <- 'https://bacdive.dsmz.de/api/bacdive/culturecollectionno/'
searchterm_cultureno <- 'DSM 319'
url_cultureno <- URLencode(paste0(cultureno,searchterm_cultureno,'/?format=json'))

secAccNo <- 'https://bacdive.dsmz.de/api/bacdive/sequence/'
searchterm_secAccNo <- 'AF000162'
url_secAccNo <- URLencode(paste0(secAccNo,searchterm_secAccNo,'/?format=json'))


#______________________Retrieve data__________________________________________________________________________________________
# Instead of url_cultureno you can use another url from above.
#
response <- RCurl::getURL(url_secAccNo,userpwd="{your email}:{your password}", httpauth = 1L)
print(response)


#______________________Transform JSON to list_________________________________________________________________________________
jsondata <- rjson::fromJSON(response)
print(jsondata)
