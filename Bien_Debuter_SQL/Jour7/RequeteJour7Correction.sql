
/*==================================================================================
            Fonctions de fenêtrage
==================================================================================*/
-- Syntaxe de Base pour les Fonctions de Fenêtrage en SQL
/*
SELECT colonnes,
       FONCTION_DE_FENETRAGE() OVER (
           PARTITION BY colonne_de_partitionnement
           ORDER BY colonne_de_tri
           RANGE | ROWS BETWEEN debut AND fin
       ) AS nom_colonne_resultat
FROM table;

Explication:
- SELECT colonnes: Spécifie les colonnes à récupérer dans le résultat final, incluant la colonne résultante de la fonction de fenêtrage.
- FONCTION_DE_FENETRAGE() OVER (...): Applique une fonction de fenêtrage à un ensemble de lignes.
- PARTITION BY colonne_de_partitionnement: Divise les données en partitions pour le traitement par la fonction de fenêtrage.
- ORDER BY colonne_de_tri: Détermine l'ordre des lignes dans chaque partition.
- RANGE | ROWS BETWEEN debut AND fin: Définit le cadre de lignes pour l'application de la fonction.

*/

-- Rownumber: créer une requête qui permet d'afficher la table vente en ajoutant le numéro de la ligne
SELECT *,
		ROW_NUMBER()
        OVER(ORDER BY MontantTotal) AS NumeroLigne
FROM Ventes
ORDER BY MontantTotal;


-- Ajouter le rang avec RANK() et DENSE_RANK()
SELECT *,
		RANK()
        OVER(ORDER BY MontantTotal) AS Rang
FROM Ventes
ORDER BY MontantTotal;

SELECT *,
		DENSE_RANK()
        OVER(ORDER BY MontantTotal) AS Rang
FROM Ventes
ORDER BY MontantTotal;

/* LEAD LAG*/
-- Pour chaque année donner le CA de l'année précédente et le CA de l'année suivante
SELECT YEAR(DateVente) AS Annee, SUM(MontantTotal) AS CA
FROM Ventes
GROUP BY Annee;


SELECT YEAR(DateVente) AS Annee, 
	   SUM(MontantTotal) AS CA,
       LAG( SUM(MontantTotal),1,0)
       OVER(ORDER BY YEAR(DateVente)) AS CAPrecedent,
       LEAD(SUM(MontantTotal),1,0)
       OVER(ORDER BY YEAR(DateVente)) AS CASuivant
       
FROM Ventes
GROUP BY Annee;



/*FIRST_VALUE() et LAST_VALUE()*/
/*ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING: garantit que la fonction FIRST_VALUE() prend en compte toutes les lignes dans la fenêtre de partitionnement pour trouver le premier produit acheté*/


-- Pour chaque client quel était le premier produit qu'il a acheté
SELECT ClientID, 
	   ProduitID, 
       DateVente,
       FIRST_VALUE(ProduitID)
       OVER(PARTITION BY ClientID
				   ORDER BY DateVente
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) As PremierAchat
FROM Ventes;


-- Pour chaque client quel était le dernier produit acheté
SELECT ClientID, 
	   ProduitID, 
       DateVente,
       LAST_VALUE(ProduitID)
       OVER(PARTITION BY ClientID
				   ORDER BY DateVente
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) As DernierAchat
FROM Ventes;




/*==================================================================================
           Maitriser les CTE
==================================================================================*/

/*
Les CTE, ou 'Expressions de Table Communes', permettent de créer des ensembles de résultats temporaires accessibles dans une requête SELECT, INSERT, UPDATE ou DELETE. Elles sont définies avec le mot-clé WITH suivi du nom de la CTE et du mot-clé AS qui introduit la requête de la CTE.

Forme Générale:
WITH Nom_CTE AS (
    -- Requête de la CTE ici
)
SELECT * FROM Nom_CTE;

Utilisation :
- Simplifier les jointures complexes et les sous-requêtes.
- Activer la récursivité pour le traitement de données hiérarchiques.
- Améliorer la lisibilité et la maintenance du code SQL.

Note :
- Une CTE est valide uniquement dans le contexte d'une seule instruction SQL.
- Les CTEs récursives doivent inclure un UNION ALL entre les membres ancre et récursif.
- Plusieurs CTEs peuvent être définies dans une seule clause WITH, séparées par des virgules.
*/


-- écrire une requête qui permet d'obtenir le top 3 des meilleurs clients (en terme de CA) par année

-- Donner pour chaque client le chiffre d'affaires 
SELECT ClientID, SUM(MontantTotal) AS CA
FROM Ventes
GROUP BY ClientID;

-- Donner pour chaque client le chiffre d'affaires  par année
SELECT ClientID,
	YEAR(DateVente) AS Annee, SUM(MontantTotal) AS CA
FROM Ventes
GROUP BY ClientID, Annee;

-- Classement par année
CREATE VIEW Temp as (
	SELECT ClientID,
		YEAR(DateVente) AS Annee,
		SUM(MontantTotal) AS CA,
		RANK()
		OVER(PARTITION BY YEAR(DateVente)
			ORDER BY SUM(MontantTotal) DESC) As Classement
	FROM Ventes
	GROUP BY ClientID, Annee);

SELECT *
FROM Temp
WHERE Classement BETWEEN 1 AND 3; 


-- Deuxième option : Sous requête
SELECT *
FROM (SELECT ClientID,
		YEAR(DateVente) AS Annee,
		SUM(MontantTotal) AS CA,
		RANK()
		OVER(PARTITION BY YEAR(DateVente)
			ORDER BY SUM(MontantTotal) DESC) As Classement
	FROM Ventes
	GROUP BY ClientID, Annee) As Temp
WHERE Classement BETWEEN 1 AND 3; 

-- Troisième option CTE
WITH tempCA AS (

	SELECT ClientID,
			YEAR(DateVente) AS Annee,
			SUM(MontantTotal) AS CA,
			RANK()
			OVER(PARTITION BY YEAR(DateVente)
				ORDER BY SUM(MontantTotal) DESC) As Classement
		FROM Ventes
		GROUP BY ClientID, Annee
)
SELECT *
FROM tempCA
WHERE Classement BETWEEN 1 AND 3;


WITH tempCA AS (

	SELECT ClientID,
			YEAR(DateVente) AS Annee,
			SUM(MontantTotal) AS CA,
			RANK()
			OVER(PARTITION BY YEAR(DateVente)
				ORDER BY SUM(MontantTotal) DESC) As Classement
		FROM Ventes
		GROUP BY ClientID, Annee
)
SELECT *
FROM tempCA
WHERE Classement BETWEEN 1 AND  3 ;


-- Liste des clients qui ont dépensé plus que la moyenne des dépenses de tous les clients:

-- Donner pour chaque client le chiffre d'affaires 
WITH temp1 AS (

SELECT ClientID, SUM(MontantTotal) AS CA
FROM Ventes
GROUP BY ClientID

)
SELECT *
FROM temp1
WHERE CA > (SELECT AVG(MontantTotal) AS Moyenne FROM Ventes);

SELECT *
FROM (
	SELECT ClientID, SUM(MontantTotal) AS CA
	FROM Ventes
	GROUP BY ClientID) as temp
WHERE CA >(SELECT AVG(MontantTotal) AS Moyenne FROM Ventes);

SELECT AVG(MontantTotal) AS Moyenne FROM Ventes;

SELECT ClientID, MontantTotal 
FROM Ventes
WHERE MontantTotal > (SELECT AVG(MontantTotal) AS Moyenne FROM Ventes);

SELECT AVG(MontantTotal) AS Moyenne FROM Ventes

/*==================================================================================
           Fonctions ensemblistes
==================================================================================*/

/* CTE Réutilisable
WITH CTE1 AS (
    SELECT * FROM TableA
), CTE2 AS (
    SELECT * FROM TableB
)
SELECT * FROM CTE1
UNION ALL
SELECT * FROM CTE2;
*/

-- UNION: Combine les résultats de deux requêtes en éliminant les doublons.
/*
SELECT colonne FROM table1
UNION
SELECT colonne FROM table2;

Explication:
- L'opérateur UNION est utilisé pour combiner les résultats de deux requêtes distinctes.
- Il élimine les lignes en double pour ne retourner que des lignes distinctes.
- Les deux requêtes doivent avoir le même nombre de colonnes dans le résultat, avec des types de données compatibles.
*/

-- Quelle est la liste combinée des noms de tous les employés et de tous les clients ?
SELECT Nom
FROM Employes
UNION
SELECT Nom
FROM Clients;

/* Ajouter le nom des fournisseurs */
SELECT Nom
FROM Employes

UNION

SELECT Nom
FROM Clients

UNION

SELECT NomFournisseur AS Nom
FROM Fournisseurs;

-- Nom et prenom de tous les employés
SELECT Nom,Prenom
FROM Employes

UNION

SELECT Nom,Prenom
FROM Clients;

WITH NomClients AS (SELECT Nom,Prenom
					FROM Employes),
                    
	 NomEmployes AS (SELECT Nom, Prenom
					 FROM Employes)
			
SELECT * 
FROM NomClients

UNION 

SELECT * 
FROM NomEmployes;



/*
A = (a,b,c,d) B= (e,f,g)
A UNION B
(a,b,c,d,e,f,g)*/
-- UNION ALL: Combine les résultats de deux requêtes en conservant les doublons.

/*
SELECT colonne FROM table1
UNION ALL
SELECT colonne FROM table2;

Explication:
- L'opérateur UNION ALL combine les résultats de deux requêtes sans éliminer les doublons.
- Cela peut être utile si vous souhaitez conserver toutes les lignes, y compris les répétitions.
- Comme pour UNION, les requêtes combinées doivent avoir des résultats avec le même nombre et type de colonnes.
*/

SELECT Nom,Prenom
FROM Employes

UNION ALL 

SELECT Nom,Prenom
FROM Clients;

-- Quels sont tous les noms des employés et des clients, en incluant les noms répétés ?
/*
(1,3,5,6) = A
(3,6,2,7)= B
A UNION B (1,3,5,6,2,7)
A INTERSECT B (3,6)*/


-- INTERSECT: Retourne les lignes communes à deux requêtes.
/*
SELECT colonne FROM table1
INTERSECT
SELECT colonne FROM table2;

Explication:
- L'opérateur INTERSECT trouve les lignes qui sont communes aux deux requêtes.
- Il est moins fréquemment supporté que UNION et UNION ALL dans certains systèmes de gestion de bases de données.
- Les deux requêtes doivent avoir des structures de résultat compatibles.
*/


-- Quelles sont les employés ayant réalisé plus de 1000 euros de chiffres d'affaire et qui ont réalisé plus de 10 ventes


-- EXCEPT ou MINUS: Retourne les lignes de la première requête qui ne sont pas présentes dans la seconde.
/*
SELECT colonne FROM table1
EXCEPT
SELECT colonne FROM table2;

Explication:
- L'opérateur EXCEPT (ou MINUS, selon le système de gestion de base de données) soustrait les résultats de la seconde requête de la première.
- Le résultat contient uniquement les lignes uniques de la première requête qui ne sont pas trouvées dans la seconde.
- Les deux requêtes doivent retourner le même nombre de colonnes avec des types de données compatibles.
*/


-- Quels employés n'ont jamais réalisé de vente ?
-- Première approche

SELECT *
FROM Employes
WHERE EmployeID NOT IN (SELECT EmployeID FROM Ventes);





-- Quels employés n'ont pas géré de clients VIP ? (clients achete plus de 5000 euros)

/*CTE Recursive

WITH RECURSIVE CTERecursive (colonne) AS (
    SELECT colonne FROM TableInitiale WHERE condition
    UNION ALL
    SELECT t.colonne FROM TableInitiale t INNER JOIN CTERecursive c ON t.condition = c.colonne
)
SELECT * FROM CTERecursive;
*/




/*
INSERT INTO table (colonne1, colonne2, ..., colonneN)
VALUES (valeur1, valeur2, ..., valeurN);

Explication:
- INSERT INTO table: Déclare l'intention d'insérer des données dans la table spécifiée.
- (colonne1, colonne2, ..., colonneN): Spécifie les colonnes cibles pour l'insertion. L'ordre des colonnes doit correspondre à l'ordre des valeurs fournies.
- VALUES (valeur1, valeur2, ..., valeurN): Définit les valeurs à insérer pour les colonnes spécifiées. Chaque ensemble de valeurs entre parenthèses représente une ligne à insérer dans la table.

Variantes:
1. Insertion de multiples lignes:
   INSERT INTO table (colonne1, colonne2)
   VALUES (valeur1A, valeur2A),
          (valeur1B, valeur2B),
          ...;
   - Cette syntaxe permet d'insérer plusieurs lignes en une seule commande, en séparant chaque ensemble de valeurs par des virgules.

2. Insertion à partir d'une sélection:
   INSERT INTO table1 (colonne1, colonne2)
   SELECT colonneA, colonneB
   FROM table2
   WHERE condition;
   - Cette méthode permet d'insérer des données dans table1 directement à partir d'un sous-ensemble de données sélectionnées dans table2 ou toute autre table, en fonction d'une condition spécifiée.

Conseils:
- Assurez-vous que les types de données des valeurs correspondent aux types de données des colonnes.
- Lors de l'insertion de données dans une table avec une colonne ID auto-incrémentée, il n'est pas nécessaire de spécifier une valeur pour cette colonne, sauf si vous souhaitez écraser le comportement auto-incrémenté.
- Utilisez la clause ON DUPLICATE KEY UPDATE pour mettre à jour la ligne si l'insertion aboutit à un doublon de clé primaire ou unique.

*/


/* Ajout d'un nouvel employe*/

INSERT INTO Employes(EmployeID,Nom,Prenom,Email,NumeroTelephone)
VALUES (200,"NJONGWA","Natacha","temp@gmail.com",0978349);

-- Remplacer tous les produits <200 par 100

UPDATE Produits
SET PrixUnitaire=100
WHERE NomProduit = "Nike Air Max";


/*
UPDATE table
SET colonne1 = nouvelle_valeur1,
    colonne2 = nouvelle_valeur2,
    ...
WHERE condition_de_filtrage;

Explication:
- UPDATE table: Déclare l'intention de mettre à jour des données dans la table spécifiée.
- SET colonne1 = nouvelle_valeur1, ... : Spécifie les colonnes à mettre à jour et les nouvelles valeurs à leur attribuer. Vous pouvez mettre à jour une ou plusieurs colonnes en même temps.
- WHERE condition_de_filtrage: Détermine les lignes à mettre à jour grâce à une condition spécifiée. Si la clause WHERE est omise, toutes les lignes de la table seront mises à jour, ce qui n'est généralement pas recommandé.

Variantes:
1. Mise à jour conditionnelle:
   UPDATE table
   SET colonne = nouvelle_valeur
   WHERE colonne_condition = certaine_valeur;
   - Cette syntaxe permet de mettre à jour des lignes spécifiques qui correspondent à la condition énoncée dans la clause WHERE.

2. Mise à jour avec jointures:
   UPDATE table1
   JOIN table2 ON table1.colonne_jointure = table2.colonne_jointure
   SET table1.colonne = nouvelle_valeur
   WHERE table2.colonne_condition = certaine_valeur;
   - Permet de mettre à jour une table en se basant sur les données d'une autre table, en utilisant une condition de jointure.

Conseils:
- Faites preuve de prudence avec la clause WHERE pour éviter de mettre à jour plus de lignes que prévu.
- Il est souvent utile de tester votre clause WHERE avec une commande SELECT avant de l'exécuter avec UPDATE, pour s'assurer qu'elle sélectionne les bonnes lignes.
- Pour des raisons de performance, essayez de limiter le nombre de colonnes mises à jour uniquement à celles qui doivent réellement être changées.
- Pensez à utiliser des transactions pour regrouper plusieurs opérations de mise à jour en une seule unité de travail, permettant ainsi de les annuler toutes ensemble en cas d'erreur.

*/



/*
UPDATE table
SET colonne1 = nouvelle_valeur1,
    colonne2 = nouvelle_valeur2,
    ...
WHERE condition_de_filtrage;

Explication:
- UPDATE table: Déclare l'intention de mettre à jour des données dans la table spécifiée.
- SET colonne1 = nouvelle_valeur1, ... : Spécifie les colonnes à mettre à jour et les nouvelles valeurs à leur attribuer. Vous pouvez mettre à jour une ou plusieurs colonnes en même temps.
- WHERE condition_de_filtrage: Détermine les lignes à mettre à jour grâce à une condition spécifiée. Si la clause WHERE est omise, toutes les lignes de la table seront mises à jour, ce qui n'est généralement pas recommandé.

Variantes:
1. Mise à jour conditionnelle:
   UPDATE table
   SET colonne = nouvelle_valeur
   WHERE colonne_condition = certaine_valeur;
   - Cette syntaxe permet de mettre à jour des lignes spécifiques qui correspondent à la condition énoncée dans la clause WHERE.

2. Mise à jour avec jointures:
   UPDATE table1
   JOIN table2 ON table1.colonne_jointure = table2.colonne_jointure
   SET table1.colonne = nouvelle_valeur
   WHERE table2.colonne_condition = certaine_valeur;
   - Permet de mettre à jour une table en se basant sur les données d'une autre table, en utilisant une condition de jointure.

Conseils:
- Faites preuve de prudence avec la clause WHERE pour éviter de mettre à jour plus de lignes que prévu.
- Il est souvent utile de tester votre clause WHERE avec une commande SELECT avant de l'exécuter avec UPDATE, pour s'assurer qu'elle sélectionne les bonnes lignes.
- Pour des raisons de performance, essayez de limiter le nombre de colonnes mises à jour uniquement à celles qui doivent réellement être changées.
- Pensez à utiliser des transactions pour regrouper plusieurs opérations de mise à jour en une seule unité de travail, permettant ainsi de les annuler toutes ensemble en cas d'erreur.

*/


/* Pour Supprimer la table*/
/* DROP TABLE table; our DROP TABLE IF EXISTS table;



/*-- Supprime la colonne des colonnes
ALTER TABLE table
DROP COLUMN colonne;*/

-- Supprimer prixUnitaire
ALTER TABLE Produits
DROP COLUMN NomProduit;

/*Supprimer plusieurs colonnes
ALTER TABLE table
DROP COLUMN colonne1
DROP COLUMN colonne1;;*/


/*Modifie le nom de la colonne `ancien_nom` en `nouveau_nom` dans la table `ma_table`: RENAME
ALTER TABLE ma_table
CHANGE COLUMN ancien_nom nouveau_nom nouveau_type;*/

DROP TABLE IF EXISTS table;

