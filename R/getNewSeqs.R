DADAbase.getNewSeqs <- function() {
    query <- paste("SELECT * FROM incoming WHERE sequence NOT IN (SELECT sequence FROM archivedSeqs);")

    newSeqs <- dbGetQuery(ch, query)
    if(dim(newSeqs)[1] == 0) stop("No new sequences.")

    return(newSeqs)
}
