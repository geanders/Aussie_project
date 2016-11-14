shinyUI(fluidPage(
  titlePanel("Concentrations of Heavy Metals and Radionuclides near Australia's
             Ranger Mine")
  sidebarLayout(
    sidebarPanel(h2("Display on Map"),
                 br(),
                 img(src = "Ranger200.jpg", height = 72, width = 72),
                 p("World Nuclear image of the Ranger Treatment plant, with mine
                   pit beyond")
                checkboxGroupInput(inputID = "Substrate",
                label = h3("Select a Substrate"),
                choices = list("Choice 1" = Terrestrial_animals, 
                               "Choice 2" = Terrestrial_plants,
                               "Choice 3" = Terrestrial_soil,
                               "Choice 4" = Freshwater_animals,
                               "Choice 5" = Fish,
                               "Choice 6" = Mollusc,
                               "Choice 7" = Freshwater_sediment,
                               "Choice 8" = Freshwater_vascularplant,
                               "Choice 9" = Water),
                value = dataframe$substrate_name),
    mainPanel("Map of Sample Locations",
              plotOutput("aussie_map"))
  ))
)