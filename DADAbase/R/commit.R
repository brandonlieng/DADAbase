#' Commit new sequences to DADAbase
#'
#' @description
#' Commits the sequences in newSeqs to DADAbase for archiving. Reports number of sequences committed.
#' @export
DADAbase.commit <- function(importMat) {
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

    for(i in 1:(dim(importMat)[1])) {
        insert <- as.vector(importMat[i,])

        query <- paste("INSERT INTO sequence (sequence, taxonomy, taxoMethod, primers, annealingTemp, doi, runNum, groupNum) VALUES ('", insert[1], "', '", insert[2], "', '", insert[3], "', '", insert[4], "', '", insert[5], "', '", insert[6], "', '", insert[7], "', '", insert[8], "');", sep="")
        dbGetQuery(ch, query)
    }

    countAfterCommit <- dbGetQuery(ch, "SELECT COUNT(*) FROM sequence;")

    paste((countAfterCommit - countBeforeCommit), "sequences committed to DADAbase.")
}
