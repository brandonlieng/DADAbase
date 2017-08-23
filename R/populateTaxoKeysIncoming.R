populateTaxoKeysIncoming <- function(key) {
    query <- paste("UPDATE incoming SET taxoKeys =", "'", key, "';")

    dbGetQuery(ch, query)
}
