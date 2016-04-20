##chrome
dis <- function(chromesome = 1, num_mouse = 544){
  m <- matrix(numeric(num_mouse * num_mouse),nrow = num_mouse, ncol = num_mouse)
  pmap <- pmap[complete.cases(pmap), ]
  
  for(i in 1:num_mouse){
    for(j in 1:num_mouse){
      
      mkr <- pmap$marker[pmap$chr==chromesome]
      mouse_i <- geno[i, mkr]
      mouse_j <- geno[j, mkr]
      m[i, j] <- sum(mouse_i != mouse_j, na.rm = TRUE) / sum(!(is.na(mouse_i)) & !is.na(mouse_j))
    }
  }
  return(m)
}

