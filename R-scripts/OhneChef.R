library("rjson")
library("RCurl")

# Einladen der URL und exportieren aus JSON-Format
raw_chef <- getURL("http://ohne-chef.org/regional/ajax/getAll")
#str(raw_data)
fromJSON(raw_chef)
chefdata <- fromJSON(raw_chef)


title_chef <- sapply(chefdata$places, function(x) x$title)
url_chef <- sapply(chefdata$places, function(x) x$url)
description_chef <- sapply(chefdata$places, function(x){content <- x$shortDescription; if(is.null(content)){return(NA)}else{return(paste(content,collapse=";"))}})
coordinates_chef <- round(sapply(chefdata$places, function(x){content <- x$coordinate; if(is.null(content)){return(c(NA,NA))}else{return(content)}}), 5)
#descr_chef <- data.frame(matrix(NA, nrow = 96, ncol = 1))

chef_info <- cbind(title_chef, url_chef, lat=coordinates_chef[1,], lon=coordinates_chef[2,])#, descr_chef) 
