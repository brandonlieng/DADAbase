#' Close the connection to the SQL database
#'
#' @description
#' Purges the incoming and newSeqs tables to reset DADAbase to a state where it can recieve a new dataset. After purging, the connection to the MySQL server is closed.
#' @export
DADAbase.closeConnection <- function() {
    query <- paste("TRUNCATE knownSeqs;")
    dbGetQuery(ch, query)

    query <- paste("TRUNCATE incoming;")
    dbGetQuery(ch, query)

    dbDisconnect(ch)
}
