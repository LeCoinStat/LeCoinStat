from fastapi import FastAPI
from pydantic import BaseModel
import joblib
import numpy as np
#pip install fastapi uvicorn joblib sklearn pip install scikit-learn
#uvicorn main:app --reload
# Chargement du modèle sérialisé
model = joblib.load('iris_model.pkl')

# Création de l'application FastAPI
app = FastAPI()

# Modèle de données pour les requêtes
class IrisData(BaseModel):
    sepal_length: float
    sepal_width: float
    petal_length: float
    petal_width: float

# Endpoint d'accueil
@app.get("/")
def read_root():
    """
    Endpoint d'accueil de l'API.
    Retourne un message de bienvenue avec une indication sur l'utilisation de l'API.
    """
    return {"message": "Bienvenue à l'API de prédiction de l'Iris. Utilisez l'endpoint /predict pour faire des prédictions."}

# Endpoint de prédiction
@app.post("/predict")
def predict(data: IrisData):
    """
    Endpoint pour faire des prédictions sur les espèces d'Iris.
    Reçoit les caractéristiques de la fleur en entrée et retourne la prédiction.
    """
    # Extraction des caractéristiques de la requête et conversion en tableau NumPy
    features = np.array([[data.sepal_length, data.sepal_width, data.petal_length, data.petal_width]])
    # Utilisation du modèle pour faire la prédiction
    prediction = model.predict(features)
    # Retourne la prédiction sous forme de dictionnaire
    return {"prediction": prediction[0]}

# Pour démarrer le serveur : uvicorn app:app --reload
