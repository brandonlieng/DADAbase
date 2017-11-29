#' Query DADAbase with string matching
#'
#' @param queryTerm The term to query for
#' @param matchOn The attribute to query on
#' @param exactMatching Whether or not the returned sequences should be those that exactly match the queryTerm
#' @description
#' Querys DADAbase by using string matching
#' @examples
#' DADAbase.query('V4', 'primers', TRUE)
#' @export
DADAbase.query <- function(queryTerm, matchOn, exactMatching=FALSE) {
    if(exactMatching == TRUE) {
        query <- paste("SELECT * FROM sequence WHERE ", matchOn, "='", queryTerm, "';", sep="")
        return(dbGetQuery(query))
    }
    else {
        query <- paste("SELECT * FROM sequence WHERE ", matchOn, " LIKE '%", queryTerm, "%';", sep="")
        return(dbGetQuery(query))
    }
}
