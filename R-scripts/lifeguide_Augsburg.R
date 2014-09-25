library("rjson")
library("RCurl")

# Einladen der URL und exportieren aus JSON-Format
raw_aux <- getURL("http://beta.lifeguide-augsburg.de/?ptype=get_markers&stype=cat")
#str(raw_data)
fromJSON(raw_aux)

data_aux <- fromJSON(raw_aux)

alltags <- sort(unique(unlist(sapply(data$features, function(x){return(names(x$properties$tags))}))))

title_aux <- sapply(data_aux, function(x) x$formattedprice)
url_aux <- sapply(data_aux, function(x) x$icon)
coordinates_long_aux <- sapply(data_aux, function(x){content <- x$long_pos; if(is.null(content)){return(c(NA,NA))}else{return(content)}})
coordinates_lat_aux <- sapply(data_aux, function(x){content <- x$lat_pos; if(is.null(content)){return(c(NA,NA))}else{return(content)}})
coords_aux <- cbind(coordinates_long_aux, coordinates_lat_aux)
#descr_aux <- data.frame(matrix(NA, nrow = 178, ncol = 1))
#descr_aux <- array(0,dim=c(0,178))

aux_info <- cbind(title_aux, url_aux, coordinates_long_aux, coordinates_lat_aux)#, descr_aux)
