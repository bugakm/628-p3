library(shiny)

# Define UI for application
shinyUI(fluidPage(
  # Application title
  titlePanel(p("Systems Genetics",
              h4("by Jason, Dick, Michael"))),
  
  sidebarLayout( #position = "right",
    sidebarPanel(#"sider panel",
      selectInput("select", label = h5("Select a chromosome"), 
                  choices = list("1" = 1, "2" = 2,
                                 "3" = 3, "4" = 4,
                  "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9,
                  "10" = 10, "11" = 11,"12" = 12, "13" = 13, "14" = 14,
                  "15" = 15, "16" = 16, "17" = 17, "18" = 18, "19" = 19),
                  selected = 1),
      selectInput("selectSex", label = h5("Select the Sex"), 
                  choices = list("All" = 1, "Male" = 2,
                                 "Female" = 3),
                  selected = 1)
      
#       sliderInput("slider", label = h5("Sample size"),
#                   min = 1, max = 1000, value = 500)
    ),
    
    mainPanel(#"main panel",
      tabsetPanel(
        tabPanel("Plot of Insulin", plotOutput("plot")), 
        tabPanel("test", verbatimTextOutput("summary")), 
        tabPanel("Hierarchical Cluster", plotOutput("cluster"))
      )  
    )
    
  )
))