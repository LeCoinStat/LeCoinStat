###################################################################################
# Introduction à R et Rstudio
# Partie 3 Visualisation des données 
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
donnees_csv <- read.csv("/Users/natachanjongwayepnga/Documents/GitHub/LeCoinStat/LesDebutsEnR/data/donnees_entreprise.csv",sep = ",",dec=".",header = TRUE)
?read.csv
View(donnees_csv)



donnees_csv$Departement<-as.factor(donnees_csv$Departement)
donnees_csv$Performance<-as.factor(donnees_csv$Performance)

# Visualisation des variables qualitatives --------------------------------

# Barchart
barplot(donnees_csv$Departement) # Ne marche pas 

# Tracer le barchart
#Deux étapes:
#Etape 1: faire une table de fréquence
# Compter le nombre d'employés par département
effectifs_departement <- table(donnees_csv$Departement)
effectifs_departement

barplot(effectifs_departement)

barplot(effectifs_departement, 
        main = "Nombre d'employés par département", 
        xlab = "Département", 
        ylab = "Nombre d'employés", 
        col = "steelblue", 
        las = 2) # Rotation des étiquettes de l'axe des x


plot(effectifs_departement)

#Pour avoir les proportions

# Calculer les proportions
proportions_departement <- prop.table(effectifs_departement)

# Tracer le barchart des proportions
bp <- barplot(proportions_departement, 
              main = "Proportion d'employés par département", 
              xlab = "Département", 
              ylab = "Proportion d'employés", 
              col = "steelblue", 
              las = 2) # Rotation des étiquettes de l'axe des x

# Ajouter des étiquettes de valeur sur chaque barre
text(bp, proportions_departement, pos = 3, cex = 0.8, labels = round(proportions_departement, 2))



# Pie Chart


# Créer un diagramme circulaire (pie chart) avec des étiquettes de valeur
pie(proportions_departement, 
    main = "Répartition des employés par département", 
    col = rainbow(length(effectifs_departement)), # Utiliser des couleurs différentes pour chaque segment
    clockwise = TRUE, # Les segments sont dessinés dans le sens des aiguilles d'une montre
    labels = paste(round(proportions_departement * 100), "%")) # Ajouter des étiquettes avec des pourcentages

# Ajouter une légende pour le diagramme
legend("topright", 
       legend = names(effectifs_departement), 
       fill = rainbow(length(effectifs_departement)),
       title = "Départements")



# Visualisation des variables quantitatives -------------------------------

# Création d'un histogramme pour visualiser la distribution de la variable 'Salaire'
hist(donnees_csv$Salaire)

hist(donnees_csv$Salaire, 
     main = "Histogramme des Salaires", 
     xlab = "Salaire", 
     col = "lightblue", 
     border = "black")

# Courbe de densité
# -----------------
# Création d'une courbe de densité pour la même variable 'Salaire'
density_plot <- density(donnees_csv$Salaire)
plot(density_plot, main = "Courbe de densité des Salaires", xlab = "Salaire", ylab = "Densité")

# Boxplots
# --------
# Création d'un boxplot pour visualiser la distribution de la variable 'Salaire'
boxplot(donnees_csv$Salaire)

boxplot(donnees_csv$Salaire, 
        main = "Boxplot des Salaires", 
        ylab = "Salaire", 
        col = "red", 
        horizontal = F)


# Visualisation quantitative vs quantitative ------------------------------
#Objectif: linearité, outlier, correlation, étendu
# Nuage de points (scatterplot) pour comparer 'Age' et 'Salaire'
plot(donnees_csv$Age, donnees_csv$Salaire, 
     main = "Relation entre Age et Salaire",  # Titre du graphique
     xlab = "Age",                            # Étiquette pour l'axe des x (Age)
     ylab = "Salaire",                        # Étiquette pour l'axe des y (Salaire)
     pch = 16,                                # Type de symbole utilisé pour les points
     col = "blue")                            # Couleur des points

# Visualisation quantitative qualitative ----------------------------------

# Boxplot pour comparer 'Salaire' dans différents 'Departement'
boxplot(donnees_csv$Salaire ~ donnees_csv$Departement, 
        main = "Salaire par Département",    # Titre du graphique
        xlab = "Département",                # Étiquette pour l'axe des x (Département)
        ylab = "Salaire",                    # Étiquette pour l'axe des y (Salaire)
        col = "lightgreen")                  # Couleur des boîtes



# Superposition des graphiques en R ---------------------------------------



# Création d'un histogramme 
hist(donnees_csv$Salaire, 
     main = "Histogramme et Courbe de Densité du Salaire", 
     xlab = "Salaire", 
     ylab = "Fréquence", 
     col = "lightblue", 
     border = "black", 
     prob = TRUE)  # prob = TRUE pour obtenir un histogramme de densités

# Calcul de la courbe de densité
densite <- density(donnees_csv$Salaire)

# Ajout de la courbe de densité à l'histogramme
lines(densite, col = "red", lwd = 2)
lines(densite, col = "green", lwd = 2)

# Ajout d'une légende
legend("bottomright", 
       legend = c("Histogramme", "Courbe de Densité"), 
       col = c("lightblue", "red"), 
       lwd = c(2 ,2),
       cex = 0.8)

# Cette méthode permet de superposer différents types de graphiques.
# Ici, une ligne de régression linéaire (rouge) est ajoutée sur le nuage de points (bleu).

# Mettre plusieurs graphiques sur une même fenêtre ------------------------

# Définition des paramètres graphiques pour afficher 2 graphiques sur une grille 1x2
par(mfrow = c(3, 3))
?par
# Premier graphique : Histogramme de 'Age'
hist(donnees_csv$Age, main = "Histogramme de l'Age", xlab = "Age", col = "lightblue")

# Deuxième graphique : Boxplot de 'Salaire'
boxplot(donnees_csv$Salaire, main = "Boxplot des Salaires", ylab = "Salaire", col = "lightgreen")
# Deuxième graphique : Boxplot de 'Salaire'
boxplot(donnees_csv$Age, main = "Boxplot des Salaires", ylab = "Salaire", col = "lightgreen")
boxplot(donnees_csv$Taux_Absentéisme, main = "Boxplot des Salaires", ylab = "Salaire", col = "lightgreen")

# La fonction 'par(mfrow = c(n, m))' est utilisée pour spécifier une matrice de n lignes et m colonnes
# pour afficher plusieurs graphiques dans une seule fenêtre graphique.

# NETTOYAGE ################################################

# Nettoyer l'environnement de travail
rm(list = ls())
