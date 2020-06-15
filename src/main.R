# Main script for the analysis of the BRÉF database.
# 
# TraMineR doc: 
#	http://mephisto.unige.ch/pub/TraMineR/doc/TraMineR-Users-Guide.pdf
#
# Vincent Labatut
# 06/2020
###############################################################################
source("src/include.R")




# read data
data <- read.cached.table(cache.file)


	