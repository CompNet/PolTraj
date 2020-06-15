# Fonctions used to read/write files.
# 
# 06/2020 Vincent Labatut
#
# source("src/common/load.R")
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




#############################################################################################
# Reads the full BRÉF table and splits it into a personal info and a mandate tables.
#
# input.file: name of the file containing the table.
#
# returns: a list of two tables (tab.persinf=personal info, tab.mandates=list of mandates). 
#############################################################################################
read.bref.table <- function(input.file)
{	# read the full table
	data <- read.cached.table(cache.file=FILE_DATA)
	
	# split the table into personal information vs. mandates
	cat("Splitting the table into personal information vs. mandates\n")
	col.persinf <- c(COL_ATT_ELU_ID, COL_ATT_ELU_ID_RNE, COL_ATT_ELU_ID_ASSEMB, COL_ATT_ELU_ID_SENAT, COL_ATT_ELU_ID_EURO,
		COL_ATT_ELU_NAIS_DATE, COL_ATT_ELU_NAIS_COM, COL_ATT_ELU_NAIS_DPT, COL_ATT_ELU_NAIS_PAYS, COL_ATT_ELU_DDD,
		COL_ATT_ELU_NOM, COL_ATT_ELU_PRENOM, COL_ATT_ELU_SEXE, COL_ATT_ELU_NAT			
	)
	tab.persinf <- data[!duplicated(data[,COL_ATT_ELU_ID]),col.persinf]
	col.mandates <- c(setdiff(colnames(data), col.persinf), COL_ATT_ELU_ID)
	tab.mandates <- data[,col.mandates]
	
	result <- list(tab.persinf=tab.persinf, tab.mandates=tab.mandates)
	return(result)
}




#############################################################################################
# Converts the BRÉF table into a Traminer-compatible data structure.
# 
# tab.mandates: mandate tables.
#
# returns: a Traminer object.
#############################################################################################
convert.to.sequences <- function(tab.persinf, tab.mandates)
{	# at first, let's just use the mandate names
	unique.ids <- tab.persinf[,COL_ATT_ELU_ID]
	seqs <- sapply(unique.ids, function(id)
	{	# retrieve the date for the current id
		rows <- which(data[,COL_ATT_ELU_ID]==id)
		print(data[rows,c(COL_ATT_MDT_NOM,COL_ATT_MDT_DBT,COL_ATT_MDT_FIN)])
		# convert mandate names to short form
		mdts <- MDT_SHORT[tab.mandates[rows,COL_ATT_MDT_NOM]]
		# order by mandate dates
		idx <- order(data[rows,COL_ATT_MDT_DBT], data[rows,COL_ATT_MDT_FIN])
	})
	
	
	return(sd)
}
