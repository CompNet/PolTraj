# Analyse de séquences -Juin 2019
#On installe le package spécifique
#install.packages(c('TraMineR', 'cluster'))

#On charge les packages
library(TraMineR)
library(cluster)

# Importation des données
# Jeu de données créé par N. Robette (http://nicolas.robette.free.fr/).
# Contient la trajectoire pro de 1000 personnes âgées de 14 à 50 ans

dat<-read.csv("http://nicolas.robette.free.fr/Docs/trajpro.csv",header=T)
head(dat)
dim(dat)
str(dat)

#On renomme les generations distinguées par l'auteur
dat$generation <- factor(dat$generation,labels=c('1930-38', '1939-45', '1946-50'))
seqstatl(dat[,1:37]) #Liste des différents états (permet de déceler des erreurs)

labels <- c("agri","artisans","cadres","prof.intermediaires","employes","ouvriers","etudiants","hors marche","service mili")

#On crée un objet sequence
seq <- seqdef(dat[,1:37], states=labels)
str(seq)
print(seq, format="SPS")

## Explorons les données
# Index plot
seqiplot(seq, xtlab=14:50, border=NA, with.legend=T, yaxis=FALSE, idxs=0, space=0)# Pas clair

#Options d'affichage
seqiplot(seq, xtlab=14:50, border=NA, yaxis=FALSE, idxs=0, space=0, sort="from.start", with.legend=T) # Sorted from start
seqiplot(seq, xtlab=14:50, border=NA, yaxis=FALSE, idxs=0, space=0, sort="from.end", with.legend=T) # Sorted from end
seqiplot(seq, idxs=1:5,xtlab=14:50, with.legend=T) # 5 sequences les + communes

# Distribution plot
seqdplot(seq, xtlab=14:50, with.legend=T, yaxis=FALSE, border=NA)

## D'autres infos sont disponibles
seqmsplot(seq,xtlab=14:50) # Modal state
seqmodst(seq)

seqHtplot(seq, xtlab=14:50, with.legend=T) # Entropy index
seqstatd(seq)

seqmtplot(seq, with.legend=T) # Temps moyen dans chaque état
seqmeant(seq)
apply(seqstatd(seq)[[1]],1,sum)

seqtransn(seq) # Nombre de transitions, par personne
table(seqtransn(seq)) # 


########### VARIABLES EXTERNES
seqiplot(seq, xtlab=14:50, border=NA, with.legend=T, yaxis=FALSE, idxs=0, space=0, group=dat$generation, sort="from.start")
seqiplot(seq, xtlab=14:50, border=NA, with.legend=T, yaxis=FALSE, idxs=0, space=0, group=dat$generation, sort="from.end")

seqdplot(seq, group=dat$generation, xtlab=14:50, with.legend="auto", border=NA)

seqmsplot(seq, group=dat$generation, xtlab=14:50, cex.legend=.66) # Etat modal

seqHtplot(seq, group=dat$generation, xtlab=14:50) # Entropy index

seqmtplot(seq, group=dat$generation, with.legend=T, cex.legend=.66) # Mean time in each state


############### OPTIMAL MATCHING
# Definition d'une matrice de coût de substitution
cost1 <- seqsubm(seq,method="CONSTANT", cval=2) # Cout équivalent (2)
cost2 <- seqsubm(seq,method="TRATE") # Transitions observées

# Definition d'une distance entre séquences
seq.om <- seqdist(seq, method="OM", indel=1, sm=cost1)
# Bien d'autres options sont possibles, voir ?seqdist

# Clustering sur la matrice de distance
seq.agnes <- agnes(as.dist(seq.om), method="ward")

par(mfrow = c(1,1))
plot(as.dendrogram(seq.agnes))

nbcl <- 5 # Choose the number of classes to keep
seq.part <- cutree(seq.agnes, nbcl)
dat$part <-factor(seq.part,labels=paste('Classe',1:nbcl,sep=' ')) # add class to the dataset

seqiplot(seq, group=seq.part, xtlab=14:50, idxs=0, space=0, border=NA, with.legend=T, yaxis=FALSE, sort="from.end")

seqdplot(seq, group=seq.part, xtlab=14:50, border=NA, with.legend=T)

seqmsplot(seq, group=seq.part, xtlab=14:50, with.legend=T, main="Class")
seqHtplot(seq, group=seq.part, xtlab=14:50, with.legend=T, main="Class")

seqmtplot(seq, group=seq.part, with.legend=T)

# Si on choisissait 10 classes, on verrait autre chose


################################ THE END ###############


dat<-read.csv("http://ollion.cnrs.fr/wp-content/uploads/2018/05/MPsExample.csv")

# What is this dataset about? 
dim(dat)
head(dat)
summary(dat)

colnames(dat)
seqstatl(dat[,2:54]) #List of distinct states - Helps see problems in data

str(dat)
# Lets create labels to translate this into english
labels <- c("2loc","DeptalCouncil","MuniCouncil","RegiCouncil","Representative","Gov","Mayor","MEP", "No Info", "Sen")

#Creates a sequence object
seq <- seqdef(dat[,2:54], states=labels)
str(seq)
print(seq, format="SPS")

## First, look at the data
# Index plot
seqiplot(seq, idxs=0) # 2nd argument means "no restriction on the input sequence"

# This is not working super well...need to remove the border. See help
seqiplot(seq, idxs=0, space=0, border=NA)
seqiplot(seq, xtlab=c(1962:2014), border=NA, with.legend=T, yaxis=FALSE, idxs=0, space=0, cex.legend=.66)

# You can also choose how you can sort this
seqiplot(seq, xtlab=c(1962:2014), border=NA, yaxis=FALSE, idxs=0, space=0, sort="from.start", with.legend=T, cex.legend=.66) # Sorted from start
seqiplot(seq, xtlab=c(1962:2014), border=NA, yaxis=FALSE, idxs=0, space=0, sort="from.end", with.legend=T,cex.legend=.66) # Sorted from end

# Distribution plot
seqdplot(seq, xtlab=c(1962:2014), with.legend=T, yaxis=FALSE, border=NA, cex.legend=.66)

## We can extract more information
seqmsplot(seq,xtlab=c(1962:2014)) # Modal state
seqmodst(seq)

seqHtplot(seq, xtlab=c(1962:2014)) # Entropy index
seqstatd(seq)

seqmtplot(seq, with.legend=T, cex.legend=.66) # Mean time in each state
seqmeant(seq)

apply(seqstatd(seq)[[1]],1,sum)

#####################################
#Swedish MPs & Sequence analysis
dat <- read.csv("http://ollion.cnrs.fr/wp-content/uploads/2018/04/ValKompassAA2018_short.csv")

dat <- read.csv("/home/leo/Seafile/Enseignement/2017/ArchivesAlgorithms_2018/Data/ValKompass/ValKompassAA2018_short.csv")
head(dat)
newdat <-dat[!is.na(dat$Income2008),] # NA don't work well

newdat$Q_Income08 <- factor(cut2(newdat$Income2008,g=4), labels=c("Q1","Q2","Q3","Q4"))
newdat$Q_Income09 <- factor(cut2(newdat$Income2009,g=4), labels=c("Q1","Q2","Q3","Q4"))
newdat$Q_Income10 <- factor(cut2(newdat$Income2010,g=4), labels=c("Q1","Q2","Q3","Q4"))
newdat$Q_Income11 <- factor(cut2(newdat$Income2011,g=4), labels=c("Q1","Q2","Q3","Q4"))
newdat$Q_Income12 <- factor(cut2(newdat$Income2012,g=4), labels=c("Q1","Q2","Q3","Q4"))

colnames(newdat)

#Sequence
labels <- c("Q1","Q2","Q3","Q4")

# Create a sequence object call seq that will take the 5 years of income, dichotomized
seq <- seqdef(newdat[,68:72], states=labels)
summary(seq)
print(seq, format="SPS")

summary(seq)
print(seq, format="SPS")

# Visualize as an index plot, as a distribution plot
seqiplot(seq,  border=NA, with.legend="auto", idxs=0)
seqdplot(seq,  border=NA, with.legend="auto")

# Define a method for setting the cost. Why this one?
cost1 <- seqsubm(seq,method="CONSTANT", cval=2) # Equivalent cost

# Calculate distance
seq.om <- seqdist(seq, method="OM", indel=1.2, sm=cost1)

# Do the classification
seq.agnes <- agnes(as.dist(seq.om), method="ward", keep.diss=F)

par(mfrow = c(1,1)) # This is a graphic parameter
plot(as.dendrogram(seq.agnes))

nbcl <- 7 # Choose the number of classes to keep
seq.part <- cutree(seq.agnes, nbcl)
#dat$part <-factor(seq.part,labels=paste('Classe',1:nbcl,sep=' ')) # add class to the dataset

seqiplot(seq, group=seq.part, idxs=0, space=0, border=NA, with.legend=T, yaxis=FALSE, sort="from.end")
