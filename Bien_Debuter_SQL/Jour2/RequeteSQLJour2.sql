-- Création de la table "Clients"
CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    Nom VARCHAR(200),
    Prenom VARCHAR(200),
    Adresse VARCHAR(200),
    Email VARCHAR(200),
    NumeroTelephone VARCHAR(30)
);




-- Création de la table Fournisseurs
CREATE TABLE Fournisseurs (
	FournisseurID INT PRIMARY KEY,
    NomFournisseur VARCHAR(200),
    Adresse VARCHAR(100),
    Email VARCHAR(200),
    NumeroTelephone VARCHAR(200)
    ) ;
    
-- Creation de la table employe
CREATE TABLE Employes (
	EmployeID INT PRIMARY KEY,
    Nom VARCHAR(200),
    Prenom VARCHAR(200),
    Fonction VARCHAR(200),
    Email VARCHAR(200),
    NuméroTelephone VARCHAR(200)
    ) ;
    
 
 -- Insertion des données dans les table fournisseurs
 -- INSERT INTO Fournisseurs (FournisseurID, NomFournisseur, Adresse, Email, NumeroTelephone)
 -- VALUES (1233, "Steve", "Rue Voltaire", "steve2024@gmail.com", "07 54 34, 72"),
-- (1444, "Arthur", "Rue Lumière", "arthur024@gmail.com", "07 54 34, 72");
 
 -- Modification de la table Produits pour intégrer l'identifiant du fournisseur
 -- Création de la table "Produits"
CREATE TABLE Produits (
    ProduitID INT PRIMARY KEY,
    NomProduit VARCHAR(200),
    Description TEXT,
    PrixUnitaire DECIMAL(10, 2),
   FournisseurID INT,
   FOREIGN KEY(FournisseurID)  REFERENCES Fournisseurs(FournisseurID)
);


 -- Modification de la création de la table vente pour intégrer l'identifiant de l'employe
CREATE TABLE Ventes (
    VenteID INT PRIMARY KEY,
    DateVente DATE,
    ClientID INT,
    ProduitID INT,
    EmployeID INT,
    FOREIGN KEY(ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY(ProduitID)  REFERENCES Produits(ProduitID),
    FOREIGN KEY(EmployeID) REFERENCES Employes(EmployeID),
    QuantiteVendue INT,
    MontantTotal DECIMAL(10, 2)
);

-- Lire des informations dans la base

/*======================================================*/
/*                 Maîtriser la clause SELECT           */
/*======================================================*/

/*======================================================*/
/* Fonctionnalité 1: Sélectionner toutes les informations d'une table 
Syntaxe générale:
SELECT *
FROM nom_table;
*/
/*======================================================*/

-- QUESTION 1: Donner la table complète des produits vendus par l'entreprise 
SELECT *
FROM Produits;

-- QUESTION 2: Donner la table complète des clients de l'entreprise
SELECT *
FROM Clients;

/*======================================================*/
/* Fonctionnalité 2: Sélectionner une seule colonne
Syntaxe générale:
SELECT nom_colonne
FROM nom_table;
*/
/*======================================================*/

-- QUESTION 3: Donner le nom de tous les produits de la base de données
SELECT NomProduit
FROM Produits;


-- QUESTION 4: Donner le nom de tous les fournisseurs de la base de données
SELECT NomFournisseur
FROM Fournisseurs;


SELECT NomFournisseur, FournisseurID,Email, Adresse
FROM Fournisseurs;
 
/*======================================================*/
/* Fonctionnalité 3: Sélectionner deux ou plusieurs colonnes
Syntaxe générale:
SELECT nom_colonne1, nom_colonne2,..., nom_colonne3
FROM nom_table;
======================================================*/

-- QUESTION 5: Donner le nom et le prénom des employés de l'entreprise
-- QUESTION 6: Donner le nom, le prix et la description de tous les produits

/*======================================================*/
/* Fonctionnalité 4: Sélectionner des valeurs distinctes
Syntaxe générale:
SELECT DISTINCT nom_colonne
FROM nom_table;
======================================================*/

-- QUESTION 7: Donner les différentes dates auxquelles des ventes ont été réalisées
SELECT DISTINCT *
FROM Ventes;

-- QUESTION 8: Donner les noms et prénoms distincts des employés de l'entreprise
SELECT DISTINCT Nom, Prenom
FROM Employes

/*==========================================================================================*/
/*                 Maîtriser la clause WHERE POUR FILTRER suivant des conditions           */
/*==========================================================================================*/

/*======================================================*/
/* Fonctionnalité 6: Filtrer suivant une condition
Syntaxe générale:
SELECT nom_colonne
FROM nom_table
WHERE condition;
======================================================*/
-- Liste produit vendu 
SELECT *
FROM Produits
WHERE PrixUnitaire = 50;

-- Liste produit vendu est à > 200

SELECT *
FROM Produits
WHERE PrixUnitaire > 200;

-- Liste produit vendu est à <= 200
SELECT *
FROM Produits
WHERE PrixUnitaire <= 200;

-- Liste produit vendu compris et 50 et 100
SELECT *
FROM Produits
WHERE PrixUnitaire >=50 AND PrixUnitaire <=100;

-- QUESTION 9: Information sur le produit "Nike Air Max" 
SELECT *
FROM Produits
WHERE NomProduit = "Nike Air Max";

-- QUESTION 10: Donner la liste des produits du fournisseur numéro 13
SELECT *
FROM Produits
WHERE FournisseurID = 13;

-- Description des produits du fournisseur numéro 13
SELECT DescProduit
FROM Produits
WHERE FournisseurID = 13;



/*======================================================*/
/* Fonctionnalité 7: Utilisation de plusieurs conditions avec AND et OR
Syntaxe générale:
SELECT nom_colonne
FROM nom_table
WHERE condition1 AND/OR condition2;
======================================================*/
-- Liste des produits vendu par le fournisseur 13 ou par le fournisseur 11
SELECT *
FROM Produits
WHERE FournisseurID=13 OR FournisseurID=11

/*======================================================*/
/* Fonctionnalité 8: Utilisation de IN dans la clause WHERE
Syntaxe générale:
SELECT nom_colonne
FROM nom_table
WHERE nom_colonne IN (valeur1, valeur2, ...);
======================================================*/
SELECT *
FROM Produits
WHERE FournisseurID IN (13, 15, 55, 45, 89, 88);

/*======================================================*/
/* Fonctionnalité 9: Utilisation de BETWEEN dans la clause WHERE
Syntaxe générale:
SELECT nom_colonne
FROM nom_table
WHERE nom_colonne BETWEEN valeur1 AND valeur2;
======================================================*/

-- Sélectionner les ventes réalisées entre le 1er janvier 2021 et le 31 décembre 2023
SELECT *
FROM Ventes
WHERE dateVente BETWEEN "2021-01-10" AND "2021-03-31";


/*======================================================*/
/* Fonctionnalité 10: Utilisation de LIKE dans la clause WHERE
Syntaxe générale:
SELECT nom_colonne 
FROM nom_table 
WHERE nom_colonne LIKE 'motif';
======================================================*/
-- Nom des clients qui commencent par la lettre c
SELECT *
FROM Clients
WHERE Nom like "c%";

-- Nom des clients qui commencent par la lettre c et qui se termine par a
SELECT *
FROM Clients
WHERE Nom LIKE "c%a" ;

SELECT *
FROM Clients
WHERE Nom LIKE "c%" AND Prenom LIKE "%y";

-- Le nom contient la lettre n
SELECT *
FROM Clients
WHERE Nom LIKE "%n%";

-- Le nom contient  "on"
SELECT *
FROM Clients
WHERE Nom LIKE "%on%";

-- Donner la liste des produits qui commencent par 'a'
-- Donner la liste des produits qui contiennent la lettre 'a'
-- Donner la liste des produits commençant par 'N' et finissant par 'x'

/*==========================================================================================
                 Maîtriser la clause ORDER BY POUR CLASSER
Syntaxe générale:
SELECT nom_colonne
FROM nom_table
WHERE condition
ORDER BY nom_colonne [ASC | DESC], autre_nom_colonne [ASC | DESC], ...;
==========================================================================================*/

-- Donner la liste des produits du moins coûteux au plus coûteux
SELECT *
FROM Produits
ORDER BY prixUnitaire ;
-- Donner la liste des produits du prix le plus élevé au prix le moins élevé
SELECT *
FROM Produits
ORDER BY prixUnitaire DESC;

-- Liste des employés ordre alphabétique le nom t décroissant prénom
SELECT *
FROM Employes
ORDER BY nom, prenom DESC;

-- La liste des produits dont le prix est supérieur à 200, résultat par alphabétqiue suivant le nom du produit
SELECT *
FROM Produits
WHERE PrixUnitaire >200
ORDER BY NomProduit;