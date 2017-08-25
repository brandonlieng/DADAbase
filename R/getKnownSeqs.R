DADAbase.getKnownSeqs <- function() {
    query <- paste("SELECT accessionNum, sequence, taxonomy, taxoKeys, entryNum FROM archivedSeqs WHERE sequence IN (SELECT sequence FROM incoming);")

    archived <- dbGetQuery(ch, query)
    if(dim(archived)[1] == 0) stop("Archive is empty.")

    return(archived)
}
