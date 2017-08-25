DADAbase.getAllSeqs <- function() {
    query <- paste("SELECT * FROM archivedSeqs;")

    archived <- dbGetQuery(ch, query)
    if(dim(archived)[1] == 0) stop("Archive is empty.")

    return(archived)
}
