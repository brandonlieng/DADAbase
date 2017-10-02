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

        doneQuery <- readline("Is the above information correct? (Y/N): ")

        if(doneQuery == "Y" || doneQuery == "y") {
            doneFlag <- TRUE
            query <- paste("INSERT INTO entryMetadata (runNum, platform, operator) VALUES (", currentRunNum, ", '", platformInput, "', '", operatorInput, "');")
            dbGetQuery(ch, query)
        }
        else {
            paste("\n\n")
        }
    }
}
