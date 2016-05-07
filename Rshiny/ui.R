library(shiny)

# Define UI for application
shinyUI(fluidPage(
  # Application title
  titlePanel(p("Systems Genetics",
              h4("by Chenxi, Chen and Zhuangye"))),
  
  sidebarLayout( #position = "right",
    sidebarPanel(#"sider panel",
      selectInput("select", label = h4("Select a chromosome"), 
                  choices = list("1" = 1, "2" = 2,
                                 "3" = 3, "4" = 4,
                  "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9,
                  "10" = 10, "11" = 11,"12" = 12, "13" = 13, "14" = 14,
                  "15" = 15, "16" = 16, "17" = 17, "18" = 18, "19" = 19),
                  selected = 1),
#       selectInput("selectSex", label = h5("Select the Sex"), 
#                   choices = list("All" = 1, "Male" = 2,
#                                  "Female" = 3),
#                   selected = 1)
      radioButtons("radio", label = h4("Choose a p-value"),
                   choices = list("0.05" = 1, "0.01" = 2,
                                  "0.005" = 3, "0.001" = 4),selected = 1)
      
#       sliderInput("slider", label = h5("Sample size"),
#                   min = 1, max = 1000, value = 500)
    ),
    
    mainPanel(#"main panel",
      tabsetPanel(
        tabPanel("P-value plot from ANOVA", plotOutput("plot")), 
        # tabPanel("test", verbatimTextOutput("summary")), 
        tabPanel("Heat Map", plotOutput("heat"))
      )  
    )
    
  )
))