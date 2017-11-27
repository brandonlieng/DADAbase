#' Creates a data frame with sequences for annotation
#'
#' @param seqMatrix A data.frame coming from the output of DADAbase.removeKnownSeqs() -- holds novel variants
#' @param knownMatrix A data.frame coming from the output of DADAbase.getKnownSeqs() -- holds known variants
#' @description
#' Accepts a sequence matrix and prepares a sequence data frame with predefined columns for import into DADAbase downstream. If knownMatrix is not NULL, then the output will also contain a data frame of known sequences to update DADAbase to show that variant was also found in this run.
#' @examples
#' seqtab.import <- DADAbase.prepareSeqs(seqtab.removed, seqtab.known)
#' @export
DADAbase.prepareSeqs <- function(seqMatrix, knownMatrix=NULL) {
    novelSeqs <- matrix(nrow = (dim(seqMatrix)[2]), ncol = 7)
    colnames(novelSeqs) <- c("sequence", "taxonomy", "taxoMethod", "primers", "annealingTemp", "doi", "groupNum")
    novelSeqs <- data.frame(novelSeqs, check.names=F)
    novelSeqs[,1] <- colnames(seqMatrix)

    if (!is.null(knownMatrix)) {
        knownSeqs <- matrix(nrow = (dim(knownMatrix)[1]), ncol = 2)
        colnames(knownSeqs) <- c("sequence", "groupNum")
        knownSeqs <- data.frame(knownSeqs, check.names=F)
        knownSeqs$sequence <- knownMatrix$sequence

        seqFrames <- list(novelSeqs=novelSeqs, knownSeqs=knownSeqs)
        return(seqFrames)
    }
    return(novelSeqs)
}
