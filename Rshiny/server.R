library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # create data to be shared by two output
  
  data <- reactive({
    n <- input$slider
    
    data <- switch(input$select,
                   "1" = rnorm(n),
                   "2" = rlnorm(n),
                   "3" = rexp(n)
    )
  })
  
  output$histPlot <- renderPlot({
    n <- input$slider
    # draw the histogram with the specified number of bins
    hist(data(), col = 'steelblue', border = 'white', breaks = 20, freq = FALSE,
         main = paste0("Histogram of ", n, " simulated random variable"), xlab = NA)
  })
  
  output$summary <- renderPrint({
    print(summary(data()))
  })
})