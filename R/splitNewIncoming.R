splitNewIncoming <- function(){
    # Push new sequences in the incoming data to newSeqs
    query <- paste("INSERT INTO newSeqs SELECT sequence, taxonomy, taxoKeys, entryNum FROM incoming WHERE sequence NOT IN (SELECT sequence FROM archivedSeqs);")

    dbGetQuery(ch, query)
}
