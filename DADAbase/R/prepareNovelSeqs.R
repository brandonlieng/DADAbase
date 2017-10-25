#' Creates a data frame with novel sequences for annotation
#'
#' @param knownMatrix A data.frame coming from the output of DADAbase.removeKnownSeqs()
#' @description
#' Accepts a sequence matrix and prepares a sequence data frame with predefined columns for import into DADAbase downstream
#' @examples
#' DADAbase.importSeqs(seqtab.removed)
#' @export
DADAbase.prepareNovelSeqs <- function(seqMatrix) {
    novelSeqs <- matrix(nrow = (dim(seqMatrix)[2]), ncol = 7)

    colnames(novelSeqs) <- c("sequence", "taxonomy", "taxoMethod", "primers", "annealingTemp", "doi", "groupNum")

    novelSeqs <- data.frame(novelSeqs, check.names=F)

    novelSeqs[,1] <- colnames(seqMatrix)

    runNum <- dbGetQuery(ch, "SELECT COUNT(*) FROM entry;")[[1]] + 1
    novelSeqs[, 7] <- as.numeric(rep(runNum, dim(seqMatrix)[2]))

    return(novelSeqs)
}
