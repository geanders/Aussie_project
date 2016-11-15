shinyUI(fluidPage(
  titlePanel("Australia's Ranger Uranium Mine: Measuring Heavy Metals and Radionuclide 
             Presence in the Surrouding Environment"),
           fluidRow(
             column(6,
                  h4("Where do we see metals and radionuclides?"),
                  img(src = "Ranger2005.jpg", height = 100, width = 300),
                  h6("Image of Ranger Treatment plant, with mine
                       pit (source www.world-nuclear.org)"),
                    fluidRow(
                      column(4, checkboxGroupInput("Substrate",
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
                      column(4, sliderInput("slider1", label = h3("Year of Sampling"),
                            min = 1976, max = 2015, value = 1)),
                      column(4, checkboxGroupInput("Substrate",
                                label = h4("Substrate"),
                                choices = list("Cu" = "Choice 1", 
                                              "As" = "Choice 2",
                                              "Hg" = "Choice 3",
                                              "Pb" = "Choice 4",
                                              "Radionuclides" = "Choice 5"),
                                select = 1)
                            )))),
             fluidRow(
               column(6,
                    "Map of Alligator Rivers Sample Sites"))
                    
           )
    )


  #sidebarLayout(
   # sidebarPanel(width = 5,
    #            h4("Where do we see metals and radionuclides?"),
     #            img(src = "Ranger2005.jpg", height = 100, width = 250),
      #           h6("Image of the Ranger Treatment plant, with mine
       #            pit beyond (source www.world-nuclear.org)"),
        #        br(),
         #       checkboxGroupInput("Substrate",
          #                        label = h4("Substrate"),
           #     choices = list("Terrestrial Animals" = "Choice 1", 
            #                   "Terrestrial Plants" = "Choice 2",
             #                  "Terrestrial soil" = "Choice 3",
                 #              "Freshwater Animals" = "Choice 4",
                  #            "Fish" = "Choice 5",
                   #            "Mollusc" = "Choice 6",
                    #           "Freshwater Sediment" = "Choice 7",
                     #         "Freshwater Plant" = "Choice 8",
                      #         "Water" = "Choice 9"),
                #select = 1)),
   # mainPanel("Map of Alligator Rivers Area"
              #plotOutput())
#  ))
#))
