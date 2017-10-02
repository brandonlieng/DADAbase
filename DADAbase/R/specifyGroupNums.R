#' Update the group number column for new sequences
#'
#' @param groupNumTable A data frame of sequences and corresponding grouping numbers to be added to new sequences. Specifically should be of class data.frame with two columns titled "Sequence" and "Group". groupNumTable$Group must be of class numeric().
#' @description After import, new sequences have taxonomy and taxonomic keywords fields default to NULL. This function is used to specify values to fill in the taxonomy fields.
#' @examples
#' DADAbase.specifyTaxoKeys(" GreenGenes, Silva")
#' @export
DADAbase.specifyGroupNums <- function(groupNumTable) {
    if(all(colnames(groupNumTable) == c("Sequence", "Group")) == FALSE || class(groupNumTable$Group) != "numeric") stop("Invalid group number data frame supplied. Please refer to documentation for proper formatting.")

    currentIncomingCount <- dbGetQuery(ch, "SELECT COUNT(*) FROM incoming;")
    if(currentIncomingCount == 0) stop("No new sequences to add group numbers to.")

    for(i in 1:dim(groupNumTable)[1]) {
        currentSeq <- groupNumTable[i, 1]
        currentGroupNum <- groupNumTable[i, 2]
        query <- paste("UPDATE incoming SET incoming.groupNum = ", currentGroupNum, "WHERE incoming.sequence = '", currentSeq, "';")

        query <- gsub("' ", "'", query)
        query <- gsub(" '", "'", query)

        dbGetQuery(ch, query)
    }
}
