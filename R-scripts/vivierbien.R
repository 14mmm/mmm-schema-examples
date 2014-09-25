library("rjson")
library("RCurl")
library("xlsReadWrite")

# Einladen der URL und exportieren aus JSON-Format
raw_data <- getURL("http://vivirbien.mediavirus.org/view/all/json/")
fromJSON(raw_data)
data <- fromJSON(raw_data)

alltags <- sort(unique(unlist(sapply(data$features, function(x){return(names(x$properties$tags))}))))

title <- sapply(data$features, function(x) x$properties$title)
url <- sapply(data$features, function(x) x$properties$url)
#description <- sapply(data$features, function(x){content <- x$properties$tags$description; if(is.null(content)){return(NA)}else{return(paste(content,collapse=";"))}})
coordinates <- round(sapply(data$features, function(x){content <- x$geometry$coordinates; if(is.null(content)){return(c(NA,NA))}else{return(content)}}), 5)
start_date <- sapply(data$features, function(x){content <- x$properties$tags$start_date; if(is.null(content)){return(NA)}else{return(paste(content,collapse=";"))}})

vivinfo <- cbind(title, url, lat=coordinates[1,], lon=coordinates[2,])#, description) #, start_date,  )


#table <- write.table(vivinfo)
#write.table(vivinfo, "C:\\Documents and Settings\\ohmann\\My Documents\\PIK\\Dominik\\mydata.txt")
