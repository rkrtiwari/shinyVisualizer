source("myfunctions.R")
library(shiny)

plotHistUI <- function(id){
  ns <- NS(id)
  tagList(
    selectInput(ns("breaks"), "no of break points", choices = seq(2,15), selected = 5),
    textOutput(ns("text1")),
    uiOutput(ns("ui1")),
    uiOutput(ns("ui2")),
    plotOutput(ns("plot1"))
  )
}

plotHist <- function(input, output, session, data){
  ns <- session$ns
  
  output$ui1 <- renderUI({
    selectInput(ns("xvar"), label = "choose x variable", choices = names(mtcars),
                selected = "wt")
  })
  
  output$ui2 <- renderUI({
    selectInput(ns("yvar"), label = "choose y variable", choices = names(mtcars),
                selected = "wt")
  })
  
  output$text1 <- renderText({
    paste("You chose:", input$xvar, "and", input$yvar) 
  })
  
 output$plot1 <- renderPlot({
   plot(data[,input$xvar], data[,input$yvar], col = "red")
 })
}


ui <- fluidPage(
  plotHistUI("first")
)

server <- function(input, output, session) {
  data <- mtcars[1:5,]
  callModule(plotHist, "first", data)
}

# Run the application 
shinyApp(ui = ui, server = server)



