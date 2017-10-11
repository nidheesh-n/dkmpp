# Author : Nidheesh N. (nidheesh.n@gmail.com)
# Test Program
##############################################################################################
rm(list = ls())
require(clues)    # For ARI computation

source('dkmpp.R')

##############################################################################################
# Read in the dataset. Set the number of clusters/ subtypes
##############################################################################################
mydata = read.table("LEU.csv", sep = ",") # "file.csv" with samples along rows and genes along columns. Last column may have true class information. 
                                          # Class labels are numbers 1,2,3, ...
                                          # No missing values (NAs) expected.

k = 3                                     # The number of clusters/ subtypes

classinfoav = TRUE    # TRUE if the true class information is available as the last column.

n = nrow(mydata)
lcol = ncol(mydata)

##############################################################################################
# Removing class information from the data
##############################################################################################
if(classinfoav){
  act.class = mydata[, lcol]
  mydata = mydata[, -lcol]
  lcol = lcol - 1
}

##############################################################################################
# min-max normalization of the data
##############################################################################################
minmy = apply(mydata, 2, min)
maxmy = apply(mydata, 2, max)
denommy = maxmy - minmy
if(!any(denommy == 0)){
  mydata = sweep(mydata,2,minmy,FUN = "-")
  mydata = sweep(mydata,2,denommy,FUN = "/")
}

##############################################################################################
# Calling DKM++
##############################################################################################
t1 = Sys.time()
res = dkmplusplus(mydata, k)  # Call to DKM++
t2 = Sys.time()
clusters = res$cluster

##############################################################################################
# Performance analysis (ARI)
##############################################################################################
if(classinfoav){
  result = data.frame(act.class, clusters)
  write.csv(result, "result.csv")
  cat("Contingency table\n")
  print(table(act.class, clusters))
  temp = adjustedRand(act.class, clusters)
  cat("\nARI = ", round(temp[2],3))
}
if(!classinfoav)
{
  cat("\nClustering vector : ", clusters)
}
cat("\n# kmeans iterations = ", res$iter)
cat("\n")
print(t2 - t1)
