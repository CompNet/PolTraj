# Fonctions used to read/write files.
# 
# Vincent Labatut
# 06/2020
#
# source("src/common/files.R")
###############################################################################




#############################################################################################
# Read a cached file corresponding to a cleaned data table.
# Note: function taken from our BrefInit project.
# 
# cache.file: path of the file to load.
# 
# returns: the read data table.
#############################################################################################
read.cached.table <- function(cache.file)
{	cat("Reading cached file \"",cache.file,"\"\n")
	
	# first read only the column names
	tmp <- read.table(
		file=cache.file,			# name of the data file
		nrows=1,					# only read the header
		header=TRUE, 				# look for a header
		sep="\t", 					# character used to separate columns 
		check.names=FALSE, 			# don't change the column names from the file
		comment.char="", 			# ignore possible comments in the content
		row.names=NULL, 			# don't look for row names in the file
		quote="", 					# don't expect double quotes "..." around text fields
		as.is=TRUE,					# don't convert strings to factors
		colClasses="character"		# force column types
	)
	
	# set up columns data types
	col.names <- colnames(tmp)
	types <- rep("character",length(col.names))
	types[which(COL_TYPES[col.names]=="dat")] <- "Date"
	types[which(COL_TYPES[col.names]=="num")] <- "integer"
	types[col.names %in% c(COL_ATT_CORREC_DATE,COL_ATT_CORREC_INFO)] <- "logical"
	
	# read the full table normally
	data <- read.table(
		file=cache.file,			# name of the data file
		header=TRUE, 				# look for a header
		sep="\t", 					# character used to separate columns 
		check.names=FALSE, 			# don't change the column names from the file
		comment.char="", 			# ignore possible comments in the content
		row.names=NULL, 			# don't look for row names in the file
		quote="", 					# don't expect double quotes "..." around text fields
		as.is=TRUE,					# don't convert strings to factors
		colClasses=types			# force column types
	)
	cat("..Read ",nrow(data)," rows and ",ncol(data)," columns\n")
	
	return(data)
}
