# Main script for the analysis of the BRÉF database.
# 
# TraMineR doc: 
#	http://mephisto.unige.ch/pub/TraMineR/doc/TraMineR-Users-Guide.pdf
#
# Vincent Labatut 06/2020
# source("src/main.R")
###############################################################################
source("src/common/include.R")


# start logging
start.rec.log(text=paste0("CACHE"))
tlog(0,"Start converting and caching the BRÉF data")

# read BRÉF table
data <- read.bref.table(input.file=FILE_DATA)
# convert to traminer object
sd <- convert.to.sequences(data)

# perform sequence analysis





tlog(0,"Done")
end.rec.log()
