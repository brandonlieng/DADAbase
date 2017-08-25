DADAbase.importSeqs <- function(incoming) {
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

    # Push new sequences in the incoming data to newSeqs
    query <- paste("INSERT INTO newSeqs SELECT sequence, taxonomy, taxoKeys, entryNum FROM incoming WHERE sequence NOT IN (SELECT sequence FROM archivedSeqs);")

    dbGetQuery(ch, query)
}
