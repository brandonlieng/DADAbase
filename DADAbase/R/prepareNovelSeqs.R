#' Creates a data frame with novel sequences for annotation
#'
#' @param knownMatrix A data.frame coming from the output of DADAbase.removeKnownSeqs()
#' @description
#' Accepts a sequence matrix and prepares a sequence data frame with predefined columns for import into DADAbase downstream
#' @examples
#' DADAbase.importSeqs(seqtab.removed)
#' @export
DADAbase.prepareNovelSeqs <- function(seqMatrix) {
    novelSeqs <- matrix(nrow = (dim(seqMatrix)[2]), ncol = 8)

    colnames(novelSeqs) <- c("sequence", "taxonomy", "taxoMethod", "primers", "annealingTemp", "doi", "runNum", "groupNum")

    novelSeqs[,1] <- colnames(seqMatrix)

    return(novelSeqs)
}
