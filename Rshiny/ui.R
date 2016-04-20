library(shiny)

# Define UI for application
shinyUI(fluidPage(
  # Application title
  titlePanel(p("First Shiny App",
              h4("by Zhuangye"))),
  
  sidebarLayout( #position = "right",
    sidebarPanel(#"sider panel",
      selectInput("select", label = h5("Select a distribution to simulate"), 
                  choices = list("Normal" = 1, "Log-normal" = 2,
                                 "Exponential" = 3), selected = 1),
      
      sliderInput("slider", label = h5("Sample size"),
                  min = 1, max = 1000, value = 500)
    ),
    
    mainPanel(#"main panel",
      tabsetPanel(
        tabPanel("Plot", plotOutput("histPlot")), 
        tabPanel("Summary", verbatimTextOutput("summary"))
      )  
    )
    
  )
))