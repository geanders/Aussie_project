library(shiny)
# from another script file can execute the shiny app by using the runApp 
# command on the directory name. Example from within our project:
# runApp("shiny_app")
load() # will need to put dataframe to use here- 
source() # or refer to mapping function script etc
shinyServer(function(input, output) {
  output$aussie_map <- renderPlot({ plot_map()})
  
})
