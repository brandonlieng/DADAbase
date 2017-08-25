#' Pull matching known sequences from DADAbase
#'
#' @description
#' Queries the archivedSeqs table to pull any matching sequences and stored information that show up in the input dataset.
#' @examples
#' knownSeqs <- DADAbase.specifyTaxoKeys("GreenGenes, Silva")
#' @export
DADAbase.getKnownSeqs <- function() {
    query <- paste("SELECT accessionNum, sequence, taxonomy, taxoKeys, entryNum FROM archivedSeqs WHERE sequence IN (SELECT sequence FROM incoming);")

    known <- dbGetQuery(ch, query)
    if(dim(known)[1] == 0) stop("No sequences that are already in DADAbase.")

    return(known)
}
