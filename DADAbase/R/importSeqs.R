#' Close the connection to the SQL database
#'
#' @param incomingTaxa A data.frame coming from the end of the DADA2 pipeline where rows are sequences and the columns are taxonomic levels describing each sequence variant.
#' @description
#' Accepts a taxonomy table and partitions out sequences that don't exist in the archivedSeqs portion of DADAbase.
#' @examples
#' DADAbase.importSeqs(taxa)
#' @export
DADAbase.importSeqs <- function(incomingTaxa) {
    highestEntryNum <- dbGetQuery(ch, "SELECT MAX(entryNum) FROM archivedSeqs;")[[1]]
    currentEntryNum <- highestEntryNum + 1

    if(is.na(currentEntryNum)) currentEntryNum <- 1

    # Inserts sequence variants and associated taxonomy into incoming table
    for(i in 1:length(rownames(incomingTaxa))) {
        taxaToInsert <- paste(incomingTaxa[i, ], collapse=" ")

        query <- paste("INSERT INTO incoming VALUES('",
        rownames(incomingTaxa)[i], "', ", "'", taxaToInsert, "', ",
        "'Unspecified' ,",currentEntryNum, ");")

        dbGetQuery(ch, query)
    }

    # Push new sequences in the incoming data to newSeqs
    query <- paste("INSERT INTO newSeqs SELECT sequence, taxonomy, taxoKeys, entryNum FROM incoming WHERE sequence NOT IN (SELECT sequence FROM archivedSeqs);")

    dbGetQuery(ch, query)
}
