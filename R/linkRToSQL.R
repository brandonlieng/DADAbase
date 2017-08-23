library(RMySQL)

# Connection object
ch = dbConnect(MySQL(), user='brandonlieng', password='LocalDADATest',
               dbname='DADAbase', host='localhost')

# Inserts sequence variants and associated taxonomy into incoming table
for(i in 1:length(rownames(taxa))) {
    taxaToInsert <- paste(taxa[i, ], collapse=" ")

    query <- paste("INSERT INTO incoming VALUES('", rownames(taxa)[i], "', ",
    i, ", '", taxaToInsert, "', ", "'GreenGenes;Silva'", ", '", paste(c(1, 2),
    collapse=";"), "');")

    dbGetQuery(ch, query)
}
