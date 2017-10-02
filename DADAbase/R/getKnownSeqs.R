#' Pull matching known sequences from DADAbase
#'
#' @description
#' Queries the archivedSeqs table to pull any matching sequences and stored information that show up in the input dataset.
#' @return
#' A data.frame of sequences and associated taxonomic data from the archive
#' @examples
#' seqtab.known <- DADAbase.getKnownSeqs(seqtab.nochim)
#' @export
DADAbase.getKnownSeqs <- function(seqMatrix) {
    # Get sequences already archived
    query <- paste("SELECT sequence FROM archivedSeqs;")
    archive <- dbGetQuery(ch, query)[[1]]
    for(i in 1:length(archive)) {
        archive[i] <- gsub(" ", "", archive[i])
    }
    if(all(is.na(archive))) stop("No sequences in archive.")

    # Pulling matching sequence information on current variants from archive,
    # if avaliable
    variants <- colnames(seqMatrix)
    known <- c()
    for(i in 1:length(variants)) {
        if(variants[i] %in% archive) {
            known <- c(known, variants[i])
        }
    }
    if(length(known) == 0) stop("No sequences that are already in DADAbase.")

    # Update knownSeqs list to use as comparitor to pull from archivedSeqs
    for(i in 1:length(known)) {
        query <- paste("INSERT INTO knownSeqs (sequence) VALUES ('", known[i], "');")
        dbGetQuery(ch, query)
    }

    knownData <- dbGetQuery(ch, "SELECT * FROM archivedSeqs WHERE sequence IN (SELECT sequence from archivedSeqs);")

    paste(dim(knownData)[1], " sequences are already in DADAbase.")

    return(knownData)
}
