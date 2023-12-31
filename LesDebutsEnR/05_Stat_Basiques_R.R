###################################################################################
# Introduction à R et Rstudio
# Partie 4 Les Statistiques Basiques avec R
# Par: Natacha NJONGWA YEPNGA - LeCoinStat https://www.youtube.com/c/LeCoinStat
# Linkedin: https://www.linkedin.com/in/natacha-njongwa-yepnga/?originalSubdomain=fr
###################################################################################


# Installer et charger le package 'pacman' si nécessaire
if (!require(pacman)) install.packages("pacman")
library(pacman)

# Définir le chemin vers le dossier contenant les données
chemin <- "/Users/natachanjongwayepnga/Documents/GitHub/LeCoinStat/LesDebutsEnR/data"

# Importer des données depuis un fichier CSV
# -----------------------------------------
# Utiliser read.csv() pour lire des fichiers CSV.
chemin_csv <- paste0(chemin, "/donnees_entreprise.csv")
donnees_csv <- read.csv(chemin_csv,sep = ",",dec=".",header = TRUE)
?read.csv
View(donnees_csv)



donnees_csv$Departement<-as.factor(donnees_csv$Departement)
donnees_csv$Performance<-as.factor(donnees_csv$Performance)



# Summary -----------------------------------------------------------------

#Variable qualitative
summary(donnees_csv$Departement)
table(donnees_csv$Departement)
prop.table(table(donnees_csv$Departement))
# Résumé des Variables Quantitatives
summary(donnees_csv$Age) # Remplacer 'Age' par votre variable quantitative

# Résumé de la Base de Données Totale
summary(donnees_csv)

typeof(donnees_csv$Age)
# Describe ----------------------------------------------------------------
# Utilisation de pacman pour charger le package psych
p_load(psych)
library(psych)
# Description des Variables Quantitatives
describe(donnees_csv[,sapply(donnees_csv, is.numeric)]) 

# Description des Variables Qualitatives
describe(donnees_csv[,sapply(donnees_csv, is.factor)]) 

# Description de la Base de Données Totale
describe(donnees_csv)
#Lien vers la documentation du package

# SÉLECTION PAR CATÉGORIE ##################################

# Histogramme du 'Salaire' par catégorie de 'Performance'
# Par exemple, pour la catégorie 'Elevée'
hist(donnees_csv$Salaire[donnees_csv$Performance == "Elevée"],
     main = "Salaire pour la Performance 'Elevée'", 
     xlab = "Salaire", 
     col = "lightgreen")

# SÉLECTION PAR VALEUR #####################################

# Histogramme des employés avec un taux d'absentéisme inférieur à un seuil
# Par exemple, seuil de 0.05
hist(donnees_csv$Taux_Absentéisme[donnees_csv$Taux_Absentéisme < 0.05],
     main = "Taux d'Absentéisme inférieur à 0.05", 
     xlab = "Taux d'Absentéisme", 
     col = "lightcoral")

# CRÉATION D'UN ÉCHANTILLON ################################

# Créer un sous-ensemble de données pour un département spécifique
# Par exemple, pour le département 'Ventes'
ventes_subset <- donnees_csv[donnees_csv$Departement == "Ventes", ]

# Explorer l'échantillon
summary(ventes_subset)
hist(ventes_subset$Salaire, main = "Salaire dans le Département des Ventes")

# NETTOYAGE ################################################

# Nettoyer l'environnement de travail
rm(list = ls())
