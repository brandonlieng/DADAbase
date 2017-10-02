DADAbase.status <- function() {
    incoming <- dbGetQuery(ch, "SELECT COUNT(*) FROM incoming;")
    archived <- dbGetQuery(ch, "SELECT COUNT(*) FROM archivedSeqs;")

    paste("There are", incoming, "novel sequence variants loaded into DADAbase.", "There are", archived, "sequence variants in the archive.")
}
