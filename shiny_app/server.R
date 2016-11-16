library(shiny)
# from another script file can execute the shiny app by using the runApp 
# command on the directory name. Example from within our:
# runApp("shiny_app")
# will need to put dataframe to use here- load()
# or refer to mapping function script etc- source() 
shinyServer(function(input, output) {
  output$aussie_map <- renderPlot({ plot_map()})
  
})
