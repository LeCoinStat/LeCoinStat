-- Liste des clients dont le nom contient une seule fois la lettre A
SELECT Nom
FROM Clients
WHERE Nom LIKE "%a%" AND  Nom NOT LIKE "%a%a%";

-- Contient deux occurrences de la lettre A

SELECT count(*)
FROM Clients
WHERE  Nom  LIKE "%A%A%";


/*==================================================================================
               Maîtriser les expressions régulières en SQL
==================================================================================*/

-- Expressions régulières en SQL permettent de faire des recherches de texte complexes.

/*======================================================
Fonctionnalité 1: Recherche basique avec REGEXP
Syntaxe générale:
SELECT nom_colonne
FROM nom_table
WHERE nom_colonne REGEXP 'pattern';
======================================================*/

-- Liste des produits qui contiennent "TV" (deux possibilités avec LIKE)
SELECT count(*)
FROM Produits
WHERE NomProduit LIKE "%TV%";

-- Avec REGEXP
SELECT count(*)
FROM Produits
WHERE NomProduit REGEXP "TV";

/*======================================================
Pour indiquer le début d'une chaîne de caractères, utilisez le caractère "^" au début de l'expression.
======================================================*/

-- Liste des produits dont le nom commence par la lettre "D"
SELECT count(*)
FROM Produits
WHERE NomProduit LIKE "D%";


-- Avec une expression régulière
SELECT count(*)
FROM Produits
WHERE NomProduit REGEXP "^D";

/*======================================================
Pour indiquer la fin d'une chaîne de caractères, utilisez le caractère "$" à la fin de l'expression.
======================================================*/

-- Liste des produits qui se terminent par "M"
SELECT count(*)
FROM Produits
WHERE NomProduit LIKE "%M";

-- Avec une expression régulière
SELECT count(*)
FROM Produits
WHERE NomProduit REGEXP "M$";

/*======================================================
Rechercher plusieurs patterns dans la chaîne de caractères en utilisant le symbole "|"
======================================================*/

-- Liste des clients dont le numéro contient "05" ou "04"
SELECT count(*)
FROM Clients
WHERE NumeroTelephone LIKE "%05%" OR NumeroTelephone LIKE "%04%" ;

-- Avec REGEXP
SELECT count(*)
FROM Clients
WHERE NumeroTelephone REGEXP "05|04" ;

-- Avec REGEXP
SELECT *
FROM Clients
WHERE NumeroTelephone REGEXP "05|04|09|20" ;

/*======================================================================
Exercice 1: Liste des clients dont le numéro commence par "05" ou se termine par "94"
======================================================================*/

-- Avec LIKE
SELECT *
FROM Clients
WHERE NumeroTelephone LIKE "05%" OR NumeroTelephone LIKE "%94";

-- Avec REGEXP
SELECT *
FROM Clients
WHERE NumeroTelephone REGEXP "^05|94$";

/*======================================================================
Utilisation des caractères spéciaux "." (n'importe quel caractère)
Syntaxe générale:
SELECT nom_colonne
FROM nom_table
WHERE nom_colonne REGEXP 'pattern';
======================================================================*/

-- Exemple: Sélectionner les clients dont le nom contient 'R' suivi de n'importe quel caractère et ensuite 'a'

-- Avec LIKE (underscore)
SELECT count(*)
FROM Clients
WHERE Nom LIKE "%R_a%";

-- Avec REGEXP
SELECT *
FROM Clients
WHERE Nom REGEXP "R.A";

/*======================================================================
Exercice: Liste des clients dont le nom commence par "R" et se termine par "A"
======================================================================*/

-- Avec LIKE
SELECT *
FROM Clients
WHERE Nom LIKE "R%A";

-- Avec REGEXP
SELECT *
FROM Clients
WHERE Nom REGEXP "R.*A$";

/*======================================================================
Astuces: []
======================================================================*/

-- Liste des clients dont le nom contient "it" ou "ie" ou "il" ou "is" 
SELECT *
FROM Clients
WHERE Nom LIKE "%ie%" OR Nom LIKE "%it%" OR Nom LIKE "%il%" OR Nom LIKE "%is%";

-- Liste des clients dont le nom contient n'importe quelle lettre de 'a' à 'g' suivie de 'l'
SELECT *
FROM Clients
WHERE Nom REGEXP "i[a-g]";

SELECT *
FROM Clients
WHERE Nom REGEXP "[etls]i";

/*======================================================================
Limitation des résultats d'une requête avec LIMIT
SELECT nom_colonnes
FROM nom_table
WHERE conditions 
LIMIT nombre_de_lignes;

======================================================================*/

-- Donner la liste des 10 premiers clients par ordre alphabétique
SELECT *
FROM Clients
ORDER BY Nom
LIMIT 10000;


-- Donner la liste des 10 produits les plus chers
SELECT *
FROM Produits
ORDER BY PrixUnitaire DESC 
LIMIT 10;

-- Donner la liste des 10 produits les plus moins
SELECT *
FROM Produits
ORDER BY PrixUnitaire  
LIMIT 10;


/*==================================================================================
               Maîtriser les fonctions d'agrégation en SQL
==================================================================================*/

/*======================================================
Fonctions d'agrégation en SQL
======================================================*/

-- Les fonctions d'agrégation en SQL sont utilisées pour effectuer des calculs sur un ensemble de valeurs dans une colonne. Elles sont couramment utilisées pour obtenir des statistiques résumées à partir des données.

/*======================================================
Fonction COUNT()
======================================================*/

-- La fonction COUNT() permet de compter le nombre de lignes dans un ensemble de données.

-- Question: Combien y a-t-il de clients dans la base de données ?
SELECT COUNT(*) AS "NombreClient"
FROM Clients;

SELECT COUNT(ClientID) AS "NombreClient"
FROM Clients;


/*======================================================
Fonction SUM()
======================================================*/

-- Exemple: Calculer la somme totale des ventes dans la table "Ventes".
SELECT SUM(MontantTotal) AS Somme_CA
FROM Ventes;

/*======================================================
Fonction AVG()
======================================================*/

-- Déterminer la moyenne des ventes.
SELECT AVG(MontantTotal) AS AVG_CA
FROM Ventes;
/*======================================================
Fonction MIN() et MAX()
======================================================*/

-- Les fonctions MIN() et MAX() permettent de trouver la valeur minimale et maximale dans une colonne, respectivement.
SELECT MIN(MontantTotal) AS MIN_CA
FROM Ventes;

SELECT MAX(MontantTotal) AS MIN_CA
FROM Ventes;
-- Exemple: Quel est le produit le moins cher ? Quel est le produit le plus cher ?
SELECT MIN(MontantTotal) AS Minimum, MAX(MontantTotal) AS Maximum
FROM Ventes;

SELECT MIN(PrixUnitaire) AS Minimum, MAX(PrixUnitaire) AS Maximum
FROM Produits;
/*======================================================
Fonction SUM(DISTINCT)
======================================================*/

-- La fonction SUM(DISTINCT) permet de calculer la somme des valeurs uniques dans une colonne.
SELECT SUM(DISTINCT MontantTotal) AS Somme_CA
FROM Ventes;
-- Exemple: Calculer la somme totale des ventes uniques dans la table "Ventes".

/*======================================================
Fonction AVG(DISTINCT)
======================================================*/

-- La fonction AVG(DISTINCT) permet de calculer la moyenne des valeurs uniques dans une colonne.

-- Exemple: Calculer la moyenne des ventes uniques.
SELECT AVG(DISTINCT MontantTotal) AS MoyenneDist
FROM Ventes;
/*==================================================================================
              Maîtriser le REGROUPEMENT des Données (GROUP BY) en SQL
==================================================================================*/

-- Introduction au Regroupement des Données
-- Le regroupement des données est une fonctionnalité essentielle en SQL qui permet de regrouper les lignes de données en fonction des valeurs d'une ou plusieurs colonnes. Cette opération est souvent utilisée pour effectuer des calculs agrégés sur des groupes de données plutôt que sur l'ensemble des données.

/*Syntaxe de la Clause GROUP BY
-- La clause `GROUP BY` est utilisée pour spécifier les colonnes par lesquelles vous souhaitez regrouper vos données. La syntaxe générale est la suivante :
SELECT colonne1, colonne2, ..., fonction_agrégation(colonne)
FROM nom_table
GROUP BY colonne1, colonne2, ...; */

-- Exemple Pratique : Calculer la somme des ventes par employé.
SELECT EmployeID, SUM(MontantTotal) AS CA_Total
FROM Ventes
GROUP BY EmployeID;

-- Exemple Pratique : Compter le nombre de ventes par employé.
SELECT EmployeID, COUNT(VenteID) AS CA_Total
FROM Ventes
GROUP BY EmployeID;

-- Exemple pratique: Déterminer la somme des ventes par année.
SELECT EXTRACT(YEAR FROM DateVente) as Annee, SUM(MontantTotal) as MntTot
FROM Ventes
GROUP BY Annee
ORDER BY MntTot DESC;

SELECT YEAR(DateVente)  as Annee, SUM(MontantTotal) as MntTot
FROM Ventes
GROUP BY Annee
ORDER BY MntTot DESC;

-- Exemple Pratique : Quelle est la moyenne des ventes par année et par employé ?
SELECT YEAR(DateVente) as Annee, EmployeID, AVG(MontantTotal) as MoyenneCA
FROM Ventes
GROUP BY Annee, EmployeID;
-- Utilisation de Fonctions d'Agrégation
-- En combinaison avec la clause `GROUP BY`, vous pouvez utiliser des fonctions d'agrégation telles que SUM(), COUNT(), AVG(), MIN(), MAX(), etc., pour effectuer des calculs sur les groupes de données résultants. Cela vous permet d'obtenir des statistiques résumées par groupe.

/*======================================================
Fonction HAVING
======================================================*/

-- La clause HAVING est utilisée avec GROUP BY pour filtrer les groupes de résultats basés sur une condition agrégée.

-- Exemple: Donner la liste des employés dont la moyenne des ventes est supérieure à 1000 euros.

SELECT YEAR(DateVente) as Annee, EmployeID, AVG(MontantTotal) as MoyenneCA
FROM Ventes
GROUP BY Annee, EmployeID
HAVING MoyenneCA > 1000;

SELECT YEAR(DateVente) as Annee, EmployeID, AVG(MontantTotal) as MoyenneCA
FROM Ventes
WHERE MontantTotal > 1000
GROUP BY Annee, EmployeID
;

-- Exercice: Donner la liste des 5 employés ayant la somme des ventes la plus élevée.
SELECT EmployeID, SUM(MontantTotal) AS CA_Total
FROM Ventes
GROUP BY EmployeID
ORDER BY CA_Total
LIMIT 5;






