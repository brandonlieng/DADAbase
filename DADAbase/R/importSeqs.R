#' Close the connection to the SQL database
#'
#' @param seqMatrix A data.frame coming from the end of the DADA2 pipeline where rows are samples and the columns are sequence variants.
#' @description
#' Accepts a sequence matrix and partitions out sequences that don't exist in the archivedSeqs portion of DADAbase.
#' @examples
#' DADAbase.importSeqs(taxa)
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
}
