DADAbase.closeConnection <- function(){
    query <- paste("TRUNCATE newSeqs;")
    dbGetQuery(ch, query)

    query <- paste("TRUNCATE incoming;")
    dbGetQuery(ch, query)

    dbDisconnect(ch)
}
