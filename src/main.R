# TODO: Add comment
# 
# TraMineR doc: http://mephisto.unige.ch/pub/TraMineR/doc/TraMineR-Users-Guide.pdf
#
# Vincent Labatut
# 11/2018
###############################################################################
CURRENT_YEAR <- 2018

# init file paths
data.folder <- "data"
perso.file <- file.path(data.folder,"personal.csv")
traj.file <- file.path(data.folder,"trajectories.txt")

# read personal data table
perso <- read.csv(perso.file, header=TRUE, check.names=FALSE)

# read trajectories
#old version
#traj.table <- read.csv(traj.file, header=FALSE)
con <- file(traj.file, open="r")
temp <- readLines(con)
cols <- strsplit(temp, split=',', fixed=TRUE)
#traj <- list()
#for(tmp in cols)
#{	evts <- strsplit(tmp[2:length(tmp)], split=':', fixed=TRUE)
#	evt.lst <- lapply(evts, function(e) 
#				list(start=as.integer(e[1]), 
#						end=ifelse(e[2]=="hui", CURRENT_YEAR, as.integer(e[2])), 
#						position=e[3]))
#	traj[[tmp[1]]] <- evt.lst
#}
traj.mat <- matrix(ncol=5,nrow=0)
colnames(traj) <- c("id","index","from","to","status")
for(tmp in cols)
{	id <- tmp[1]
	idx <- 0
	evts <- strsplit(tmp[2:length(tmp)], split=':', fixed=TRUE)
	evt.mat <- t(sapply(evts, function(e)
		{	idx <<- idx + 1
			c(id=id, index=idx, from=e[1], to=ifelse(e[2]=="hui", CURRENT_YEAR, e[2]), status=e[3])
		}))
	traj.mat <- rbind(traj,evt.mat)
}
traj <- data.frame(traj.mat)

# convert to TraMineR format
traj.labels <- sort(seqstatl(traj[,"status"]))	# full state names
traj.states <- sort(seqstatl(traj[,"status"]))	# short state names
traj.seq <- seqdef(traj, var=c("id", "from", "to", "status"), 
		informat="SPELL", 
		states=traj.states, labels=traj.labels,
		process=FALSE)							# calendar time
