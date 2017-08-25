library(RMySQL)

DADAbase.openConnection <- function(u, pass) {
    # Connection object
    ch <<- dbConnect(MySQL(), user=u, password=pass,
                     dbname='DADAbase', host='localhost')

    paste("Successfully connected to DADAbase.")
}
