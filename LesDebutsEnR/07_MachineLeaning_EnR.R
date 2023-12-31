###################################################################################
# Introduction à R et Rstudio
# Partie 6 Machine Learning En R
# Par: Natacha NJONGWA YEPNGA - LeCoinStat https://www.youtube.com/c/LeCoinStat
# Linkedin: https://www.linkedin.com/in/natacha-njongwa-yepnga/?originalSubdomain=fr
###################################################################################


# Utilisation de pacman pour la gestion des packages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(caret, ggplot2, tree,shiny)

# Chargement des données iris
data("iris")
View(iris)
summary(iris)
# Définir une graine pour la reproductibilité
set.seed(42)

# Création des ensembles d'entraînement et de test
indexes <- sample(1:nrow(iris), size = 100)
train <- iris[indexes, ]
test <- iris[-indexes, ]


# Modèle de régression linéaire
model_lin <- lm(Petal.Width ~ Petal.Length, data = train)

# Résumé du modèle
summary(model_lin)

# Visualisation des résultats de la régression
ggplot(train, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("Régression Linéaire : Largeur du Pétale vs Longueur du Pétale")


# Formation d'un modèle d'arbre de décision
model_tree <- tree(Species ~ ., data = train)
?tree
# Visualisation de l'arbre de décision
plot(model_tree)
text(model_tree)

# Prédiction avec l'arbre de décision
predictions <- predict(model_tree, newdata = test, type = "class")

# Matrice de confusion pour évaluer la classification
confusionMatrix(predictions, test$Species)


# Sauvegarde du modèle d'arbre
save(model_tree, file = "/Users/natachanjongwayepnga/Documents/GitHub/LeCoinStat/LesDebutsEnR/model_tree.RData")

# Sauvegarde des données d'entraînement
save(train, file = "/Users/natachanjongwayepnga/Documents/GitHub/LeCoinStat/LesDebutsEnR/train_data.RData")


# NETTOYAGE ET ORGANISATION #################################

# Nettoyage de l'environnement de travail
rm(list = ls())  # Supprime toutes les variables
