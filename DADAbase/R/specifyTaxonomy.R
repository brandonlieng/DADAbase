#' Update the taxonomy column for new sequences
#'
#' @param taxoTable A data frame of sequences and paired taxonomic information to be added to new sequences. Specifically should be of class data.frame with two columns titled "Sequence" and "Taxonomy".
#' @description After import, new sequences have taxonomy and taxonomic keywords fields default to NULL. This function is used to specify values to fill in the taxonomy fields.
#' @examples
#' DADAbase.specifyTaxoKeys(" GreenGenes, Silva")
#' @export
DADAbase.specifyTaxonomy <- function(taxoTable) {
    if(all(colnames(taxoTable) != c("Sequence", "Taxonomy"))) stop("Invalid taxonomy data frame supplied. Please refer to documentation for proper formatting.")

    currentIncomingCount <- dbGetQuery(ch, "SELECT COUNT(*) FROM incoming;")
    if(currentIncomingCount == 0) stop("No new sequences to add keywords to.")

    for(i in 1:dim(taxoTable)[1]) {
        currentSeq <- taxoTable[i, 1]
        currentTaxo <- taxoTable[i, 2]
        query <- paste("UPDATE incoming SET incoming.taxonomy = '", currentTaxo , "' WHERE incoming.sequence = '", currentSeq, "';")

        query <- gsub("' ", "'", query)
        query <- gsub(" '", "'", query)

        dbGetQuery(ch, query)
    }
}
