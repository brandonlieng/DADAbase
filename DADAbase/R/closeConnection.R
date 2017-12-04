#' Close the connection to the SQL database
#'
#' @description
#' Connection to the SQLite server is closed.
#' @export
dadabase.closeconnection <- function() {
    dbDisconnect(ch)
}
