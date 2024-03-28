# Importaion du fichier client

clients <- read.csv("/Volumes/DisqueNNY2T/LeCoinStat/DLCR/Jour2/data/Base_Clients.csv", sep = ";", dec =".")
View(clients)
# Imporation de la base vente
vente <- read.csv("/Volumes/DisqueNNY2T/LeCoinStat/DLCR/Jour2/data/Base_Ventes.csv", sep = ";", dec =".")
View(vente)

# Importation fichier excel
install.packages("readxl")
library(readxl)
test <- read_excel("/Volumes/DisqueNNY2T/LeCoinStat/DLCR/Jour2/data/Base_Clients.xlsx")


# 5 premiers clients de la table 
head(clients, 5)

# 5 derniers clientd de la table
tail(clients, 5)

# Structrure de la base de données
str(vente)

# Nombre de ligne 
nrow(clients)
nrow(vente)

# nombre de colonne
ncol(clients)
ncol(vente)
dim(clients)
# nom des colonne
nom_colonne_client <- colnames(clients)

nom_colonne_vente <- colnames(vente)

# Description rapide de la base de donnée
summary(vente)
clients$AgeGroup <- as.factor(clients$AgeGroup)
clients$EducationLevel <- as.factor(clients$EducationLevel)
summary(clients)

# Les groupes de la base de données
unique(clients$AgeGroup)
# Nombre d'individu par groupe
categorie_stat <- table(clients$AgeGroup)
prop.table(categorie_stat)

summary()

# Nombre de valeur manquante sur le groupe d'âge
sum(is.na(clients$AgeGroup))
# Nombre de valeur manquante sur le groupe d'âge
sum(is.na(clients$EducationLevel))
summary(vente)
# Nombre de valeur manquante sur la base de donnée
colSums(is.na(vente))

# Remplacer la valeur manquante sur le prix par la valeur zero
venteb <- vente
venteb$Price[is.na(venteb$Price)] <- 0
colSums(is.na(venteb))

# Supprimer les valeurs manquantes
ventec <- na.omit(vente)
dim(ventec)
colSums(is.na(ventec))

# Charger le package dplyr
library(dplyr)
# Renommer la colonne name en nom
rename(clients, "Nom" = "Name")
View(clients)

colnames(clients)[2] <- "Nombis"

View(vente)
# Créer la colonne montantTotal
vente$MontantTotal <- vente$Quantity * vente$Price

# CA total
sum(vente$MontantTotal, na.rm = T)
View(vente)

# Liste des produits dont le prix est supérieur à 40
liste_produit <- vente[vente$Price > 40, ]

liste_produit <- vente[vente$Price > 40, c("CustomerID", "ProductID")]
View(clients)
# Donner la liste des clients premium
liste_premium <- clients[clients$CustomerCategory == "Premium", ]
liste_premium

liste_client_premium <- clients %>% filter(CustomerCategory == "Premium")
liste_client_premium <- filter(clients, CustomerCategory == "Premium")

# Joindre les deux tables
jointure <- left_join(vente, clients, by = "CustomerID")
jointure <- inner_join(vente, clients, by = "CustomerID")

jointure <- merge(vente, clients, by ="CustomerID")
View(jointure)
colnames(clients)
# Somme de CA par type client
summarise(group_by(jointure,CustomerCategory), nb =n())
jointure %>% group_by(CustomerCategory) %>% summarise(somme = sum(MontantTotal, na.rm = T), moyenne = mean(MontantTotal, na.rm = T), nombre = n())

# Liste des produits dont le prix est supérieur à 40 sans les valeurs manquantes
liste_produit <- vente[(vente$Price > 40) & is.na(vente$Price) == FALSE, ]
View(liste_produit)
View(vente)

# graphique
require(stats) # for lowess, rpois, rnorm
require(graphics) # for plot methods

# Relation entre la quantité et le prix
plot(x=jointure$Quantity, y = jointure$Price, xlab = "Quantité", ylab = "Prix", main = "Quantite en fonction du prix", type ="l", col ="blue")

library(ggplot2)


# Les 7 éléments clés de la structure d'un graphique avec ggplot2 sont :
# 1. Le jeu de données : spécifié dans ggplot(data = <données>)
# 2. Les esthétiques (aes) : définissent comment les variables sont mappées sur les aspects visuels tels que x, y, couleur, forme, etc. (aes(x = <variable_x>, y = <variable_y>, color = <variable_couleur>, ...))
# 3. Les couches (layers) : comprennent les objets géométriques (geoms) pour le type de graphique (points, lignes, barres, etc.), les statistiques (stat), et les positions (position)
# 4. Les échelles (scales) : contrôlent le mappage des esthétiques aux valeurs visuelles (échelles de couleurs, échelles de taille, etc.)
# 5. Les systèmes de coordonnées (coord) : ajustent la manière dont l'espace du graphique est utilisé et vu (par exemple, coord_cartesian(), coord_polar(), etc.)
# 6. Les facettes (facets) : pour créer des graphiques en grille basés sur une ou plusieurs variables de regroupement
# 7. Les thèmes (theme) : permettent de personnaliser l'apparence du graphique (couleurs de fond, polices, lignes des axes, etc.)
# Première approche
ggplot(data = jointure, aes(x = Quantity, y = Price, fill = CustomerCategory)) +
  geom_point( size = 3)+
  scale_color_manual(values = c("blue","red","green","grey"))+
  facet_wrap(~CustomerCategory)



ggplot(data = jointure, aes(x = Quantity, y = Price)) +
  geom_point(col = "red", size = 3)+
  xlab(label = "Quantite")+
  ylab(label ="Prix")+
  ggtitle("Quantité en fonction du prix")
?ggplot

# Histogramme avec une fonction native
hist(jointure$Price)
ggplot(data = jointure, aes(Price))+
  geom_histogram(bins = 40, color = "blue", aes(fill=CustomerCategory))+
  facet_grid(vars(CustomerCategory))

# Boxplot avec les fonctions natives
boxplot(Price ~ CustomerCategory, data = jointure)
?boxplot
list_variable <- c("Price", "Quantite")
for (i  in list_variable) {
  
}

# Couleurs par catégorie
ggplot(data = jointure, aes(x=CustomerCategory, y=Price))+
  geom_boxplot(aes(fill = CustomerCategory))
  

# Couleurs par catégorie changer les couleurs manuellement
ggplot(data = jointure, aes(x=CustomerCategory, y=Price))+
  geom_violin(aes(fill = CustomerCategory))+
  scale_fill_manual(values = c("blue", "red", "green", "grey"))

# Repartition des groupes d'âge

# Fonction native
jointure$AgeGroup <- as.factor(jointure$AgeGroup)
barplot(table(jointure$AgeGroup))

ggplot(data = jointure, aes(AgeGroup))+
  geom_bar()

ggplot(data = jointure, aes(AgeGroup))+
  geom_col()

# Principaux packages du tidyverse :
# - ggplot2 : Création intuitive de visualisations de données complexes.
# - dplyr : Manipulation de données (filtrage, sélection, réarrangement).
# - tidyr : Transformation des données pour les rendre "tidy" (ordonnées), optimisant leur analyse.
# - readr : Importation rapide et facile de données depuis des fichiers plats (CSV, etc.).
# - purrr : Programmation fonctionnelle pour un code plus clair.
# - tibble : Une version moderne du dataframe avec une impression et sous-ensemble améliorés.
# - stringr : Manipulation de chaînes de caractères.
# - forcats : Gestion de données catégorielles avec des facteurs.
# - lubridate : Manipulation simplifiée des dates et heures.

# Date en avec lubridate
View(jointure)
str(jointure)

library(lubridate)
jointure$datebis <- dmy_hm(jointure$Date)
jointure$datebis2 <- as.Date(jointure$datebis)
str(jointure)
# obtenir le mois
mois <- month(jointure$datebis2)
jour <- day(jointure$datebis2)
annee <- year(jointure$datebis2)



# Utiliser des chaîne de caractère en R
library(stringr)
ma_chaine <- "Bienvenue sur LeCoinStat"
str_c("Letter: ", letters)

fruit <- c("apple", "banana", "pear", "pineapple")
str_like(fruit, "app")
str_like(fruit, "app%")
str_like(fruit, "ba_ana")
str_like(fruit, "%APPLE")



str_length(ma_chaine)
# Exemple de dataframe
set.seed(123) # Pour la reproductibilité
df <- data.frame(
  var1 = rnorm(100),
  var2 = rnorm(100, mean = 2),
  var3 = rnorm(100, mean = -1, sd = 2)
)

# Liste des noms de variables pour lesquelles tu veux des boxplots
variables <- names(df)

# Boucle pour générer un boxplot pour chaque variable
for(var in variables) {
  p <- ggplot(df, aes_string(x = "factor(1)", y = var)) +
    geom_boxplot() +
    labs(title = paste("Boxplot de", var),
         x = "",
         y = var) +
    theme_minimal()
  
  # Afficher le plot
  print(p)
  ggsave()
}
