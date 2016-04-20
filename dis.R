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