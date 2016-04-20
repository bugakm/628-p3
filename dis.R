##chrome
dis=function(chromesome=1){
  x=(table(pmap$chr))
  m=matrix(,nrow=544,ncol=544)
  pmap <- pmap[complete.cases(pmap), ]
  for(i in 1:544){
    for(j in 1:544){
      mkr=pmap$marker[pmap$chr==chromesome]
      mouse_i <- geno[i, mkr]
      mouse_j <- geno[j, mkr]
      m[i, j] <- sum(mouse_i != mouse_j, na.rm = TRUE) / sum( !(is.na(mouse_i)) &   !is.na(mouse_j))
    }
  }
  return(m)
}

is.na(pmap$chr)
