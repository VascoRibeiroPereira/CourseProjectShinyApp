#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # make a df with the selected Direction
        if (input$Direção == "Both") {
            x <- myData
        }else{
        x    <- filter(myData, Direção == input$Direção)
        }
        
        print(mean(x$Velocidade))
        
        # draw the plot with mean calculation
        ggplot(myData, aes(Data, Velocidade, color = Direção)) + 
            geom_point() +
            geom_hline(yintercept = mean(x$Velocidade)) +
            annotate("text", x = as.POSIXct("2020-08-05"), 
                     y = mean(x$Velocidade)+3, 
                     label = paste(round(mean(x$Velocidade)), 
                                   "Km/h", sep = " "))

    })

})
