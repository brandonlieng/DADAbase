#' Pull matching known sequences from a sequence matrix
#'
#' @description
#' Queries the archivedSeqs table to pull any matching sequences that show up in the archive already. Uses these matches to remove columns from the sequence matrix so that sequences already annotated are excluded from DADA2's downstream annotation.
#'
#' @return
#' A data.frame of sequences and associated taxonomic data from the archive
#' @examples
#' knownSeqs <- DADAbase.getKnownSeqs(seqtab.nochim)
#' @export
DADAbase.removeKnownSeqs <- function(seqMatrix, knownData) {
    # Generate vector of sequences from known data.frame with check for known
    # object existence
    if(dim(knownData)[1] < 1 | dim(knownData)[2] != 5) {
        stop("Either no sequences are already known or an invalid known sequences data frame was provided. Please provide the output data frame from DADAbase.getKnownSeqs().")
    }

    knownSeqs <- knownData[, 2]
    for(i in 1:length(knownSeqs)) {
        knownSeqs[i] <- gsub(" ", "", knownSeqs[i])
    }

    for(i in 1:dim(seqMatrix)[2]) {
        if(colnames(seqMatrix)[i] %in% knownSeqs) {
            seqMatrix <- seqMatrix[, -i]
        }
    }
    return(seqMatrix)
}
