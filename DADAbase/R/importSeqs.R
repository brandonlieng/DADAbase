#' Close the connection to the SQL database
#'
#' @param incomingTaxa A data.frame coming from the end of the DADA2 pipeline where rows are sequences and the columns are taxonomic levels describing each sequence variant.
#' @description
#' Accepts a taxonomy table and partitions out sequences that don't exist in the archivedSeqs portion of DADAbase.
#' @examples
#' DADAbase.importSeqs(taxa)
#' @export
DADAbase.importSeqs <- function(seqMatrix) {
    highestEntryNum <- dbGetQuery(ch, "SELECT MAX(entryNum) FROM archivedSeqs;")[[1]]
    currentEntryNum <- highestEntryNum + 1

    if(is.na(currentEntryNum)) currentEntryNum <- 1

    # Inserts sequence variants and associated taxonomy into incoming table
    for(i in 1:length(colnames(seqMatrix))) {
        query <- paste("INSERT INTO incoming (sequence, entryNum) VALUES('",
        colnames(seqMatrix)[i], "', ", currentEntryNum, ");")

        query <- gsub("' ", "'", query)
        query <- gsub(" '", "'", query)

        dbGetQuery(ch, query)
    }
}
