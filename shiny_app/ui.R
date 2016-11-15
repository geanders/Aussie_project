shinyUI(fluidPage(
  titlePanel("Australia's Ranger Uranium Mine: Measuring Heavy Metals and Radionuclide 
             Presence in the Surrouding Environment"),
  sidebarLayout(
    sidebarPanel(width = 5,
                h4("Where do we see metals and radionuclides?"),
                 img(src = "Ranger2005.jpg", height = 100, width = 250),
                 h6("Image of the Ranger Treatment plant, with mine
                   pit beyond (source www.world-nuclear.org)"),
                br(),
                checkboxGroupInput("Substrate",
                                  label = h4("Substrate"),
                choices = list("Terrestrial Animals" = "Choice 1", 
                               "Terrestrial Plants" = "Choice 2",
                               "Terrestrial soil" = "Choice 3",
                               "Freshwater Animals" = "Choice 4",
                              "Fish" = "Choice 5",
                               "Mollusc" = "Choice 6",
                               "Freshwater Sediment" = "Choice 7",
                              "Freshwater Plant" = "Choice 8",
                               "Water" = "Choice 9"),
                select = 1)),
    mainPanel("Map of Alligator Rivers Area"
              #plotOutput())
  ))
))
