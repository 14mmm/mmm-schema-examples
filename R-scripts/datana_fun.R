########################################################
#Tabellen zu einer zusammenfügen
tabelle <- rbind(aux_info, chef_info, ideen_info, vivinfo)

########################################################
# Funktion erstellen
toFileFun <- function(filename){
	sink(file(filename, encoding="latin1"))
	cat("//id, lat, lon, ini-name, energy, food, transport, waste, energy-detail, food-detail, transport-detail, waste-detail, mission-1, mission-2, mission-3, country, region, members, website-url\n")
	cat("var iData = [\n")
	for(row in 1:NROW(mapinfo.markus)){
		cat("\t[")
		for(col in 1:NCOL(mapinfo.markus)){
			if(col%in%c(2,3)){
				cat(mapinfo.markus[row,col],', ')
			} else if (col==NCOL(mapinfo.markus)) {
				cat('"',gsub("\n", "; ",gsub("\r", "; ", gsub('"', "'", mapinfo.markus[row,col]))),'" ', sep="")
			} else {
				cat('"',gsub("\n", "; ",gsub("\r", "; ", gsub('"', "'", mapinfo.markus[row,col]))),'", ', sep="")
			}
		}
		if(row==NROW(mapinfo.markus)){
			cat("]\n")
		} else {
			cat("],\n")
		}
	}
	cat("]\n")
	sink(NULL)
}

# Tabelle zuordnen
mapinfo.markus <- tabelle

#File ausgeben
toFileFun("DatenInitiativen.js")
