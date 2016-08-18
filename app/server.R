source("myfunctions.R")
library(shiny)

booking <- read.table("../data/booking_table2_01Aug.csv", sep = ",", nrows = -1,
                      header = TRUE)
booking$activity_date <- as.Date(booking$activity_date)
booking$booking_date <- as.Date(booking$booking_date)

server <- function(input, output){
  
  output$ui1 <- renderUI({
    variables <- names(booking)
    selectInput("var", "Choose Column", variables, selected = "adult")
  })
  
  output$plot1 <- renderPlot({
    if(input$var %in% c("adult", "child", "infant", "booking_amount"))
      {
        hist(booking[,input$var], xlab = input$var, main = "") 
    } else {
        barData <- table(booking[, input$var])
        barData <- data.frame(barData) 
#        barplot(barData$Freq, names.arg = barData$Var1)
        if(input$topBottom == "Top") {
          index <- order(barData$Freq, decreasing = TRUE)
          barData <- barData[index, ]
          top_n <- input$n
          barplot(barData$Freq[1:top_n], names.arg = barData$Var1[1:top_n],
                  col = "green")
        }
        
        # Bottom n
        
        if(input$topBottom == "Bottom"){
          index <- order(barData$Freq, decreasing = FALSE)
          barData <- barData[index, ]
          bottom_n <- input$n
          barplot(barData$Freq[1:bottom_n], names.arg = barData$Var1[1:bottom_n],
                  col = "red")
        }

            
    }
  })
  
}
    

#   
#   var1 <- reactive({input$var})
#   
#   if(var1() %in% c("adult", "child", "infant", "booking_amount")){
#     
#     })
#   }
#   
#   
#   output$plot1 <- renderPlot({
#     #Histogram
#     barData <- table(booking$agent_country)
#     barData <- as.data.frame(barData)
#     
#     # top_n
#     if(input$showTop == "Top_n"){
#       index <- order(barData$Freq, decreasing = TRUE)
#       barData <- barData[index, ]
#       top_n <- input$n
#       barplot(barData$Freq[1:top_n], names.arg = barData$Var1[1:top_n],
#               col = "green")
#     }
#     
#     # bottom_n
#     if(input$showTop == "Bottom_n"){
#       index <- order(barData$Freq, decreasing = FALSE)
#       barData <- barData[index, ]
#       bottom_n <- input$n
#       barplot(barData$Freq[1:bottom_n], names.arg = barData$Var1[1:bottom_n],
#               col = "red")
#     }
#     