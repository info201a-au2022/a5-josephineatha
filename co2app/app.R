#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(plotly)
library(rsconnect)

# define ui and server
source("co2app_server.R")
source("co2app_ui.R")


# Run the application 
shinyApp(ui = ui, server = server)

rsconnect::setAccountInfo(name='josephineatha', 
                          token='1D2A4FBDA98E1322F653BA05A2623A9B', 
                          secret='7B7hqrTftV3QfCN1ED1apykz8LScClpHzAhKkzy1')