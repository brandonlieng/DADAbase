shinyServer(function(input, output) {
    data <- reactive({
        #reactive input file
        inFile <- input$file1

        #return NULL when no file is uploaded
        if (is.null(inFile))
          return(NULL)

        #reads the file
        read.table(
          inFile$datapath,
          header = TRUE,
          sep = "\t",
          stringsAsFactors = FALSE,
          quote = "",
          row.names = 1,
          check.names = FALSE,
          comment.char = "",
          na.strings = ""
         )
    })

    output$data <- renderDataTable(
        data<- data())
})
