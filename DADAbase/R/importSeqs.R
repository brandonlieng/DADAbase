#' Import novel sequence variants to DADAbase for annotation
#'
#' @param seqMatrix A data.frame coming from the end of the DADA2 pipeline where rows are samples and the columns are sequence variants.
#' @description
#' Accepts a sequence matrix and partitions out sequences that don't exist in the archivedSeqs portion of DADAbase.
#' @examples
#' DADAbase.importSeqs(seqtab.removed)
#' @export
DADAbase.importSeqs <- function(seqMatrix) {
    highestRunNum <- dbGetQuery(ch, "SELECT MAX(runNum) FROM archivedSeqs;")[[1]]
    currentRunNum <- highestRunNum + 1

    if(is.na(currentRunNum)) currentRunNum <- 1

    # Inserts sequence variants and associated taxonomy into incoming table
    for(i in 1:length(colnames(seqMatrix))) {
        query <- paste("INSERT INTO incoming (sequence, runNum) VALUES('",
        colnames(seqMatrix)[i], "', ", currentRunNum, ");")

        query <- gsub("' ", "'", query)
        query <- gsub(" '", "'", query)

        dbGetQuery(ch, query)
    }
    currentImportCount <- dbGetQuery(ch, "SELECT COUNT(*) FROM incoming;")[[1]]
    if(currentImportCount != dim(seqMatrix)[2]) {
        stop("Import error. Purge incoming data and retry.")
    }
    else {
        paste("Import of", currentImportCount, "sequence variants successful.")
    }
}
