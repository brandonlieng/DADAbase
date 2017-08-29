#' Add metadata to an entry to DADAbase
#'
#' @description
#' Stores DADAbase about an import of data into DADAbase based on prompt-based inputs.
#' @examples
#' DADAbase.specityMetadata()
#' @export
DADAbase.specifyMetadata <- function() {
    highestRunNum <- dbGetQuery(ch, "SELECT MAX(runNum) FROM archivedSeqs;")[[1]]
    currentRunNum <- highestRunNum + 1

    if(is.na(currentRunNum)) currentRunNum <- 1

    if(all(dbGetQuery(ch, "SELECT COUNT(*) FROM incoming;") == 0)) {
        stop("Incoming data table is empty. Import sequences first with DADAbase.importSeqs().")
    }

    doneFlag <- FALSE
    paste("Enter metadata information according to prompts...\n")
    while(doneFlag == FALSE) {
        platformInput <- readline("Enter the platform used for this run (e.g. miseq/hiseq/nextseq): ")
        operatorInput <- readline("Enter your name: ")

        doneQuery <- readline("You entered ", platformInput, " as the platform for this run. This run will be logged under the name ", operatorInput, ". Is this information correct? (Y/N): ")
        if(doneQuery == "Y" | doneQuery == "y") {
            doneFlag <- TRUE
        }
        else {
            paste("\n\n")
        }
    }
}
