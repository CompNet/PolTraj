#############################################################################################
# Loads all the script of this project, in the appropriate order.
# 
# 06/2020 Vincent Labatut
#
# source("src/common/include.R")
#############################################################################################




#############################################################################################
# handling of warnings

#options(warn=1)			# as they happen
options(warn=2)				# as errors
#options(error=recover)		# debug




#############################################################################################
# packages
library("TraMineR")			# sequence analysis
library("cluster")			# cluster analysis

library("parallel")			# parallel computing
library("future.apply")		# parallel processing




#############################################################################################
# source code
source("src/common/constants.R")
source("src/common/colors.R")
source("src/common/dates.R")
source("src/common/logging.R")
source("src/common/load.R")




#############################################################################################
# global options
options(future.globals.maxSize=650*1024^2)	# max limit for future global env is 650 MB
plan(multiprocess, workers=CORE.NBR/2)		# set the number of processor cores used
