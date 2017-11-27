#' Commit new sequences to DADAbase
#'
#' @description
#' Commits the sequences in newSeqs to DADAbase for archiving. Reports number of sequences committed.
#' @examples
#' DADAbase.commit(seqtab.import$novelSeqs, seqtab.import$knownSeqs)
#' @export
DADAbase.commit <- function(importMat, knownSeqs=NULL) {
    # Get number of sequences before commit
    countBeforeCommit <- dbGetQuery(ch, "SELECT COUNT(*) FROM sequence;")

    # Collect metadata for entry: platform, operator
    doneFlag <- FALSE
    paste("Enter metadata information according to prompts...\n")
    while(doneFlag == FALSE) {
        platformInput <- readline("Enter the platform used for this run (e.g. miseq/hiseq/nextseq): ")
        operatorInput <- readline("Enter your name: ")

        doneQuery <- readline("Is the above information correct? (Y/N): ")

        if(doneQuery == "Y" || doneQuery == "y") {
            doneFlag <- TRUE
            query <- paste("INSERT INTO entry (platform, operator) VALUES ('", platformInput, "', '", operatorInput, "');", sep="")
            dbGetQuery(ch, query)
        }
        else {
            paste("\n\n")
        }
    }

    runNum <- dbGetQuery(ch, "SELECT COUNT(*) FROM entry;")[[1]]
    if (runNum == 0) {
        runNum <- 1
    }

    for(i in 1:(dim(importMat)[1])) {
        insert <- as.vector(importMat[i,])

        query <- paste("INSERT INTO sequence VALUES (NULL, '", insert[1], "', '", insert[2], "', '", insert[3], "', '", insert[4], "', '", insert[5], "', '", insert[6], "', ", insert[7], ");", sep="")
        dbGetQuery(ch, query)

        query <- paste("SELECT accessNum FROM Sequence WHERE sequence='", insert[1], "';", sep="")[[1]]
        accessNum <- dbGetQuery(ch, query)[[1]]

        query <- paste("INSERT INTO SequenceInEntry (accessNum, runNum, groupNum) VALUES (", accessNum, ", ", runNum, ", ", insert[7], ");", sep="")
        dbGetQuery(ch, query)
    }

    countAfterCommit <- dbGetQuery(ch, "SELECT COUNT(*) FROM sequence;")
    beforeUpdate <- dbGetQuery(ch, "SELECT COUNT(*) FROM SequenceInEntry;")

    if (!is.null(knownSeqs)) {
        for(i in 1:(dim(knownSeqs)[1])) {
            seqUpdate <- knownSeqs[i, 1]

            query <- paste("SELECT accessNum FROM Sequence WHERE sequence='", seqUpdate, "';", sep="")
            accessNum <- dbGetQuery(ch, query)[[1]]

            query <- paste("INSERT INTO SequenceInEntry VALUES (", accessNum, ", ", runNum, ", ", knownSeqs[i, 2], ");", sep="")
            dbGetQuery(ch, query)
        }
    }

    afterUpdate <- dbGetQuery(ch, "SELECT COUNT(*) FROM SequenceInEntry;")

    paste((countAfterCommit - countBeforeCommit), "sequences committed to DADAbase.",
    (afterUpdate - beforeUpdate), "sequences updated in DADAbase.")
}
