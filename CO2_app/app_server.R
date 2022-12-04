library(dplyr)

co2_data <- data.frame(read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv"))


server <- function(input, output) {
  
  # finding average production-based CO2 production in 2021
  data_2021 <- data.frame(co2_data %>%
                            filter(year == max(year)))

  output$mean_gasco2_2021 <- renderText({
    paste0("In preliminary
      research, it was found that in 2021, the average amount of production-based CO2 produced across countries was ",toString(
        format(round(mean(data_2021$gas_co2, na.rm = TRUE), 2), nsmall = 2)
      ) ," tons.")
  })

  # finding difference in average production-based CO2 production from 2001 to 2021
  data_2001 <- data.frame(co2_data %>%
                            filter(year == 2001))

  mean_gasco2_2021 <- mean(data_2021$gas_co2, na.rm = TRUE)
  mean_gasco2_2001 <- mean(data_2001$gas_co2, na.rm = TRUE)

  output$diff_gasco2_20years <- renderText({
    paste0("Over the course of 20 years, this number changed by ",toString(
      format(round(mean_gasco2_2021 - mean_gasco2_2001, 2), nsmall = 2)
    ),
    " tons.")
  })

  
  # finding where production based CO2 production per capita was highest in 2021
  output$highest_2021_per_capita <- renderText({
    paste0("Also, in 2021, the country with the highest amount of 
      CO2 per capita was ",
           toString(data_2021 %>% 
                      filter(gas_co2_per_capita == max(gas_co2_per_capita, na.rm = TRUE)) %>% 
                      select(country)),
           "."
           )
    
  })
}
  

  # output$distPlot <- renderPlot({
  #   # generate bins based on input$bins from ui.R
  #   x    <- faithful[, 2]
  #   bins <- seq(min(x), max(x), length.out = input$bins + 1)
  #   
  #   # draw the histogram with the specified number of bins
  #   hist(x, breaks = bins, col = 'darkgray', border = 'white',
  #        xlab = 'Waiting time to next eruption (in mins)',
  #        main = 'Histogram of waiting times')
#   })
# }

