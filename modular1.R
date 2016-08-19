library(shiny)

booking <- read.table("data/booking_table2_01Aug.csv", sep = ",", nrows = 1000,
                      header = TRUE)
booking$activity_date <- as.Date(booking$activity_date)
booking$booking_date <- as.Date(booking$booking_date)

plotHistUI <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(ns("plot1")),
    selectInput(ns("breaks"), "no of break points", choices = seq(2,15), selected = 5),
    uiOutput(ns("xmax"))
  )
}

plotHist <- function(input, output, session){
  ns <- session$ns
  
  output$xmax <- renderUI({
    selectInput(ns("xlim"), "max x", choices = seq(0,1000), selected = max(booking[,"adult"]))
  })
  
  output$plot1 <- renderPlot({
    hist(booking[,"adult"], col = "red", breaks = as.numeric(input$breaks),
         xlim = c(0, as.numeric(input$xlim)))
  })
}


ui <- fluidPage(
  plotHistUI("first")
)

server <- function(input, output, session) {
  callModule(plotHist, "first")
}

# Run the application 
shinyApp(ui = ui, server = server)