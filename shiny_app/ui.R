shinyUI(fluidPage(
  titlePanel("Concentrations of Heavy Metals and Radionuclides near Australia's
             Ranger Mine"),
  sidebarLayout(
    sidebarPanel(h2("Display on Map"),
                 br(),
                 img(src = "Ranger200.jpg", height = 72, width = 72),
                 p("World Nuclear image of the Ranger Treatment plant, with mine
                   pit beyond")
                 
    sliderInput(inputID = "Substrate",
                label = "Select a Substrate",
                value = dataframe$substrate_name),
    mainPanel("Map of Sample Locations",
              plotOutput("aussie_map"))
  ))
)