#' Pull the runs and groups that a sequence was found in
#'
#' @description
#' Searches DADAbase to pull run and group information for a particular sequence. The sequence can be queried on the actual sequence string itself or it can be queried on the accession number of the sequence.
#'
#' @param key The accession number or sequence the
#' @examples
#' DADAbase.knownSeqsSource(12)
#' @export
DADAbase.knownSeqsSource <- function(key, queryOnSeq = FALSE) {
    if(class(key) == "character" & queryOnSeq) {
        assert("The key for querying on is a string. Set queryOnSeq param to TRUE")
    } else if(!queryOnSeq) {
        query <- paste("SELECT * FROM SequenceInEntry WHERE accessNum=", key, ";", sep="", collapse="")
        if(dim(dbGetQuery(ch, query))[1] == 0) {assert("Sequence not found.")}
        dbGetQuery(ch, query)
    } else if (queryOnSeq) {
        query <- paste("SELECT accessNum, runNum, groupNum FROM SequenceInEntry NATURAL JOIN Sequence WHERE sequence='", key, "';", sep="", collapse="")
        dbGetQuery(ch, query)
        if(dim(dbGetQuery(ch, query))[1] == 0) {assert("Sequence not found.")}
        dbGetQuery(ch, query)
    }
}
