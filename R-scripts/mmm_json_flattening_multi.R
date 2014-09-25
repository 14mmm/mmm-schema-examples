#url-liste erstellen

# urllist <- readtable("urllist.txt")

urllist <- c("http://beta.lifeguide-augsburg.de/?ptype=get_markers&stype=cat",
"http://www.ideenhochdrei.org/__ajax__/pms/",
"http://ohne-chef.org/regional/ajax/getAll")

#raw_datas <- array(NA, length(urllist))
#objs <- array(NA, length(urllist))
flatdatas <- array(NA, length(urllist))

flatlist <- function(mylist){
  lapply(rapply(mylist, enquote, how="unlist"), eval)
}

records2df <- function(recordlist, columns) {
  if(length(recordlist)==0 && !missing(columns)){
    return(as.data.frame(matrix(ncol=length(columns), nrow=0, dimnames=list(NULL,columns))))
  }
  un <- lapply(recordlist, flatlist)
  if(!missing(columns)){
    ns <- columns;
  } else {
    ns <- unique(unlist(lapply(un, names)))
  }
  un <- lapply(un, function(x) {
    y <- as.list(x)[ns]
    names(y) <- ns
    lapply(y, function(z) if(is.null(z)) NA else z)})
  s <- lapply(ns, function(x) sapply(un, "[[", x))
  names(s) <- ns
  data.frame(s, stringsAsFactors=FALSE)
}

for(k in 1:length(urllist))
{
raw_datas <- getURL(urllist[k])
 #str(raw_data_lg)
print("1")
 objs <- fromJSON(raw_datas)
print("2")
print(objs)
 flatdatas[k] <- records2df(objs)
print("3")
}

