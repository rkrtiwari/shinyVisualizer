library(shiny)

ui <- fluidPage( 
  
  sidebarLayout(
    sidebarPanel(
      uiOutput("variables"),
      selectInput("showTop", "Show Top_n or Bottom_n?", c("Top_n", "Bottom_n"), 
                  selected = "Top_n"),
      selectInput("n", "n", 1:12, selected = 5)
    ),
    
    mainPanel(
      plotOutput("plot1")
   )
  
))