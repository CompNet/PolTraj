# TODO: Add comment
# 
# TraMineR doc: http://mephisto.unige.ch/pub/TraMineR/doc/TraMineR-Users-Guide.pdf
#
# Vincent Labatut
# 11/2018
###############################################################################
library("TraMineR")
library(cluster)


CURRENT_YEAR <- 2018

# init file paths
data.folder <- "data"
perso.file <- file.path(data.folder,"personal.csv")
traj.file <- file.path(data.folder,"trajectories.txt")

# read personal data table
perso <- read.csv(perso.file, header=TRUE, check.names=FALSE)

# function to convert statuses
status.map <- c(
	"cd"="Conseiller·e départemental·e",
	"cm"="Conseiller·e municipal·e",
	"cr"="Conseiller·e régional·e",
	"dep"="Député·e",
	"mai"="Maire",
	"min"="Ministre",
	"pm"="Premier ministre"
)

# read trajectories
#old version
#traj.table <- read.csv(traj.file, header=FALSE)
con <- file(traj.file, open="r")
temp <- readLines(con)
close(con)
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
traj.df <- data.frame(id=integer(), index=integer(), from=integer(), to=integer(), status=character(), stringsAsFactors=TRUE)
for(tmp in cols)
{	id <- tmp[1]
	idx <- 0
	evts <- strsplit(tmp[2:length(tmp)], split=':', fixed=TRUE)
	for(evt in evts)
	{	idx <- idx + 1
		#print(evt)
		df <- data.frame(id=as.integer(id), index=as.integer(idx), 
				from=as.integer(evt[1]), to=as.integer(ifelse(evt[2]=="hui", CURRENT_YEAR, evt[2])), 
				status=status.map[evt[3]], stringsAsFactors=TRUE)
		traj.df <- rbind(traj.df, df)
	}
}

# convert trajectories to TraMineR format
traj.labels <- status.map			# full state names
traj.states <- names(status.map)	# short state names
traj.seq <- seqdef(traj.df, var=c("id", "from", "to", "status"), 
		informat="SPELL", 
		states=traj.states, labels=traj.labels,
		process=FALSE)				# FALSE => calendar time

# plot n°1
plot.filename <- file.path(data.folder,"fig01.pdf")
pdf(file=plot.filename,bg="white",compress=FALSE)
	par(mfrow=c(2,2))
	seqiplot(traj.seq, main="First 10 sequences", with.legend=FALSE)
	seqIplot(traj.seq, main="All sequences", sortv="from.start", with.legend=FALSE)
	seqfplot(traj.seq, main="10 most frequent sequences", with.legend=FALSE, pbarw=TRUE)
	seqlegend(traj.seq)
dev.off()

# plot n°2
plot.filename <- file.path(data.folder,"fig02.pdf")
pdf(file=plot.filename,bg="white",compress=FALSE)
	par(mfrow=c(2,2))
	seqdplot(traj.seq, main="State distribution", with.legend=FALSE, border=NA)
	seqHtplot(traj.seq, main="Entropy index")
	seqmtplot(traj.seq, main="Mean time", with.legend=FALSE)
	seqmsplot(traj.seq, main="Modal state sequence", with.legend=FALSE, border=NA)
dev.off()

# compute inter-sequence distances and clusters
traj.dist <- seqdist(traj.seq, method="OM", indel=1, sm="TRATE", with.missing=TRUE)
clusters <- agnes(traj.dist, diss=TRUE, method="ward")
plot(clusters, which.plot=2)
cl4 <- cutree(clusters, k=4)
cl4.fac <- factor(cl4, labels=paste("Cluster", 1:4))

# plot n°3: Sequences within each cluster
plot.filename <- file.path(data.folder,"fig03.pdf")
pdf(file=plot.filename,bg="white",compress=FALSE)
	seqIplot(traj.seq, group=cl4.fac, sortv="from.start")
dev.off()

# plot n°4: State distribution within each cluster
plot.filename <- file.path(data.folder,"fig04.pdf")
pdf(file=plot.filename,bg="white",compress=FALSE)
	seqdplot(traj.seq, group=cl4.fac, border=NA)
dev.off()

# plot n°5: Representative sequence of each cluster
plot.filename <- file.path(data.folder,"fig05.pdf")
pdf(file=plot.filename,bg="white",compress=FALSE)
	seqrplot(traj.seq, diss=traj.dist, group=cl4.fac, border=NA)
dev.off()

# compute discrepancy
da <- dissassoc(traj.dist, group=perso[,"Sexe"], R=5000)
print(da$stat)

# plot n°6: Association between the state sequences and the selected covariate
plot.filename <- file.path(data.folder,"fig06.pdf")
gdiff <- seqdiff(traj.seq, group=perso[,"Sexe"], cmprange=c(0,5), 
		seqdist.args=list(method="OM", indel=1, sm="TRATE"))
pdf(file=plot.filename,bg="white",compress=FALSE)
	plot(gdiff, main="Evolution of the pseudo R2 and L", stat=c("Pseudo R2", "Levene"), lwd=2)
dev.off()

# plot n°7: Evolution of the within-group discrepancy
plot.filename <- file.path(data.folder,"fig07.pdf")
pdf(file=plot.filename,bg="white",compress=FALSE)
	plot(gdiff, main="Evolution of within-group and overall discrepancies", 
			stat=c("discrepancy"), lwd=2, legend.pos="topright")
dev.off()

# plot n°7: Regression tree for the state sequences
plot.filename <- file.path(data.folder,"fig08.png")
st <- seqtree(traj.seq ~ Sexe + `Groupe politique` + Profession, data=perso,
		R=5000, diss=traj.dist, pval = 0.05)
seqtreedisplay(st, filename=plot.filename, type="d", border=NA, gvpath='C:/Program Files (x86)/Graphviz2.38')

# plot n°8: Most frequent subsequences
plot.filename <- file.path(data.folder,"fig09.pdf")
traj.seqe <- seqecreate(traj.seq, use.labels=FALSE)
fsubseq <- seqefsub(traj.seqe, pmin.support=0.05)
pdf(file=plot.filename,bg="white",compress=FALSE)
	plot(fsubseq[1:15], col="cyan", main="15 most frequent subsequences")
dev.off()

# plot n°9: Subsequences of transitions in each cluster
plot.filename <- file.path(data.folder,"fig10.pdf")
discr <- seqecmpgroup(fsubseq, group=cl4.fac)
pdf(file=plot.filename,bg="white",compress=FALSE)
	plot(discr[1:6])
dev.off()

