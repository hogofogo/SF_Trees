
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  trees_to_map <- read.csv('./Temp/trees_to_map.csv')
  top_5 <- read.csv('./Temp/top_5.csv')
  

  
  output$Plot1 <- renderPlot({
    wtInput <- input$SliderWeight
    
    library(ggplot2)
    library(ggmap)
    contours <- stat_density2d(
      aes(x = longitude, y = latitude, fill = ..level.., alpha=..level..),
      size = 0.1, data = trees_to_map[trees_to_map[ ,'species'] == top_5[wtInput,'Var1'], ], n=200,
      geom = "polygon")
    
    map_title <- as.character(top_5[input$SliderWeight,'Var1'])
    
    ggmap(basemap, extent='device', legend="topleft") + contours +
      scale_alpha_continuous(range=c(0.25,0.4), guide='none') + scale_fill_gradient(low = "azure3", high = "darkblue") +
      ggtitle(map_title) 
  })
  
  
  
  
  
  #output$pred2 <- renderText({paste("Predicted interval from ", {as.character(top_5[input$SliderWeight,1])})
  #output$pred1 <- renderText({paste("Predicted MPG", {round(model1pred(),2)})})
})
