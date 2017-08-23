archiveNewSeqs <- function() {
    query <- paste("INSERT INTO archivedSeqs (sequence, taxonomy, taxoKeys, entryNum) SELECT sequence, taxonomy, taxoKeys, entryNum FROM newSeqs;")

    dbGetQuery(ch, query)
}

archiveNewSeqs()
