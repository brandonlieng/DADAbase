#' Update the taxonomic keywords column for new sequences
#'
#' @param keys Keywords to be added to new sequences to specify annotation tool information.
#' @description
#' After import, new sequences are partitioned out and the taxonomic keywords fields default to "Unspecified". This function is used to specify values to fill in these fields.
#' @examples
#' DADAbase.specifyTaxoKeys("GreenGenes, Silva")
#' @export
DADAbase.specifyTaxoKeys <- function(keys) {
    currentNewSeqCount <- dbGetQuery(ch, "SELECT COUNT(*) FROM newSeqs;")
    if(currentNewSeqCount == 0) stop("No new sequences to add keywords to.")

    query <- paste("UPDATE newSeqs SET taxoKeys =", "'", keys, "';")
    dbGetQuery(ch, query)
}
