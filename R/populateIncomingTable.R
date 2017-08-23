library(RMySQL)
# Connection object
ch = dbConnect(MySQL(), user='brandonlieng', password='LocalDADATest',
               dbname='DADAbase', host='localhost')

populateIncomingTable <- function(){
    highestEntryNum <- dbGetQuery(ch, "SELECT MAX(entryNum) FROM archivedSeqs;")[[1]]
    currentEntryNum <- highestEntryNum + 1

    if(is.na(currentEntryNum)) currentEntryNum <- 1

    # Inserts sequence variants and associated taxonomy into incoming table
    for(i in 1:length(rownames(taxa))) {
        taxaToInsert <- paste(taxa[i, ], collapse=" ")

        query <- paste("INSERT INTO incoming VALUES('", rownames(taxa)[i],
        "', ", "'", taxaToInsert, "', ", "'Unspecified' ,",
        currentEntryNum, ");")

        dbGetQuery(ch, query)
    }
}

populateIncomingTable()
