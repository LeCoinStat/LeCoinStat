# Ceci est un commentaire

# Création de la variable prénom
prenom <- " Sysy"
prenom

prenom <- "Prince"
# Création de la variable age
age <- 23
age = 23
# Création d'un graphique 
plot(x = c(1,2), y=c(2,3))


install.packages("shiny")
# package graphique
install.packages("ggplot2")
#Chargement du package
library(ggplot2)
require(ggplot2)
ggplot(x,y)
# Aide sur les packages en R
?ggplot
help(ggplot)

# Exemple ggplot 

set.seed(1)

sample_df <- data.frame(
  group = factor(rep(letters[1:3], each = 10)),
  value = rnorm(30)
)

group_means_df <- setNames(
  aggregate(value ~ group, sample_df, mean),
  c("group", "group_mean")
)

# The following three code blocks create the same graphic, each using one
# of the three patterns specified above. In each graphic, the sample data
# are plotted in the first layer and the group means data frame is used to
# plot larger red points on top of the sample data in the second layer.

# Pattern 1
# Both the `data` and `mapping` arguments are passed into the `ggplot()`
# call. Those arguments are omitted in the first `geom_point()` layer
# because they get passed along from the `ggplot()` call. Note that the
# second `geom_point()` layer re-uses the `x = group` aesthetic through
# that mechanism but overrides the y-position aesthetic.
ggplot(data = sample_df, mapping = aes(x = group, y = value)) +
  geom_point() +
  geom_point(
    mapping = aes(y = group_mean), data = group_means_df,
    colour = 'red', size = 3
  )


# Les types de données en R

# vecteur Create
notes <- c(20, 19, 18, 17, 9, 8, 12)
# lire le premier élement Read
notes[1]

# Deuxième élément
notes[2]

# taille d'un vecteur
length(notes)
# Dernier élément du vecteur
notes[length(notes)]
notes[7]

# Mettre à jour le vecteur
notes[6] <- 14
notes


notes[5] <- 15
notes

notebis <- notes[-c(1,2,3)]
notebis


# Supprimer un élément dans un vecteur (Delete)
notes <- notes[-3]
notes
length(notes)


notes <- c(20, 19, 18, 17, 9, 8, 12)

# ajouter une nouvelle notes
notes <- c(notes, 19)
notes
# Nom des matières
nom_matiere <- c("R", "Python", "Algèbre", "Analyse","Algèbre", "Analyse")

# Type des noms de matière
str(nom_matiere)

nom_matiere_facteur <- factor(nom_matiere)
nom_matiere_facteur
levels(nom_matiere_facteur)

# Création des listes: Create

liste_etudiants <- list(Nom = "Warys", Age = 24, Note = notes)
# Type de données
str(liste_etudiants)
# Lire les éléments de la liste
liste_etudiants$Nom
liste_etudiants$Age
liste_etudiants$Note


# liste de liste 
liste_2 <- list(Nom = "Warys", Age = 24, Note = notes)
liste_3 <- list(temp = liste_etudiants, tempbis = liste_2)
liste_3$liste_1

liste_3 <- list(liste_etudiants, liste_2)
liste_3[["temp"]]

# Créer des matrice Create
test <-1:9
matrice_1 <- matrix(1:9, ncol = 3, nrow = 3)
matrice_1

# Read
# Première ligne première colonne
matrice_1[1,1]

# Deuxième ligne troisième colonne
matrice_1[2,3]

# Accéder à la ligne
matrice_1[1,]
# Accéder à la troisième colonne

matrice_1[,3]

# Modifier la première ligne
matrice_1[1,] <- c(20,30,40)
matrice_1

# Modifier la première colonne de la matrice
matrice_1[,1] <- c(20,30,40)
matrice_1

# Deux 
matrice_1[1:2,1:2]



#  Dataframe create
df <- data.frame(Noms=c("Diouf", "Sourou", "Georges"), Age = c(28, 30, 18))
df
# Visualiser le dataframe
View(df)

# Read 
df$Noms
df$Age
df[["Noms"]]
df[["Age"]]
df[[2]]

df[1:2,2]
# 3 première ligne et la première colonne
df[1:3, 1]

# Opération mathématique
moyenne <- mean(df$Age)
moyenne
maximum <- max(df$Age)
maximum

minimum <- min(df$Age)
minimum

variance <- var(df$Age)
variance

# Productivité vecteur
temp <- 1:10
temp

# Création des séquence
temp <- seq(1,10,1)
temp

# Repétition des éléments
temp_bis <- rep(5, 10)
temp_bis

temp_bis <- rep(c(1,4), 10)
temp_bis
