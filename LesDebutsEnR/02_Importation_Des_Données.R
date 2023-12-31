###################################################################################
# Introduction à R et Rstudio
# Partie 2 Importation des données
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
chemin_csv
donnees_csv <- read.csv(chemin_csv,sep = ",",dec=".",header = T)
?read.csv
View(donnees_csv)

# Importer des données depuis un fichier TXT
# ------------------------------------------
# Utiliser read.table() pour lire des fichiers TXT.
chemin_txt <- paste0(chemin, "/donnees_entreprise.txt")
chemin_txt
donnees_txt <- read.table(chemin_txt, header = TRUE) # Assurez-vous de définir le paramètre 'header' correctement
?read.table
View(donnees_txt)

# Importer des données depuis un fichier Excel
# --------------------------------------------
# Charger 'readxl' pour lire des fichiers Excel.
p_load(readxl)
library(readxl)
?read_excel
# Lire un fichier Excel. 
chemin_excel <- paste0(chemin, "/donnees_entreprise.xlsx")
donnees_excel <- read_excel(chemin_excel)
donnees_excel <- readxl::read_excel(chemin_excel)
View(donnees_excel)
?readxl

# Avec readxl, vous pouvez spécifier des paramètres supplémentaires comme le numéro ou le nom de la feuille.
# Par exemple : read_excel(chemin_excel, sheet = "Feuille1")


# Les autres types de données ---------------------------------------------

# Fichiers Excel (XLS, XLSX)
# Utiliser les packages 'readxl', 'openxlsx', 'XLConnect' pour lire des fichiers Excel.

# Fichiers Texte (TXT, CSV)
# Fonctions standards comme 'read.table()', 'read.csv()', 'read.delim()' pour les fichiers texte.
# 'data.table' (fonction 'fread()') pour une lecture rapide.

# Fichiers JSON
# Package 'jsonlite' pour lire et écrire des données JSON.

# Fichiers XML et HTML
# Package 'xml2' pour lire des fichiers XML.
# Package 'rvest' pour le scraping de données HTML.

# Fichiers SPSS, Stata, SAS
# Package 'haven' pour lire des fichiers de logiciels statistiques comme .sav (SPSS), .dta (Stata), .sas7bdat (SAS).


# NETTOYAGE ################################################

# Nettoyer l'environnement de travail
rm(list = ls())
