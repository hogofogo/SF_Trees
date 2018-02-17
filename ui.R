
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("This graph evaluates distribution of top 5 species of trees in San Francisco"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("SliderWeight",
                  "Slide to choose the tree species",
                  min = 1,
                  max = 5,
                  value = 1),

      
      h3("Instructions"),
      h5("The graph will be redrawn for a new species chosen")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
    
      #h4(textOutput("pred2")),
      
      plotOutput("Plot1")

      
    )
  )
))
