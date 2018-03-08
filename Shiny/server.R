
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(maptools)
library(ggplot2)
library(ggmap)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
trees_to_map <- read.csv('trees_to_map.csv')
top_6 <- read.csv('top_6.csv')

neighb <- readShapePoly("SF_neighborhoods")
bbox <- neighb@bbox

sf_bbox <- c(left = bbox[1, 1] - .01, bottom = bbox[2, 1] - .005, 
             right = bbox[1, 2] + .01, top = bbox[2, 2] + .005)

basemap <- get_stamenmap(
  bbox = sf_bbox,
  zoom = 13,
  maptype = "toner-lite")

  
  output$Plot1 <- renderPlot({
    wtInput <- input$SliderWeight
    
    library(ggplot2)
    library(ggmap)
    contours <- stat_density2d(
      aes(x = longitude, y = latitude, fill = ..level.., alpha=..level..),
      size = 0.1, data = trees_to_map[trees_to_map[ ,'species'] == top_6[wtInput,'Var1'], ], n=200,
      geom = "polygon")
    
    map_title <- as.character(top_6[input$SliderWeight,'Var1'])
    
    ggmap(basemap, extent='device', legend="topleft") + contours +
      scale_alpha_continuous(range=c(0.25,0.4), guide='none') + scale_fill_gradient(low = "azure3", high = "darkblue", limits=c(0, 800)) +
      ggtitle(map_title) 
  })
  
  
  
  
  
  #output$pred2 <- renderText({paste("Predicted interval from ", {as.character(top_5[input$SliderWeight,1])})
  #output$pred1 <- renderText({paste("Predicted MPG", {round(model1pred(),2)})})
})
