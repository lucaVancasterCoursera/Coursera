#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(magic)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$matrix <- renderTable({
        if(input$dims != '') {
            if ( as.numeric(input$dims)<3 | as.numeric(input$dims)>20 ) {
                matrix <- magic(1)
                rownames(matrix) <- c() 
            } else {
                matrix <- magic(as.numeric(input$dims))
                rownames(matrix) <- c()
            }
            matrix
        }
    })
  
})
