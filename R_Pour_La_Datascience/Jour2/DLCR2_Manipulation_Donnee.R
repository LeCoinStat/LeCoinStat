# Importaion du fichier client

clients <- read.csv("/Volumes/DisqueNNY2T/LeCoinStat/DLCR/Jour2/data/Base_Clients.csv", sep = ";", dec =".")
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



