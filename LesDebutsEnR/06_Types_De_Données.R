###################################################################################
# Introduction à R et Rstudio
# Partie 5 Les Bases Pour Programmer en R
# Par: Natacha NJONGWA YEPNGA - LeCoinStat https://www.youtube.com/c/LeCoinStat
# Linkedin: https://www.linkedin.com/in/natacha-njongwa-yepnga/?originalSubdomain=fr
###################################################################################


# TYPES DE DONNÉES EN R #####################################

# Nombres entiers et décimaux
entier <- 42  # Exemple d'un nombre entier
decimal <- 3.14  # Exemple d'un nombre décimal
cat("Entier:", entier, "Decimal:", decimal, "\n")
# Utilité en data science : Utilisés pour les calculs numériques, analyses statistiques et modélisations.
typeof(decimal)
# Chaînes de caractères
chaine_simple <- "Bonjour"
chaine_longue <- "Ceci est une chaîne de caractères plus longue."
typeof(chaine_longue)
cat("Chaîne simple:", chaine_simple, "\n")
cat("Chaîne longue:", chaine_longue, "\n")
# Utilité en data science : Idéales pour gérer les données textuelles, catégorisation et traitement du langage naturel.

# Valeurs booléennes
verite <- TRUE
faux <- FALSE
cat("Vérité:", verite, "Faux:", faux, "\n")
# Utilité en data science : Essentielles pour les tests logiques, filtrages de données et décisions algorithmiques.

# STRUCTURES DE DONNÉES EN R ###############################

# Vecteurs
vecteur_num <- c(1, 2, 3)
vecteur_char <- c("un", "deux", "trois")
cat("Vecteur numérique:", vecteur_num, "\n")
cat("Vecteur de caractères:", vecteur_char, "\n")
# Utilité en data science : Stockent des séries de données pour des analyses et manipulations efficaces.
# Accéder à un élément : vecteur_num[1], vecteur_char[2]

# Matrices
matrice_num <- matrix(1:4, nrow = 2)
cat("Matrice numérique:\n")
print(matrice_num)
# Utilité en data science : Utiles pour les calculs matriciels, opérations linéaires et représentation de données.
# Accéder à un élément : matrice_num[1, 2]

# Listes
liste_mixte[[5]]
liste_mixte <- list(nombre = 42, texte = "R", logique = TRUE,autre="exemple",matrice=matrice_num)
cat("Liste mixte:\n")
print(liste_mixte)
# Utilité en data science : Permet de stocker une collection hétérogène de données, utile pour des données complexes.
# Accéder à un élément : liste_mixte$nombre, liste_mixte[[2]]

# Data Frames
df_exemple <- data.frame(id = 1:3, nom = c("Alice", "Bob", "Charlie"), age = c(25, 32, 37), test = c(25, 33, 37))
cat("Data Frame:\n")
View(df_exemple)
typeof(df_exemple)
df_exemple[1,1]
# Utilité en data science : Fondamental pour la manipulation de données tabulaires, analyses statistiques et modélisations.
# Accéder à un élément : df_exemple$age, df_exemple[["nom"]], df_exemple[1,3]

# COERCITION ET MANIPULATION DE TYPES ######################

# Coercition de type
num_en_char <- as.character(42)
typeof(char_en_num)
char_en_num <- as.numeric("12333")
cat("Numérique en caractère:", num_en_char, "\n")
cat("Caractère en numérique:", char_en_num, "\n")

# Manipulation de vecteur
vecteur_num[3] <- 45  # Modification du deuxième élément
cat("Vecteur numérique modifié:", vecteur_num, "\n")

# Manipulation de data frame
df_exemple$age <- df_exemple$age + 1  # Augmenter l'âge de tous les individus de 1
cat("Data Frame avec âge modifié:\n")
print(df_exemple)

# NETTOYAGE ET ORGANISATION #################################

# Nettoyage de l'environnement de travail
rm(list = ls())  # Supprime toutes les variables

