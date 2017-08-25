#' Pull all known sequences from DADAbase
#'
#' @description
#' Queries the entire archivedSeqs table and returns all known information.
#' @examples
#' all <- DADAbase.getAllSeqs()
#' @export
DADAbase.getAllSeqs <- function() {
    query <- paste("SELECT * FROM archivedSeqs;")

    archived <- dbGetQuery(ch, query)
    if(dim(archived)[1] == 0) stop("Archive is empty.")

    return(archived)
}
