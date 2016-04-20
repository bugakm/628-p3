library(shiny)
library(readr)
library(ggplot2)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # create data to be shared by two output
  datapath <- file.path("https://raw.githubusercontent.com",
                        "rqtl/qtl2data/master/B6BTBR")
  pheno <- read_csv(file.path(datapath, "b6btbr_pheno.csv"), comment="#")
  covar <- read_csv(file.path(datapath, "b6btbr_covar.csv"), comment="#")
  pheno <- left_join(pheno, covar[, 1:2], by = "MouseNum")
  
  f=function(k){
    a=geno[,which(pmap$chr==k)]
    b=matrix(0,dim(a)[2]-1,dim(a)[1])
    for (i in 1:(dim(a)[2]-1)){
      for(j in 1:dim(a)[1]){
        b[i,j]=as.character(a[j,i+1])
      }
    }
    b[b=="RR"]=1
    b[b=="BR"]=2
    b[b=="BB"]=3
    b[is.na(b)]=0
    b=as.numeric(b)
    d=matrix(b,(dim(a)[2]-1),dim(a)[1])
    heatmap(d,Rowv=NA, Colv=NA,scale = 'column')
  }
  
  chr <- reactive({
    # n <- input$slider
    
    chr <- switch(input$select,
                  "1" = 1, "2" = 2,
                  "3" = 3, "4" = 4,
                  "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9,
                  "10" = 10, "11" = 11,"12" = 12, "13" = 13, "14" = 14,
                  "15" = 15, "16" = 16, "17" = 17, "18" = 18, "19" = 19
    )
  })
  
  sex <- reactive({
    sex <- switch(input$selectSex,
                  "1" = "All", "2" = "Male", "3" = "Female")
  })
  
  output$plot <- renderPlot({
    if (sex() == "All") {
      ggplot(pheno, aes(log10_insulin_10wk)) + geom_histogram() +
        facet_grid(Sex~.)
    } else if (sex() == "Male") {
      pheno %>% filter(Sex == "Male") %>% 
        ggplot(aes(log10_insulin_10wk)) + geom_histogram()  
    } else if (sex() == "Female") {
      pheno %>% filter(Sex == "Female") %>% 
        ggplot(aes(log10_insulin_10wk)) + geom_histogram()  
    }
    
  })
  
  output$summary <- renderPrint({
    print(paste("This is to select chromosome", chr()))
  })
  
  output$heat <- renderPlot({
    f(chr())
  })
})