library(shiny)

booking <- read.table("../data/booking_table2_01Aug.csv", sep = ",", nrows = -1,
                      header = TRUE)
booking$activity_date <- as.Date(booking$activity_date)
booking$booking_date <- as.Date(booking$booking_date)

server <- function(input, output){
  
  output$variables <- renderUI({
    variables <- names(booking)
    selectInput("var", "Choose Column", variables, selected = "agent_country")
  })
  
  
  output$plot1 <- renderPlot({
    #Histogram
    barData <- table(booking$agent_country)
    barData <- as.data.frame(barData)
    
    # top_n
    if(input$showTop == "Top_n"){
      index <- order(barData$Freq, decreasing = TRUE)
      barData <- barData[index, ]
      top_n <- input$n
      barplot(barData$Freq[1:top_n], names.arg = barData$Var1[1:top_n],
              col = "green")
    }
    
    # bottom_n
    if(input$showTop == "Bottom_n"){
      index <- order(barData$Freq, decreasing = FALSE)
      barData <- barData[index, ]
      bottom_n <- input$n
      barplot(barData$Freq[1:bottom_n], names.arg = barData$Var1[1:bottom_n],
              col = "red")
    }
    
    
  })
  
}