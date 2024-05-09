from fastapi import FastAPI
from pydantic import BaseModel
import joblib
import pandas as pd

# Création d'une instance de l'application FastAPI
app = FastAPI()

# Charger le modèle depuis le disque
modele = joblib.load('modele/random_forest_model.pkl')

class DonneesEntree(BaseModel):
    """
    Classe pour définir le schéma des données d'entrée utilisées pour les prédictions,
    basée sur les caractéristiques spécifiques du modèle.
    """
    Pregnancies: float
    Glucose: float
    BloodPressure: float
    SkinThickness: float
    Insulin: float
    BMI: float
    DiabetesPedigreeFunction: float
    Age: float

@app.get("/")
async def accueil():
    """
    Endpoint racine qui fournit un message de bienvenue.
    Accessible via une requête GET.

    Retours:
        dict: Un dictionnaire contenant un message de bienvenue.
    """
    return {"message": "Bienvenue sur l'API de prédiction pour le diagnostic du diabète"}

@app.post("/predire/")
async def predire(donnees: DonneesEntree):
    """
    Endpoint qui réalise des prédictions en utilisant le modèle chargé.
    Les données pour la prédiction sont envoyées via une requête POST.
    Retourne à la fois la classe prédite (0 ou 1) et les probabilités pour chaque classe.

    Paramètres:
        donnees (DonneesEntree): Un objet contenant les données de prédiction.

    Retours:
        dict: Un dictionnaire contenant le tableau des caractéristiques, la prédiction, et les probabilités.
    """
    # Convertir les données d'entrée en DataFrame
    donnees_df = pd.DataFrame([donnees.dict()])
    
    # Prédire avec le modèle
    predictions = modele.predict(donnees_df)
    probabilities = modele.predict_proba(donnees_df)[:, 1]  # Probabilité de la classe 1 (diabète)
    
    # Ajouter la colonne de prédictions et de probabilités au DataFrame
    donnees_df['prediction'] = predictions
    donnees_df['probabilité_diabète'] = probabilities
    
    # Convertir le DataFrame en dictionnaire pour la réponse JSON
    result = donnees_df.to_dict(orient='records')
    
    return {"resultats": result}