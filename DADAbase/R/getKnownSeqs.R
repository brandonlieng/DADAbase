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
    # Check to make sure DADAbase is populated
    query <- paste("SELECT COUNT(*) FROM sequence;")
    count <- dbGetQuery(ch, query)[[1]]
    if(count == 0) stop("No sequences in DADAbase.")

    # Pulling matching sequence information on current variants
    variants <- colnames(seqMatrix)
    variantsToQuery <- paste("'", paste(variants, collapse="', '"), "'", sep = "")

    query <- paste("SELECT * FROM sequence WHERE sequence in (", variantsToQuery, ");", sep="")
    known <- dbGetQuery(ch, query)

    if(dim(known)[1] == 0) stop("No sequences that are already in DADAbase.")
    numKnown <- paste(as.character(dim(known)[1]), "sequences are already in DADAbase.")
    print(numKnown)

    return(known)
}
