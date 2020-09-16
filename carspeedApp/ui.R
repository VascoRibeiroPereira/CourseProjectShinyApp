#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(lubridate)


myData <- read.csv("cleanData.csv", 
                   colClasses = c("factor", "POSIXct", "factor", "numeric"))

myData <- as_tibble(myData)[,-1]


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Car Speed Data"),

    # Sidebar with a radio Button
    sidebarLayout(
        sidebarPanel(
            p("Select the data to calculate the mean Speed"),
            br(),
            radioButtons("Direção", label = NULL, 
                               choices = c("Sintra-MemMartins", 
                                           "MemMartins-Sintra", "Both"),
                               selected = "Both")
        ),

        # Show a plot
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
