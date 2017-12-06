DADAbase.connect <- function() {
    library(RSQLite)

    # Connection object
    ch <<- dbConnect(RSQLite::SQLite(), "/Volumes/longlunch/seq/annotationDB/dada2/DADAbase.db")

    if(exists('ch')) {paste("Successfully connected to DADAbase.")}
}

DADAbase.getKnownSeqs <- function(seqs) {
    # Check to make sure DADAbase is populated
    query <- paste("SELECT COUNT(*) FROM Sequence;")
    if(dbGetQuery(ch, query)[[1]] == 0) stop("No sequences in DADAbase.")

    # Pull seqIDs for variants already in DADAbase
    variantsToQuery <- paste("'", paste(colnames(seqs), collapse="', '"), "'", sep = "")

    query <- paste("SELECT seqID FROM Sequence WHERE sequence in (", variantsToQuery, ");", sep="")
    known <- as.vector(dbGetQuery(ch, query))

    # Check for # of returned sequences from DADAbase then output information
    if(dim(known)[1] == 0) stop("No sequences that are already in DADAbase.")
    print(paste(as.character(dim(known)[1]), "sequences are already in DADAbase."))

    # RETURN a vector of seqIDs
    return(known)
}

DADAbase.getNovelSeqs <- function(seqs, known) {
    if((length(known) == 0)) {
        stop("Invalid known sequence vector provided. Please provide the output of DADAbase.getKnownSeqs().")
    }

    # Get all known sequences with known seqIDs
    knownSequences <- c()
    for (i in 1:length(known)) {
        query <- paste("SELECT sequence FROM Sequence WHERE seqID=", known[i])
        result <- dbGetQuery(ch, query)[[1]]
        knownSequences <- c(knownSequences, result)
    }

    # Generate a novel sequence vector by pulling sequences in the query data
    # frame's colnames with no matching sequence in DADAbase
    novel <- c()
    for (i in 1:length(colnames(seqs))) {
        if (!colnames(seqs)[i] %in% knownSequences) {
            novel <- c(novel, colnames(seqs)[i])
        }
    }

    # RETURN a vector of sequences
    return(novel)
}

DADAbase.annotate <- function(novel) {
    # Create annotation data frame
    anno <- matrix(nrow = length(novel), ncol = 13)
    colnames(anno) <- c("sequence", "kingdom", "phylum", "class", "order", "family", "genus", "species", "sourceDatabase", "RID", "primers", "doi", "groupID")
    anno <- data.frame(anno, check.names=F)
    anno[, 1] <- novel

    return(anno)
}

# TODO: Update Log table values for sequences already in DADAbase

# TODO: Integrate output from annotation so that user can just input their
#       output from annotation

# TODO: Work in commit function and query capabilities
