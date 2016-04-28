library(shiny)
library(readr)
library(ggplot2)
library(dplyr)
library(reshape2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # create data to be shared by two output
  datapath <- file.path("https://raw.githubusercontent.com",
                        "rqtl/qtl2data/master/B6BTBR")
  pheno <- read_csv(file.path(datapath, "b6btbr_pheno.csv"), comment="#")
  covar <- read_csv(file.path(datapath, "b6btbr_covar.csv"), comment="#")
  #pheno <- left_join(pheno, covar[, 1:2], by = "MouseNum")
  
  geno <- read_csv(file.path(datapath, "b6btbr_geno.csv"), comment="#", 
                   na=c("","NA","-"))
  pmap <- read_csv(file.path(datapath, "b6btbr_pmap.csv"), comment="#",
                   col_types=list(col_character(),
                                  col_character(),
                                  col_double()))
  
  y=pheno[,2]
  y=y$log10_insulin_10wk
  p=numeric(2057)
  
  for(i in 1:2057){
    g_temp <- unlist(geno[, (i+1)])
    g=aov(y ~ g_temp)
    p[i]=unlist(summary(g))[9]
  }
  pmap$P=p
  
  pv <- function(b=0.05) {
    k=sum(p<b)
    d=c(157,292,449,575,700,802,911,1002,1095,1218,1342,1458,1574,1665,1767,1833,1893,1988)
    ggplot(pmap,aes(marker,P)) + geom_point() + 
      geom_hline(yintercept=b, color='red') + 
      geom_vline(xintercept=d,linetype='dashed') +
      ggtitle(paste(k, "markers have p-vales less than", b))
  }
  
  # function for heat map
  chr_heatmap <- function(chr_num) {
    # choose the marker of this chr
    mk <- pmap[pmap$chr == chr_num, 'marker']
    ind <- names(geno) %in% mk$marker
    ind[1] <- TRUE
    mouse_geno <- geno[, ind]
    mouse_geno <- melt(mouse_geno, id = "MouseNum")
    ggplot(mouse_geno, aes(MouseNum, variable)) + geom_tile(aes(fill = value)) +
      scale_x_discrete("Mouse", labels = NULL) +
      scale_y_discrete("Marker", labels = NULL) +
      scale_fill_manual(values = c("black", "grey", "red"), name = "type") +
      ggtitle(paste(sum(ind)-1, "markers in chromosome", chr_num))
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
  
  pval <- reactive({
    pval <- switch(input$radio,
                  "1" = 0.05, "2" = 0.01, 
                  "3" = 0.005, "4" = 0.001)
  })
  
  output$plot <- renderPlot({
    pv(b=pval())
  })
  
#   output$summary <- renderPrint({
#     print(paste("This is to select chromosome", chr()))
#   })
  
  output$heat <- renderPlot({
    chr_heatmap(chr())
  })
})