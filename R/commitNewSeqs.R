DADAbase.commitNewSeqs <- function() {
    countBeforeCommit <- dbGetQuery(ch, "SELECT COUNT(*) FROM archivedSeqs;")

    query <- paste("INSERT INTO archivedSeqs (sequence, taxonomy, taxoKeys, entryNum) SELECT sequence, taxonomy, taxoKeys, entryNum FROM newSeqs;")
    dbGetQuery(ch, query)

    countAfterCommit <- dbGetQuery(ch, "SELECT COUNT(*) FROM archivedSeqs;")

    paste((countAfterCommit - countBeforeCommit), "sequences committed to DADAbase."
}
