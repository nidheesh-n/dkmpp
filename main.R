# Author : Nidheesh N. (nidheesh.n@gmail.com)
# Program to test the proposed algorithm
##############################################################################################
rm(list = ls())
require(clues)    # For ARI computation
require(dkmpp)    # Package for the proposed Density K-Means++

##############################################################################################
# Read in the dataset. Set the number of clusters/ subtypes
##############################################################################################
mydata <- read.table("LEU.csv", sep = ",") # "file.csv" with samples along rows and genes/probes along
                                           # columns. Last column may have true class information.
                                           # Class labels (if available) must be numbers 1,2,3, ...
                                           # No column or row headers expected.
                                           # No missing values (NAs) expected.
##############################################################################################
# Set the number of clusters/ subtypes here
##############################################################################################
k <- 3                                     # The number of clusters/ subtypes

classinfoav <- TRUE    # TRUE if the true class information is available as the last column.
n <- nrow(mydata)
lcol <- ncol(mydata)

##############################################################################################
# Separating class information (if present) from the data
##############################################################################################
if(classinfoav){
  act_class <- mydata[, lcol]
  mydata <- mydata[, -lcol]
}

##############################################################################################
# Column-wise min-max normalization of the data
##############################################################################################
mydata <- minmaxnorm(mydata)

##############################################################################################
# Calling DKM++
##############################################################################################
clusters <- dkmpp(mydata, k)  # Call to DKM++

##############################################################################################
# Results and performance analysis (ARI)
##############################################################################################
if(classinfoav){
  result <- data.frame(act_class, clusters)
  write.csv(result, "result.csv")
  cat("Results saved to \"result.csv\".\nContingency table: \n")
  print(table(act_class, clusters))
  temp <- adjustedRand(act_class, clusters)
  cat("\nARI = ", round(temp[2],3), "\n")
} else {
  cat("\nClustering vector: \n", clusters, "\n")
}
