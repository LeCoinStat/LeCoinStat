###################################################################################
# Introduction à R et Rstudio
# Partie 3 Visualisation des données en utilisant le module natif de R
# Par: Natacha NJONGWA YEPNGA - LeCoinStat https://www.youtube.com/c/LeCoinStat
# Linkedin: https://www.linkedin.com/in/natacha-njongwa-yepnga/?originalSubdomain=fr
###################################################################################



# Importation des données -------------------------------------------------


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

?plot


donnees_csv$Departement<-as.factor(donnees_csv$Departement)
donnees_csv$Performance<-as.factor(donnees_csv$Performance)
experience<-donnees_csv$Experience

#Visualisation des variables qualitatives
plot(donnees_csv$Departement)
# Visualisation des variables quantitatives -------------------------------
plot(donnees_csv$Taux_Absentéisme)

#quanti-quanti
plot(donnees_csv$Taux_Absentéisme,donnees_csv$Taux_Turnover)
#quanti-quali
plot(donnees_csv$Departement,donnees_csv$Taux_Turnover)
?plot
#Graphique sur toute la base
plot(donnees_csv)
library(datasets)
plot(iris)


# Personnaliser les graphiques plot ---------------------------------------

# Création d'un graphique de base avec plot
# Ici, nous traçons Taux_Absentéisme vs Taux_Turnover
plot(donnees_csv$Taux_Absentéisme, donnees_csv$Taux_Turnover, 
     main = "Taux d'Absentéisme vs Taux de Turnover",  # Titre du graphique
     xlab = "Taux d'Absentéisme",                     # Étiquette de l'axe des x
     ylab = "Taux de Turnover",                       # Étiquette de l'axe des y
     pch = 19,                                        # Type de point (pch = 19 pour des cercles pleins)
     col ="blue",                                    # Couleur des points
     cex = 0.5)                                       # Taille des points

# Ajouter une ligne de régression
abline(lm(donnees_csv$Taux_Turnover ~ donnees_csv$Taux_Absentéisme), col = "red")

# Ajouter une grille pour une meilleure lisibilité
grid(nx = NULL, ny = NULL, col = "gray", lty = "dotted")

# Ajouter des légendes si nécessaire
legend("topright",                                    # Position de la légende
       legend = c("Points", "Régression"),            # Texte de la légende
       col = c("blue", "red"),                        # Couleur des éléments de la légende
       pch = c(19, NA),                               # Symboles des points
       lty = c(NA, 1))                                # Types de lignes


# NETTOYAGE ################################################

# Nettoyer l'environnement de travail
rm(list = ls())

