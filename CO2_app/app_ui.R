ui <- fluidPage(
  
  # Application title
  titlePanel("CO2 Emission Trends Around the World"),
  
  intro_panel <- mainPanel(
    h1("Introduction"),
    p("This app explores CO2 production worldwide over the last 20 years. Specifically, the app will allow users to see the distribution of 
      total CO2 gas emissions across countries in a given year in the past two decades, as well as the C02 emissions per capita.",
      textOutput("mean_gasco2_2021"),
      textOutput("diff_gasco2_20years"), 
      textOutput("highest_2021_per_capita"))
      
    )
  
  )
  
  
  
  
  
  
  
  
  
  
  # Sidebar with a slider input for number of bins 
  
#   sidebarLayout(
#     sidebarPanel(
#       sliderInput("bins",
#                   "Number of bins:",
#                   min = 1,
#                   max = 50,
#                   value = 30)
#     ),
#     
#     # Show a plot of the generated distribution
#     mainPanel(
#       plotOutput("distPlot")
#     )
#   )
