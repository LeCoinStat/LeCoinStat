###################################################################################
# Introduction à R et Rstudio
# Partie 0 installation des packages
# Par: Natacha NJONGWA YEPNGA - LeCoinStat https://www.youtube.com/c/LeCoinStat
# Linkedin: https://www.linkedin.com/in/natacha-njongwa-yepnga/?originalSubdomain=fr
###################################################################################


# R est un langage et un environnement pour l'analyse statistique 
# et la création de graphiques. RStudio est une interface de 
# développement intégrée (IDE) qui facilite l'utilisation de R.

# Pour utiliser certaines fonctionnalités dans R, 
# il est souvent nécessaire d'installer des packages supplémentaires. 
# Les packages sont des ensembles de fonctions R, de données et 
# de code compilé développés par la communauté.

# Pour installer un package, utilisez la fonction install.packages(). 
# Par exemple, pour installer 'ggplot2' :

install.packages("ggplot2")


# Installer plusieurs package à la fois install.packages(c("package1", "package2", "package3"))
install.packages(c("ggplot2", "shiny", "rmarkdown"))


# Une fois le package installé, vous pouvez le charger dans votre session R 
# avec library() ou require(). La différence principale est que library() 
# génère une erreur si le package n'est pas trouvé, tandis que require() 
# retourne FALSE et affiche un avertissement sans interrompre l'exécution du script.

# Exemple avec library() :
library(ggplot2)



# Exemple avec require() :
require(ggplot2)

if (require(ggplot2)) {
  print("Le package ggplot2 est chargé avec succès.")
} else {
  print("Le package ggplot2 n'est pas disponible.")
}

# Utilisez 'require()' si vous souhaitez que votre script continue de s'exécuter 
# même si le package n'est pas trouvé, ce qui est utile pour des scripts 
# plus complexes avec des conditions optionnelles.


#  Installation d'un package disponible sur github ------------------------
#devtools::install_github("user/package")

if (!require("devtools")) install.packages("devtools")
library("devtools")
install_github("kassambara/factoextra")


# Le Package magique en R --------------------------------------------------


# Premièrement, nous devons nous assurer que 'pacman' est installé.
# 'pacman' est un package qui peut gérer les packages pour nous.

if (!require(pacman)) install.packages("pacman")

# Maintenant, nous chargeons 'pacman' pour pouvoir l'utiliser.
library(pacman)
re

# Avec 'pacman', nous pouvons installer des packages si nécessaire et les charger directement.
# Voici comment nous pouvons installer et charger le package 'ggplot2' par exemple.
p_load(ggplot2)

# La fonction 'p_load' va vérifier si 'ggplot2' est installé.
# Si ce n'est pas le cas, elle l'installera pour vous avant de le charger.
# Cela nous évite d'avoir à écrire des instructions conditionnelles chaque fois.

# Nous pouvons également installer et charger plusieurs packages en même temps.
# Par exemple, pour 'dplyr', 'tidyr', 'data.table', 'lubridate', 'caret', 'shiny', et 'rmarkdown' :
p_load(dplyr, tidyr, data.table, lubridate, caret, shiny, rmarkdown)
p_load(dplyr)


# Pour décharger un package, vous pouvez utiliser p_unload().
# Par exemple, pour décharger le package 'dplyr' :
p_unload(dplyr)

# 'p_unload()' est utile quand vous avez besoin de décharger un package 
# qui n'est plus nécessaire dans la session R actuelle.




# Comment mettre à jour et désinstaller un package -----------------------------------------

# Mettre à jour un package en R
# ------------------------------
# Pour vous assurer que vous utilisez la version la plus récente d'un package, 
# vous pouvez le mettre à jour. La fonction `update.packages()` est utilisée pour cela.
# Par exemple, pour mettre à jour le package 'ggplot2', utilisez :

update.packages("ggplot2")

# Si vous souhaitez mettre à jour tous les packages installés, vous pouvez utiliser
# la fonction sans spécifier un nom de package :

update.packages()

# Notez que la mise à jour des packages peut parfois nécessiter de redémarrer R 
# pour que les changements prennent effet.

# Désinstaller un package en R
# ----------------------------
# Pour supprimer un package que vous n'utilisez plus, utilisez la fonction `remove.packages()`.
# Par exemple, pour désinstaller 'caret', vous feriez :

remove.packages("caret")

# Après avoir exécuté cette commande, le package 'ggplot2' ne sera plus disponible 
# dans votre bibliothèque de packages R et devra être réinstallé pour être utilisé à nouveau.

# Il est important de ne supprimer que les packages dont vous êtes sûr de ne plus avoir besoin,
# car certains packages peuvent être des dépendances pour d'autres packages.


# Voilà! Nous avons installé et chargé une série de packages essentiels pour le travail de data science.
# Avec 'pacman', la gestion des packages est simplifiée et le workflow est plus propre.



# NETTOYAGE ################################################

# Nettoyer l'environnement de travail
rm(list = ls())
