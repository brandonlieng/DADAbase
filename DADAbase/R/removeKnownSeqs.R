#' Pull matching known sequences from a sequence matrix
#'
#' @description
#' Queries the archivedSeqs table to pull any matching sequences that show up in the archive already. Uses these matches to remove columns from the sequence matrix so that sequences already annotated are excluded from DADA2's downstream annotation.
#'
#' @return
#' A data.frame of sequences and associated taxonomic data from the archive
#' @examples
#' seqtab.removed <- DADAbase.removeKnownSeqs(seqtab.nochim, seqtab.known)
#' @export
DADAbase.removeKnownSeqs <- function(seqMatrix, knownData) {
    # Generate vector of sequences from known data.frame with check for known
    # object existence
    if((dim(knownData)[1] < 1) == TRUE || dim(knownData)[2] != 7) {
        stop("Either no sequences are already known or an invalid known sequences data frame was provided. Please provide the output data frame from DADAbase.getKnownSeqs().")
    }

    # Get sequences from archive
    knownSeqs <- knownData[, 2]
    for(i in 1:length(knownSeqs)) {
        knownSeqs[i] <- gsub(" ", "", knownSeqs[i])
    }

    toRemove <- c()
    for(i in 1:dim(seqMatrix)[2]) {
        if(colnames(seqMatrix)[i] %in% knownSeqs) {
            toRemove <- c(toRemove, i)
        }
    }
    seqMatrix <- seqMatrix[, -toRemove]

    if(dim(seqMatrix)[2] == 0) stop("No sequences remaining.")

    return(seqMatrix)
}
