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
{	tlog(2, "Reading BREF file \"",cache.file,"\"")
	
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
	tlog(4,"Read ",nrow(data)," rows and ",ncol(data)," columns")
	
	return(data)
}




#############################################################################################
# Reads the full BREF table and splits it into a personal info and a mandate tables.
#
# input.file: name of the file containing the table.
#
# returns: a list of two tables (tab.persinf=personal info, tab.mandates=list of mandates). 
#############################################################################################
read.bref.table <- function(input.file)
{	# read the full table
	data <- read.cached.table(cache.file=FILE_DATA)
	
	# split the table into personal information vs. mandates
	tlog(2, "Splitting the table into personal information vs. mandates")
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
# Converts the BREF table into a Traminer-compatible data structure.
# 
# tab.mandates: mandate tables.
#
# returns: a Traminer object.
#############################################################################################
convert.to.sequences <- function(tab.persinf, tab.mandates)
{	tlog(2, "Converting data to sequences")
	
	# check if the file was previously cached
	if(file.exists(FILE_CACHE))
	{	seqs <- read.table(
			file=FILE_CACHE,
			header=TRUE,
			sep="\t",
			check.names=FALSE,
			comment.char="",
			row.names=NULL,
			quote="",
			as.is=TRUE
		)
	}
	
	# otherwise, convert the data and cache
	else
	{	# temporal resolution
		granularity <- "year"
		start.date <- as.Date("2001/1/1")
		end.date <- Sys.Date()
		dates <- seq(start.date, end.date, granularity)
		empty.seq <- paste(rep(NA,length(dates)-1), collapse="-")
		
		# at first, let's just use the mandate names
		mdt.order <- c(MDT_SHORT_PR,MDT_SHORT_S,MDT_SHORT_D,MDT_SHORT_DE,MDT_SHORT_CR,MDT_SHORT_CD,MDT_SHORT_CM,MDT_SHORT_EPCI)
		unique.ids <- tab.persinf[,COL_ATT_ELU_ID]
		tlog.start.loop(4, length(unique.ids), "Processing each id separately")
		seqs <- t(future_sapply(1:length(unique.ids), function(j)
		{	id <- unique.ids[j]
			tlog.loop(6, j, "Processing id ",id, "(",j,"/",length(unique.ids),")")
			
			# retrieve the date for the current id
			rows <- which(tab.mandates[,COL_ATT_ELU_ID]==id)
			tmp <- tab.mandates[rows,c(COL_ATT_MDT_NOM,COL_ATT_MDT_DBT,COL_ATT_MDT_FIN)]
			#print(tmp)
			
			# convert mandate names to short form
			tmp[,COL_ATT_MDT_NOM] <- MDT_SHORT[tmp[,COL_ATT_MDT_NOM]]
			
			# complete missing end dates
			no.end.date <- which(is.na(tmp[,COL_ATT_MDT_FIN]))
			tmp[no.end.date,COL_ATT_MDT_FIN] <- rep(Sys.Date(), length(no.end.date))
			
			# order by mandate dates and types
			mnd.types <- match(tmp[,COL_ATT_MDT_NOM], mdt.order)
			idx <- order(tmp[,COL_ATT_MDT_DBT], mnd.types)
			mnd.types <- mnd.types[idx]
			tmp <- tmp[idx,]
			
			# adjust dates to avoid overlapping
			if(nrow(tmp)>1)
			{	i <- 1
				while(i<nrow(tmp))
				{	#tlog(8, "row ",i,"----------------------------")
					#print(tmp)
					
					if(mnd.types[i]>mnd.types[i+1])
					{	tmp[i,COL_ATT_MDT_FIN] <- min(tmp[i,COL_ATT_MDT_FIN], tmp[i+1,COL_ATT_MDT_DBT]-1)
						if(tmp[i,COL_ATT_MDT_DBT]>tmp[i,COL_ATT_MDT_FIN])
						{	tmp <- tmp[-i,,drop=FALSE]
							mnd.types <- mnd.types[-i]
							i <- max(1, i - 1)
						}
						else
							i <- i + 1
					}
					else
					{	tmp[i+1,COL_ATT_MDT_DBT] <- max(tmp[i+1,COL_ATT_MDT_DBT], tmp[i,COL_ATT_MDT_FIN]+1)
						if(tmp[i+1,COL_ATT_MDT_DBT]>tmp[i+1,COL_ATT_MDT_FIN])
						{	tmp <- tmp[-(i+1),,drop=FALSE]
							mnd.types <- mnd.types[-(i+1)]
							i <- max(1, i - 1)
						}
						else
							i <- i + 1
					}
				}
			}
			
			# build string representing sequence
			matches <- sapply(1:(length(dates)-1), function(d)
			{	# compute intersection durations
				inters <- sapply(1:nrow(tmp), function(r)
				{	date.intersect.val(start1=dates[d], end1=dates[d+1], 
							start2=tmp[r,COL_ATT_MDT_DBT], end2=tmp[r,COL_ATT_MDT_FIN])
				})
				# take the longest
				idx <- which(!is.na(inters))
				if(length(idx)>0)
				{	idx <- idx[which.max(inters[idx])]
					str <- tmp[idx,COL_ATT_MDT_NOM]
				}
				else
					str <- NA
			})
			
			res <- paste(matches, collapse="-")
			return(cbind(id, res))
		}))
		tlog.end.loop(4, "Processing of ids complete")
		colnames(seqs) <- c(COL_ATT_ELU_ID, COL_CACHE_SEQ)
		
		# remove empty trajectories (all mandates out of the period)
		idx <- which(seqs[,COL_CACHE_SEQ]==empty.seq)
		seqs <- seqs[-idx,]
		
		# cache the obtained data
		seqs <- data.frame(
			seqs, 
			stringsAsFactors=FALSE,
			check.names=FALSE
		)
		write.table(
			x=seqs,
			file=FILE_CACHE,
			quote=FALSE,
			sep="\t",
			row.names=FALSE,
			col.names=TRUE
		)
	}
	
	# create the traminer object
	sd <- seqdef(
		data=seqs,							# data to process
		left=NA,							# how to handle missing data at the beginning of the sequence (NA vs. "DEL") 
		gap=NA,								# how to handle missing data inside the sequence (same as above)
		right=NA,							# how to handle missing data at the end of the sequence (same as left) 
		var=COL_CACHE_SEQ,					# name of the columns containing the formatted sequences
		id=seqs[,COL_ATT_ELU_ID],			# ids of the characters
		alphabet=MDT_SHORT,					# list of position codes
		labels=names(MDT_SHORT),			# names of these positions
		cpal=COLORS_8,						# colors of these positions
		missing.color="#AAAAAA"				# color of missing values
	)
	
# Rstudio version
#
#	seqs <- read.table(
#		file="bref/cache.txt",
#		header=TRUE,
#		sep="\t",
#		check.names=FALSE,
#		comment.char="",
#		row.names=NULL,
#		quote="",
#		as.is=TRUE
#	)
#
#	sd <- seqdef(
#		data=seqs,
#		left=NA, 
#		gap=NA,
#		right=NA, 
#		var=2,
#		id=seqs[,1],
#		alphabet=c("CD","CM","CR","D","DE","EPCI","PR","S")
#	)
	
	return(sd)
}
