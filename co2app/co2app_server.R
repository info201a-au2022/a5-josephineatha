library(shiny)
library(dplyr)
library(plotly)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
  
  # finding average production-based CO2 production in 2021
  data_2021 <- data.frame(co2_data %>%
                            filter(year == max(year)))
  
  output$mean_gasco2_2021 <- renderText({
    paste0("In preliminary
      research, it was found that in 2021, the average amount of production-based CO2 produced across countries was ",toString(
        format(round(mean(data_2021$gas_co2, na.rm = TRUE), 2), nsmall = 2)
      ) ," million tons.")
  })
  
  # finding difference in average production-based CO2 production from 2001 to 2021
  data_2001 <- data.frame(co2_data %>%
                            filter(year == 2001))
  
  mean_gasco2_2021 <- mean(data_2021$gas_co2, na.rm = TRUE)
  mean_gasco2_2001 <- mean(data_2001$gas_co2, na.rm = TRUE)
  
  output$diff_gasco2_20years <- renderText({
    paste0("Over the course of 20 years, this number increased by ",toString(
      format(round(mean_gasco2_2021 - mean_gasco2_2001, 2), nsmall = 2)
    ),
    " million tons.")
  })
  
  
  # finding where production based CO2 production per capita was highest in 2021
  output$highest_2021_per_capita <- renderText({
    paste0("Also, in 2021, the country with the highest amount of 
      CO2 produced per capita was ",
           toString(data_2021 %>% 
                      filter(gas_co2_per_capita == max(gas_co2_per_capita, na.rm = TRUE)) %>% 
                      select(country)),
           "."
    )  })
  
  output$linePlotly <- renderPlotly({
    if(input$data_choice %in% "gas_co2"){
      plot_ly(
        data = data.frame(
          co2_data %>% 
            filter(year >= 2001) %>% 
            filter(year <= 2021) %>% 
            filter(country %in% input$country_choice) %>% 
            select(year, country, gas_co2)
        ),
        x = ~year,
        y = ~gas_co2,
        type = "scatter",
        mode = "lines+markers"
      )%>% 
        layout(
          title = paste0("CO2 Gas Emissions since 2001 in ",input$country_choice),
          xaxis = list(title = "Year"),
          yaxis = list(title = "CO2 Gas Emissions (millions of tons)")
        )
    }else{
      plot_ly(
      data = data.frame(
        co2_data %>% 
          filter(year >= 2001) %>% 
          filter(year <= 2021) %>% 
          filter(country %in% input$country_choice) %>% 
          select(year, country, gas_co2_per_capita)
      ),
      x = ~year,
      y = ~gas_co2_per_capita,
      type = "scatter",
      mode = "lines+markers"
    )%>% 
        layout(
          title = paste0("CO2 Gas Emissions per Capita since 2001 in ",input$country_choice),
          xaxis = list(title = "Year"),
          yaxis = list(title = "CO2 Gas Emissions Per Capita (tons per person)")
        )
    }
  })
}


