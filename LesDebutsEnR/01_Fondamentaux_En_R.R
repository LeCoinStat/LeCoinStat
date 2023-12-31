###################################################################################
# Introduction à R et Rstudio
# Partie 1 Fondamentaux en R
# Par: Natacha NJONGWA YEPNGA - LeCoinStat https://www.youtube.com/c/LeCoinStat
# Linkedin: https://www.linkedin.com/in/natacha-njongwa-yepnga/?originalSubdomain=fr
###################################################################################

# Création de variables simples
# Assignation d'un nombre à une variable
nombre <- 10
print("Nombre:")
print(nombre)
nombre

variabe <- "test"

variable2= "Test"
# Affectation avec "<-"
# C'est la méthode traditionnelle d'affectation en R.
# Elle est largement utilisée dans la communauté R pour sa lisibilité et sa tradition.
nombre <- 15
print("Affectation avec '<-':")
print(nombre)

# Affectation avec "="
# Elle est plus commune dans d'autres langages de programmation comme Python.
# En R, "=" est principalement utilisée dans les arguments des fonctions.
nombre = 20
print("Affectation avec '=':")
print(nombre)
nombre
# Différences entre "<-" et "="
# -----------------------------

# 1. Lisibilité:
# "<-" est souvent considéré comme plus lisible, en particulier dans les scripts R.
# Cela aide à distinguer l'affectation des paramètres dans les appels de fonction.




# Assignation d'une chaîne de caractères à une variable
texte <- "Bonjour le monde"
print("Texte:")
print(texte)

# Affichage direct sans utiliser print()
texte

# Création de vecteurs
# Un vecteur est une collection de valeurs du même type
vecteur_numerique <- c(1, 2, 3, 4, 5,10)
print("Vecteur Numérique:")
print(vecteur_numerique)
dernierevaleur<-vecteur_numerique[3]

vecteur_texte <- c("Alice", "Bob", "Charlie")
print("Vecteur de Texte:")
print(vecteur_texte)
vecteur_texte[3]

# Utilisation de seq() pour créer une séquence
sequence <- seq(1, 100000)
print("Séquence de 1 à 10:")
print(sequence)

# Utilisation de rep() pour répéter des valeurs
repetition <- rep(x = 3, times = 10)
print("Répétition du nombre 3, cinq fois:")
print(repetition)

# Opérations arithmétiques de base
somme <- 5 + 3
somme
difference <- 10 - somme
difference
produit <- 7 * 2
produit
quotient <- produit / somme
quotient
# Affichage des résultats des opérations
print("Somme:")
print(somme)
print("Différence:")
print(difference)
print("Produit:")
print(produit)
print("Quotient:")
print(quotient)




# Définition d'une fonction simple
# La fonction 'addition' prend deux arguments et renvoie leur somme
addition <- function(nombre1, nombre2) {
  resultat <- nombre1 + nombre2
  return(resultat)
}

# Utilisation de la fonction 'addition'
somme <- addition(5, 3)
resultat<-addition(somme, somme)
resultat
print("Résultat de l'addition de 5 et 3:")
print(somme)


# NETTOYAGE ################################################

# Nettoyer l'environnement de travail
rm(list = ls())


