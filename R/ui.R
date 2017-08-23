shinyUI(
    navbarPage("DADAbase",
        tabPanel("Introduction",
            fluidPage(
                mainPanel(h2("Welcome to DADAbase.", align="center"),

                p("This is a database acting as an archive of sequence variants identified by the", code("DADA2"), "R package."),
                p("DADA2 outputs a sequence variant table and associated taxa table, the latter of which this applet accepts as input. The table is used to allow for contributing novel sequence variants to the database, pulling known data on variants already logged in the database, and comparing new data to older runs."),
                br(), br(),
                p("To work with DADAbase, you should have a taxa table after going through the DADA2 workflow as outlined in their tutorial ", a("found here.", href="http://benjjneb.github.io/dada2/tutorial.html"),
                "The table should be saved as a tab-delimited text file with sequence variants naming rows and columns corresponding to taxonomic levels. An example text file has been placed here[ADD LINK TO GITHUB]."),
                p("When you have your data in the proper format, proceed to the", strong("Input"), "page to upload it."))
            )
        ),
        tabPanel("Input",
            fluidPage(
                titlePanel("Input"),
                sidebarLayout(
                    sidebarPanel(
                        fileInput("dataIncoming", label = h3("Upload table"),
                                  accept = c('text/csv',
                                  'text/comma-separated-values,text/plain', '.csv'))
                    ),
                    mainPanel(
                    )
                )
            )
        ),
        tabPanel("Explore"),
        tabPanel("Commit")
    )
)
