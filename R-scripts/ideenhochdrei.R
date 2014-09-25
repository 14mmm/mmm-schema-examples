library("rjson")
library("RCurl")

# Einladen der URL und exportieren aus JSON-Format
raw_ideen <- getURL("http://www.ideenhochdrei.org/__ajax__/pms/")
fromJSON(raw_ideen)
data_ideen <- fromJSON(raw_ideen)

alltags_ideen <- sort(unique(unlist(sapply(data$features, function(x){return(names(x$properties$tags))}))))

title_ideen <- sapply(data_ideen, function(x) x$name)
url_ideen <- sapply(data_ideen, function(x) x$url)
#descr_ideen <- sapply(data_ideen, function(x){content <- x$text; if(is.null(content)){return(NA)}else{return(paste(content,collapse=";"))}})
coords_ideen <- round(sapply(data_ideen, function(x){content <- x$location; if(is.null(content)){return(c(NA,NA))}else{return(as.numeric(strsplit(content,",")[[1]]))}}), 5)


ideen_info <- cbind(title_ideen, url_ideen, lat=coords_ideen[1,], lon=coords_ideen[2,]) #, descr_ideen)
