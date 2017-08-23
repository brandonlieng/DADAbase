pullArchivedSeqs <- function() {
    query <- paste("SELECT accessionNum, sequence, taxonomy, taxoKeys, entryNum FROM archivedSeqs WHERE sequence IN (SELECT sequence FROM incoming);")

    archived <- dbGetQuery(ch, query)
    return(archived)
}

pullArchivedSeqs()
