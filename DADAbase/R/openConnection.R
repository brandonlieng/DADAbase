#' Open a connection to the SQL database
#'
#' @param u The username to be passed to log into the MySQL server
#' @param pass The password to be passed to log into the MySQL server
#' @description
#' Uses the \code{RMySQL} package to establish a connection to DADAbase from the active R session.
#' @examples
#' DADAbase.openConnection('sampleusername', 'samplepassword')
#' @export
DADAbase.openConnection <- function(u = NULL, pass = NULL) {
    if(is.null(u)) stop("Specify username.")
    if(is.null(pass)) stop("Specify password.")

    # Connection object
    ch <<- dbConnect(MySQL(), user=u, password=pass,
                     dbname='DADAbase', host='localhost')

    paste("Successfully connected to DADAbase.")
}
