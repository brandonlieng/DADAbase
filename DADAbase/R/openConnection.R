#' Open a connection to the SQL database
#'
#' @description
#' Uses the \code{RSQLite} package to establish a connection to DADAbase from the active R session.
#' @examples
#' DADAbase.openConnection()
#' @export
DADAbase.openConnection <- function() {
    library(RSQLite)

    # Connection object
    ch <<- dbConnect(RSQLite::SQLite(), "/Volumes/longlunch/seq/annotationDB/dada2/DADAbase.db")

    if(exists('ch')) {paste("Successfully connected to DADAbase.")}
}
