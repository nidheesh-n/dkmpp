# dkmpp
The inlcuded R package (dkmpp_0.1.0.tar.gz) contains an implementation of ‘Density K-Means++’ algorithm [1] -  a density based deterministic variant of the K-Means clustering algorithm. 

The algorithm systematically finds out a set of inital centroids which belong to dense regions in feature space and which are adequately separated. 

Being a deterministic variant of the K-Means, each run of the algorithm for a dataset results in the same clustering.

The included ‘Main.R’ program can be used to test the algorithm. An example case where the algorithm can be used is in clustering cancer gene expression data. When using gene expression data matrix as the input, the algorithm expects samples as rows and genes/ probes as columns. No missing values (NA) expected.

A sample test dataset (LEU.csv) has been provided, which is a processed version of the Leukemia dataset used in the work of Monti et al. [2]. The original dataset can be had from http://portals.broadinstitute.org/cgi-bin/cancer/datasets.cgi. The last column of the file contains the true class information as numbers 1,2 and 3.

References:

[1] N. Nidheesh, K.A. Abdul Nazeer, P.M. Ameer, An enhanced deterministic K-Means clustering algorithm for cancer subtype prediction from gene expression data, Computers in Biology and Medicine 91C (2017) pp. 213-221.
https://doi.org/10.1016/j.compbiomed.2017.10.014

[2]  S. Monti, P. Tamayo, J. Mesirov, T. Golub, Consensus clustering: A resampling-based method for class discovery and visualization of gene expression microarray data, Machine Learning 52 (1) (2003) 91–118. doi:10.1023/A:1023949509487.
