-- Exercice: Donner la liste des 5 employés ayant la somme des ventes la plus élevée.
SELECT EmployeID, SUM(MontantTotal) AS CA_Total
FROM Ventes
GROUP BY EmployeID
ORDER BY CA_Total DESC
LIMIT 5;

-- Question: Donner pour chaque vente le nom et le prénom de l'employé qui a réalisé la vente

-- Première approche produit cartésien

/*==================================================================================
               Maîtriser les Jointures en SQL
==================================================================================*/

/*======================================================
Introduction aux Jointures en SQL
======================================================*/

-- Les jointures en SQL sont utilisées pour combiner des données de deux ou plusieurs tables en fonction d'une relation entre les colonnes de ces tables. Elles permettent de récupérer des informations provenant de plusieurs tables dans une seule requête.

/*======================================================================
Utilisation de INNER JOIN pour combiner des lignes de deux tables
SELECT colonnes
FROM table1
INNER JOIN table2
ON table1.colonne_commune = table2.colonne_commune;

Explication:
- SELECT colonnes: spécifie les colonnes à récupérer dans le résultat final.
- FROM table1: définit la première table à partir de laquelle récupérer les données.
- INNER JOIN table2: spécifie la seconde table à joindre avec la première.
- ON table1.colonne_commune = table2.colonne_commune; établit la condition de jointure, généralement l'égalité entre une colonne de la table1 et une colonne de la table2.

L'opération INNER JOIN retourne uniquement les lignes qui ont une correspondance dans les deux tables basées sur la condition spécifiée.
======================================================================*/
-- Donner pour chaque vente le nom et le prénom de l'employé qui a réalisé la vente

-- Utilisation de USING
-- Exercice: Donner pour chaque produit de la base de données le nom et l'adresse de son fournisseur

-- Donner le nom et prénom des employés ayant réalisé la somme des ventes les plus élevées

-- Exercice donner pour chaque client le nom, l'adresse ainsi que le nombre d'achat réalisé

/*======================================================================
Utilisation de LEFT JOIN et RIGHT JOIN pour combiner des lignes de deux tables
SELECT colonnes
FROM table1
LEFT JOIN table2 ON table1.colonne_commune = table2.colonne_commune;
RIGHT JOIN table2 ON table1.colonne_commune = table2.colonne_commune;

Explication:
- SELECT colonnes: spécifie les colonnes à récupérer dans le résultat final.
- FROM table1: définit la première table à partir de laquelle récupérer les données.
- LEFT JOIN table2: spécifie la seconde table à joindre avec la première, en incluant toutes les lignes de la première table (table1) même s'il n'y a pas de correspondance dans la seconde table (table2).
- RIGHT JOIN table2: similaire à LEFT JOIN mais inclut toutes les lignes de la seconde table (table2), même s'il n'y a pas de correspondance dans la première table (table1).
- ON table1.colonne_commune = table2.colonne_commune; établit la condition de jointure, généralement l'égalité entre une colonne de la table1 et une colonne de la table2.

L'opération LEFT JOIN retourne toutes les lignes de la table de gauche (table1) et les lignes correspondantes de la table de droite (table2). S'il n'y a pas de correspondance, le résultat inclura des valeurs NULL pour les colonnes de la table de droite.

L'opération RIGHT JOIN fonctionne de manière similaire mais retourne toutes les lignes de la table de droite (table2) et les lignes correspondantes de la table de gauche (table1). S'il n'y a pas de correspondance, le résultat inclura des valeurs NULL pour les colonnes de la table de gauche.
======================================================================*/

-- Question donner pour chaque employé, le nom, le prénom et le nombre de vente réalisé (il faut conserver dans la base les employés qui ont des ventes nulles)

-- Donner pour chaque fournisseur son nom, son email et le nombre de produits fournis (laisser des fournisseurs qui n'ont aucun produit)

-- Donner le nom, le prénom et la moyenne des ventes par client (conservez la liste des clients qui n'ont acheté aucun produit)

-- Remplacez dans la requête précédente les valeurs NULL par 0

-- COALESCE

-- Exercice: Donner le nom, le prénom et la somme des achats réalisés par chaque client, et affichez zéro si le montant des achats est nul

-- Refaire les exercices précédents en utilisant RIGHT JOIN

/*======================================================================
Création et utilisation de vues dans SQL
CREATE VIEW nom_vue AS
SELECT colonnes
FROM table1
JOIN table2 ON table1.colonne_commune = table2.colonne_commune;

Explication:
- CREATE VIEW nom_vue: commence la définition d'une nouvelle vue nommée 'nom_vue'. Les vues sont des tables virtuelles basées sur le résultat d'une requête SQL.
- SELECT colonnes: spécifie les colonnes à inclure dans la vue. Ces colonnes peuvent provenir d'une ou plusieurs tables.
- FROM table1: indique la ou les tables de base pour la vue. Les vues peuvent combiner des données de plusieurs tables via des jointures.
- JOIN table2 ON table1.colonne_commune = table2.colonne_commune; définit comment les tables sont reliées pour former la vue. Les jointures peuvent être INNER JOIN, LEFT JOIN, RIGHT JOIN, etc., selon les données à inclure.

Les vues permettent de:
1. Simplifier les requêtes complexes en masquant la complexité des jointures et des calculs.
2. Réutiliser des requêtes SQL fréquemment exécutées sans avoir à les réécrire.
3. Limiter l'accès aux données en présentant seulement une partie des données d'une table ou de plusieurs tables.
======================================================================*/

-- Créez une vue des ventes de l'année 2021

-- Quelle est la liste des clients qui ont réalisé plus de 2 achats en 2021
-- Quelle est la liste des employés qui ont les ventes moyennes supérieures à 500 en 2021?

-- Créez une vue contenant les produits dont le prix est supérieur à 500 euros

-- Créez une vue contenant pour chaque client le nom, le prénom ainsi que la somme des achats par année

-- Quelle est pour chaque client la moyenne des CA générés par année?

/*====================*/
/* Sous-requête en SQL*/
/*====================*/

-- Exercice: Écrire une requête qui permet de donner pour chaque client son nom, son prénom, la somme des achats ainsi que la moyenne annuelle des achats
