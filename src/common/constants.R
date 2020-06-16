#############################################################################################
# Defines functions or constants used by all other scripts.
# 
# 06/2020 Vincent Labatut
#
# source("src/common/constants.R")
#############################################################################################




#############################################################################################
CORE.NBR <- detectCores(all.tests=TRUE)




#############################################################################################
PLOT_FORMATS <- c("pdf","png")
#PLOT_FORMATS <- "pdf"
#PLOT_FORMATS <- "png"




#############################################################################################
# folders and files
FOLDER_IN <- "in"
	FILE_DATA <- file.path(FOLDER_IN, "data.txt")
FOLDER_OUT <- "in"
FOLDER_LOG <- "log"




#############################################################################################
# column names
COL_ATT_CANT_CODE <- "Code canton"
COL_ATT_CANT_ID <- "ID canton"
COL_ATT_CANT_NOM <- "Libelle canton"
COL_ATT_CIRC_CODE <- "Code circo legislative"
COL_ATT_CIRC_NOM <- "Libelle circo legislative"
COL_ATT_CIRCE_CODE <- "Code circo euro"
COL_ATT_CIRCE_NOM <- "Libelle circo euro"
COL_ATT_COM_CODE <- "Code Insee commune"
COL_ATT_COM_NOM <- "Libelle commune"
COL_ATT_COM_POP <- "Population commune"
COL_ATT_CORREC_DATE <- "Correction dates"
COL_ATT_CORREC_INFO <- "Correction autres"
COL_ATT_DPT_CODE <- "Code departement"
COL_ATT_DPT_ID <- "ID departement"
COL_ATT_DPT_NOM <- "Libelle departement"
COL_ATT_ELU_NAIS_COM <- "Commune de naissance"
COL_ATT_ELU_NAIS_DATE <- "Date naissance"
COL_ATT_ELU_NAIS_DPT <- "Departement de naissance"
COL_ATT_ELU_NAIS_PAYS <- "Pays de naissance"
COL_ATT_ELU_DDD <- "Date deces"
COL_ATT_ELU_ID <- "ID universel"
COL_ATT_ELU_ID_RNE <- "ID RNE"
COL_ATT_ELU_ID_ASSEMB <- "ID Assemblee"
COL_ATT_ELU_ID_SENAT <- "ID Senat"
COL_ATT_ELU_ID_EURO <- "ID Europe"
COL_ATT_ELU_NAT <- "Nationalite elu"
COL_ATT_ELU_NOM <- "Nom elu"
COL_ATT_ELU_PRENOM <- "Prenom elu"
COL_ATT_ELU_SEXE <- "Code sexe"
COL_ATT_ELU_NUANCE <- "Nuance politique"
COL_ATT_EPCI_NOM <- "Libelle EPCI"
COL_ATT_EPCI_SIREN <- "Numero SIREN"
COL_ATT_EPCI_DPT <- "Code departement EPCI"
COL_ATT_FCT_DBT <- "Date debut fonction"
COL_ATT_FCT_FIN <- "Date fin fonction"
COL_ATT_FCT_MOTIF <- "Motif fin fonction"
COL_ATT_FCT_CODE <- "Code fonction"
COL_ATT_FCT_NOM <- "Libelle fonction"
COL_ATT_MDT_DBT <- "Date debut mandat"
COL_ATT_MDT_FIN <- "Date fin mandat"
COL_ATT_MDT_MOTIF <- "Motif fin mandat"
COL_ATT_MDT_NOM <- "Libelle mandat"
COL_ATT_PRO_CODE <- "Code profession"
COL_ATT_PRO_NOM <- "Libelle profession"
COL_ATT_REG_CODE <- "Code region"
COL_ATT_REG_NOM <- "Libelle region"
COL_ATT_SOURCES <- "Sources"

# column long names
LONGNAMES <- c()
LONGNAMES[COL_ATT_CANT_CODE] <- "Code du canton"
LONGNAMES[COL_ATT_CANT_ID] <- "Id unique du canton"
LONGNAMES[COL_ATT_CANT_NOM] <- "Libellé du canton"
LONGNAMES[COL_ATT_CIRC_CODE] <- "Code de la circonscription législative"
LONGNAMES[COL_ATT_CIRC_NOM] <- "Libellé de la circonscription législative"
LONGNAMES[COL_ATT_CIRCE_CODE] <- "Code de la circonscription européenne"
LONGNAMES[COL_ATT_CIRCE_NOM] <- "Libellé de la circonscription européenne"
LONGNAMES[COL_ATT_COM_CODE] <- "Code de la commune"
LONGNAMES[COL_ATT_COM_NOM] <- "Libellé de la commune"
LONGNAMES[COL_ATT_COM_POP] <- "Population de la commune"
LONGNAMES[COL_ATT_CORREC_DATE] <- "Modification de date(s)"
LONGNAMES[COL_ATT_CORREC_INFO] <- "Autres modifications"
LONGNAMES[COL_ATT_DPT_ID] <- "Id unique du département"
LONGNAMES[COL_ATT_DPT_CODE] <- "Code du département"
LONGNAMES[COL_ATT_DPT_NOM] <- "Libellé du département"
LONGNAMES[COL_ATT_ELU_NAIS_COM] <- "Commune de naissance de l'élu"
LONGNAMES[COL_ATT_ELU_NAIS_DATE] <- "Date de naissance de l'élu"
LONGNAMES[COL_ATT_ELU_NAIS_DPT] <- "Département de naissance de l'élu"
LONGNAMES[COL_ATT_ELU_NAIS_PAYS] <- "Pays de naissance de l'élu"
LONGNAMES[COL_ATT_ELU_DDD] <- "Date de décès de l'élu"
LONGNAMES[COL_ATT_ELU_ID] <- "Id universel de l'élu"
LONGNAMES[COL_ATT_ELU_ID_RNE] <- "Id RNE de l'élu"
LONGNAMES[COL_ATT_ELU_ID_ASSEMB] <- "Id parlementaire de l'élu"
LONGNAMES[COL_ATT_ELU_ID_SENAT] <- "Id sénatorial de l'élu"
LONGNAMES[COL_ATT_ELU_ID_EURO] <- "Id européen de l'élu"
LONGNAMES[COL_ATT_ELU_NAT] <- "Nationalité de l'élu"
LONGNAMES[COL_ATT_ELU_NOM] <- "Nom de l'élu"
LONGNAMES[COL_ATT_ELU_PRENOM] <- "Prénom de l'élu"
LONGNAMES[COL_ATT_ELU_SEXE] <- "Code sexe de l'élu"
LONGNAMES[COL_ATT_ELU_NUANCE] <- "Nuance politique de l'élu"
LONGNAMES[COL_ATT_EPCI_NOM] <- "Libellé de l'EPCI"
LONGNAMES[COL_ATT_EPCI_SIREN] <- "N° SIREN"
LONGNAMES[COL_ATT_EPCI_DPT] <- "Code du département de l'EPCI"
LONGNAMES[COL_ATT_FCT_DBT] <- "Date de début de la fonction"
LONGNAMES[COL_ATT_FCT_FIN] <- "Date de fin de la fonction"
LONGNAMES[COL_ATT_FCT_MOTIF] <- "Motif de fin de fonction"
LONGNAMES[COL_ATT_FCT_CODE] <- "Code de la fonction"
LONGNAMES[COL_ATT_FCT_NOM] <- "Libellé de la fonction"
LONGNAMES[COL_ATT_MDT_DBT] <- "Date de début du mandat"
LONGNAMES[COL_ATT_MDT_FIN] <- "Date de fin du mandat"
LONGNAMES[COL_ATT_MDT_MOTIF] <- "Motif de fin de mandat"
LONGNAMES[COL_ATT_MDT_NOM] <- "Libellé du mandat"
LONGNAMES[COL_ATT_PRO_CODE] <- "Code de la profession"
LONGNAMES[COL_ATT_PRO_NOM] <- "Libellé de la profession"
LONGNAMES[COL_ATT_REG_CODE] <- "Code de la région"
LONGNAMES[COL_ATT_REG_NOM] <- "Libellé de la région"
LONGNAMES[COL_ATT_SOURCES] <- "Sources de la ligne"

# column short names
BASENAMES <- c()
BASENAMES[COL_ATT_CANT_CODE] <- "canton_code"
BASENAMES[COL_ATT_CANT_ID] <- "canton_id"
BASENAMES[COL_ATT_CANT_NOM] <- "canton_lib"
BASENAMES[COL_ATT_CIRC_CODE] <- "circo_code"
BASENAMES[COL_ATT_CIRC_NOM] <- "circo_lib"
BASENAMES[COL_ATT_CIRCE_CODE] <- "circe_code"
BASENAMES[COL_ATT_CIRCE_NOM] <- "circe_lib"
BASENAMES[COL_ATT_COM_CODE] <- "commune_code"
BASENAMES[COL_ATT_COM_NOM] <- "commune_lib"
BASENAMES[COL_ATT_COM_POP] <- "commune_pop"
BASENAMES[COL_ATT_CORREC_DATE] <- "correc_date"
BASENAMES[COL_ATT_CORREC_INFO] <- "correc_info"
BASENAMES[COL_ATT_DPT_CODE] <- "dept_code"
BASENAMES[COL_ATT_DPT_ID] <- "dept_id"
BASENAMES[COL_ATT_DPT_NOM] <- "dept_lib"
BASENAMES[COL_ATT_ELU_NAIS_COM] <- "elu_nais_com"
BASENAMES[COL_ATT_ELU_NAIS_DATE] <- "elu_nais_date"
BASENAMES[COL_ATT_ELU_NAIS_DPT] <- "elu_nais_dpt"
BASENAMES[COL_ATT_ELU_NAIS_PAYS] <- "elu_nais_pays"
BASENAMES[COL_ATT_ELU_DDD] <- "elu_ddd"
BASENAMES[COL_ATT_ELU_ID] <- "elu_id_univ"
BASENAMES[COL_ATT_ELU_ID_RNE] <- "elu_id_rne"
BASENAMES[COL_ATT_ELU_ID_ASSEMB] <- "elu_id_assemb"
BASENAMES[COL_ATT_ELU_ID_SENAT] <- "elu_id_senat"
BASENAMES[COL_ATT_ELU_ID_EURO] <- "elu_id_euro"
BASENAMES[COL_ATT_ELU_NAT] <- "elu_nation"
BASENAMES[COL_ATT_ELU_NOM] <- "elu_nom"
BASENAMES[COL_ATT_ELU_NUANCE] <- "elu_nuance"
BASENAMES[COL_ATT_ELU_PRENOM] <- "elu_prenom"
BASENAMES[COL_ATT_ELU_SEXE] <- "elu_sexe"
BASENAMES[COL_ATT_EPCI_DPT] <- "epci_dept"
BASENAMES[COL_ATT_EPCI_NOM] <- "epci_lib"
BASENAMES[COL_ATT_EPCI_SIREN] <- "epci_siren"
BASENAMES[COL_ATT_FCT_DBT] <- "fonction_debut"
BASENAMES[COL_ATT_FCT_FIN] <- "fonction_fin"
BASENAMES[COL_ATT_FCT_MOTIF] <- "fonction_motif"
BASENAMES[COL_ATT_FCT_CODE] <- "fonction_code"
BASENAMES[COL_ATT_FCT_NOM] <- "fonction_lib"
BASENAMES[COL_ATT_MDT_DBT] <- "mandat_debut"
BASENAMES[COL_ATT_MDT_FIN] <- "mandat_fin"
BASENAMES[COL_ATT_MDT_MOTIF] <- "mandat_motif"
BASENAMES[COL_ATT_MDT_NOM] <- "mandat_lib"
BASENAMES[COL_ATT_PRO_CODE] <- "elu_pro_code"
BASENAMES[COL_ATT_PRO_NOM] <- "elu_pro_lib"
BASENAMES[COL_ATT_REG_CODE] <- "region_code"
BASENAMES[COL_ATT_REG_NOM] <- "region_lib"
BASENAMES[COL_ATT_SOURCES] <- "sources"

# column data types
COL_TYPES <- c()
COL_TYPES[COL_ATT_CANT_CODE] <- "cat"
COL_TYPES[COL_ATT_CANT_ID] <- "cat"
COL_TYPES[COL_ATT_CANT_NOM] <- "nom"
COL_TYPES[COL_ATT_CIRC_CODE] <- "cat"
COL_TYPES[COL_ATT_CIRC_NOM] <- "nom"
COL_TYPES[COL_ATT_CIRCE_CODE] <- "cat"
COL_TYPES[COL_ATT_CIRCE_NOM] <- "nom"
COL_TYPES[COL_ATT_COM_CODE] <- "cat"
COL_TYPES[COL_ATT_COM_NOM] <- "nom"
COL_TYPES[COL_ATT_COM_POP] <- "num"
COL_TYPES[COL_ATT_CORREC_DATE] <- "cat"
COL_TYPES[COL_ATT_CORREC_INFO] <- "cat"
COL_TYPES[COL_ATT_DPT_ID] <- "nom"
COL_TYPES[COL_ATT_DPT_CODE] <- "cat"
COL_TYPES[COL_ATT_DPT_NOM] <- "nom"
COL_TYPES[COL_ATT_ELU_NAIS_COM] <- "nom"
COL_TYPES[COL_ATT_ELU_NAIS_DATE] <- "dat"
COL_TYPES[COL_ATT_ELU_NAIS_DPT] <- "nom"
COL_TYPES[COL_ATT_ELU_NAIS_PAYS] <- "nom"
COL_TYPES[COL_ATT_ELU_DDD] <- "dat"
COL_TYPES[COL_ATT_ELU_ID] <- "nom"
COL_TYPES[COL_ATT_ELU_ID_RNE] <- "cat"
COL_TYPES[COL_ATT_ELU_ID_ASSEMB] <- "nom"
COL_TYPES[COL_ATT_ELU_ID_SENAT] <- "nom"
COL_TYPES[COL_ATT_ELU_ID_EURO] <- "nom"
COL_TYPES[COL_ATT_ELU_NAT] <- "cat"
COL_TYPES[COL_ATT_ELU_NOM] <- "nom"
COL_TYPES[COL_ATT_ELU_NUANCE] <- "cat"
COL_TYPES[COL_ATT_ELU_PRENOM] <- "nom"
COL_TYPES[COL_ATT_ELU_SEXE] <- "cat"
COL_TYPES[COL_ATT_EPCI_SIREN] <- "cat"
COL_TYPES[COL_ATT_EPCI_NOM] <- "nom"
COL_TYPES[COL_ATT_EPCI_DPT] <- "cat"
COL_TYPES[COL_ATT_FCT_CODE] <- "cat"
COL_TYPES[COL_ATT_FCT_NOM] <- "nom"
COL_TYPES[COL_ATT_FCT_DBT] <- "dat"
COL_TYPES[COL_ATT_FCT_FIN] <- "dat"
COL_TYPES[COL_ATT_FCT_MOTIF] <- "cat"
COL_TYPES[COL_ATT_MDT_NOM] <- "nom"
COL_TYPES[COL_ATT_MDT_DBT] <- "dat"
COL_TYPES[COL_ATT_MDT_FIN] <- "dat"
COL_TYPES[COL_ATT_MDT_MOTIF] <- "cat"
COL_TYPES[COL_ATT_PRO_CODE] <- "cat"
COL_TYPES[COL_ATT_PRO_NOM] <- "nom"
COL_TYPES[COL_ATT_REG_CODE] <- "cat"
COL_TYPES[COL_ATT_REG_NOM] <- "nom"
COL_TYPES[COL_ATT_SOURCES] <- "cat"




#############################################################################################
# mandate short names
MDT_SHORT_CD <- "CD"
MDT_SHORT_CM <- "CM"
MDT_SHORT_CR <- "CR"
MDT_SHORT_D <- "D"
MDT_SHORT_DE <- "DE"
MDT_SHORT_EPCI <- "EPCI"
MDT_SHORT_PR <- "PR"
MDT_SHORT_S <- "S"

# conversion map
MDT_SHORT <- c()
MDT_SHORT["CONSEILLER DEPARTEMENTAL"] <- MDT_SHORT_CD
MDT_SHORT["CONSEILLER MUNICIPAL"] <- MDT_SHORT_CM
MDT_SHORT["CONSEILLER REGIONAL"] <- MDT_SHORT_CR
MDT_SHORT["DEPUTE"] <- MDT_SHORT_D
MDT_SHORT["REPRESENTANT AU PARLEMENT EUROPEEN"] <- MDT_SHORT_DE
MDT_SHORT["CONSEILLER EPCI"] <- MDT_SHORT_EPCI
MDT_SHORT["PRESIDENT DE LA REPUBLIQUE"] <- MDT_SHORT_PR
MDT_SHORT["SENATEUR"] <- MDT_SHORT_S
