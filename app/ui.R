library(shiny)

ui <- fluidPage( 
  
  sidebarLayout(
    sidebarPanel(
      uiOutput("ui1")
    ),
    
    mainPanel(
      plotOutput("plot1"),
      fluidRow(4, selectInput("topBottom", "Top or Bottom Values", 
                              choices = c("Top", "Bottom"), selected = "Top" )),
      fluidRow(4, selectInput("n", "how many to show", 
                              choices = seq(1,10), selected = 5))
      
   )
  
))