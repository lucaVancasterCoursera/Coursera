#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Classical magic square"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
      sidebarPanel(textInput("dims", "Enter square dimension (3-20):",value = 3)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        h5('This little widget caluclates a magic square for a given dimension.'),
        uiOutput("matrix")
       
    )
  )
))
