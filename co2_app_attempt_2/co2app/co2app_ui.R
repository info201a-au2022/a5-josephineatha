library(shiny)
library(dplyr)
library(plotly)


intro_panel <- tabPanel(
  titlePanel("Introduction"),
  sidebarLayout(
    sidebarPanel(
      h3("Visualization Options"),
      h4("- CO2 Emissions or CO2 Emissions per Capita"),
      h4("- Choice of Country")
    ),
    mainPanel(
      h1("Introduction"),
      p("This app explores CO2 production worldwide over the last 20 years. Specifically, the app will allow users to see the distribution of 
    total CO2 gas emissions across countries in a given year in the past two decades, as well as the CO2 emissions per capita.",
        textOutput("mean_gasco2_2021"),
        textOutput("diff_gasco2_20years"), 
        textOutput("highest_2021_per_capita"))
    )
  )
)

interactive_panel <- tabPanel(
  titlePanel("CO2 Emissions Around the World"),
  sidebarLayout(
    sidebarPanel(
      selectInput("country_choice",
                  "Choose a country",
                  choices = unique(co2_data$country),
                  selected = "Afghanistan"
      ),
      selectInput("data_choice",
                  "Choose data to visualize",
                  choices = c("gas_co2", "gas_co2_per_capita"),
                  selected = "gas_co2"
      )
    ),
    mainPanel(
      plotlyOutput("linePlotly")
    )
  )
)

ui <- navbarPage(
  "CO2 Emissions Around the World",
  intro_panel,
  interactive_panel
)
