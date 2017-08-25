DADAbase.specifyTaxoKeys <- function(keys) {
    query <- paste("UPDATE newSeqs SET taxoKeys =", "'", keys, "';")
    dbGetQuery(ch, query)
}
