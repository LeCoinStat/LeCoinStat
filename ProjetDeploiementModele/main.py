from pydantic import BaseModel  # Utilisé pour la validation des données
import numpy as np
import pandas as pd  # Utilisé pour la manipulation de données
import joblib  # Utilisé pour charger le modèle sauvegardé
from flask import Flask, request, jsonify  # Flask est un micro-framework pour les applications web

# Charger le modèle de forêt aléatoire depuis le disque
modele = joblib.load('random_forest_model.pkl')

# Définition du schéma des données d'entrée avec Pydantic
# Cela garantit que les données reçues correspondent aux attentes du modèle
class DonneesEntree(BaseModel):
    Pregnancies: float  # Nombre de grossesses
    Glucose: float  # Concentration plasmatique de glucose à 2 heures dans un test oral de tolérance au glucose
    BloodPressure: float  # Tension artérielle diastolique (mm Hg)
    SkinThickness: float  # Épaisseur du pli cutané du triceps (mm)
    Insulin: float  # Insuline sérique sur 2 heures (mu U/ml)
    BMI: float  # Indice de masse corporelle (poids en kg/(taille en m)^2)
    DiabetesPedigreeFunction: float  # Fonction de pedigree du diabète
    Age: float  # Âge (années)

# Création de l'instance de l'application Flask
app = Flask(__name__)

# Définition de la route racine qui retourne un message de bienvenue
@app.route("/", methods=["GET"])
def accueil():
    """ Endpoint racine qui fournit un message de bienvenue. """
    return jsonify({"message": "Bienvenue sur l'API de prédiction pour le diagnostic du diabète"})

# Définition de la route pour les prédictions de diabète
@app.route("/predire", methods=["POST"])
def predire():
    """
    Endpoint pour les prédictions en utilisant le modèle chargé.
    Les données d'entrée sont validées et transformées en DataFrame pour le traitement par le modèle.
    """
    if not request.json:
        return jsonify({"erreur": "Aucun JSON fourni"}), 400
    
    
    try:
        # Extraction et validation des données d'entrée en utilisant Pydantic
        donnees = DonneesEntree(**request.json)
        donnees_df = pd.DataFrame([donnees.dict()])  # Conversion en DataFrame

        # Utilisation du modèle pour prédire et obtenir les probabilités
        predictions = modele.predict(donnees_df)
        probabilities = modele.predict_proba(donnees_df)[:, 1]  # Probabilité de la classe positive (diabète)

        # Compilation des résultats dans un dictionnaire
        resultats = donnees.dict()
        resultats['prediction'] = int(predictions[0])
        resultats['probabilite_diabete'] = probabilities[0]

        # Renvoie les résultats sous forme de JSON
        return jsonify({"resultats": resultats})
    except Exception as e:
        # Gestion des erreurs et renvoi d'une réponse d'erreur
        return jsonify({"erreur": str(e)}), 400

# Point d'entrée pour exécuter l'application
if __name__ == "__main__":
    app.run(debug=True, port=8000)  # Lancement de l'application sur le port 8000 avec le mode debug activé
