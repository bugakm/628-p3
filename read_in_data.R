library(readr)

datapath <- file.path("https://raw.githubusercontent.com",
                      "rqtl/qtl2data/master/B6BTBR")
geno <- read_csv(file.path(datapath, "b6btbr_geno.csv"), comment="#", 
                 na=c("","NA","-"))
pmap <- read_csv(file.path(datapath, "b6btbr_pmap.csv"), comment="#",
                 col_types=list(col_character(),
                                col_character(),
                                col_double()))
pheno <- read_csv(file.path(datapath, "b6btbr_pheno.csv"), comment="#")
covar <- read_csv(file.path(datapath, "b6btbr_covar.csv"), comment="#")

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
    ggtitle(paste0(sum(ind)-1, "markers in chromosome", chr_num))
}





