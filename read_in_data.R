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
