# Importation des bibliothèques FastAPI et joblib
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import joblib
import numpy as np
import warnings
from sklearn.exceptions import InconsistentVersionWarning


# Ignorer l'avertissement InconsistentVersionWarning
warnings.filterwarnings("ignore", category=InconsistentVersionWarning)



# Définition du schéma pour la requête POST
class InputData(BaseModel):
    sepal_length: float
    sepal_width: float
    petal_length: float
    petal_width: float

# Chargement du modèle formé
model = joblib.load('logistic_regression_model.pkl')

# Création de l'application FastAPI
app = FastAPI()

# Fonction pour décider du type de fleur en fonction des probabilités de prédiction
def decide_flower_type(predicted_class):
    if predicted_class == 0:
        return "Setosa"
    elif predicted_class == 1:
        return "Versicolor"
    elif predicted_class == 2:
        return "Virginica"
    else:
        return "Unknown"

# Définition de la route pour effectuer des prédictions
@app.post("/predict")
async def predict(data: InputData):
    features = np.array([[data.sepal_length, data.sepal_width, data.petal_length, data.petal_width]])
    probabilities = model.predict_proba(features)[0]  # Effectue une prédiction de probabilité en utilisant le modèle chargé
    predicted_class = np.argmax(probabilities)  # Trouve l'indice de la classe prédite avec la plus haute probabilité
    flower_type = decide_flower_type(predicted_class)  # Décide du type de fleur en fonction de la classe prédite
    return {"probability": probabilities.tolist(), "predicted_class": int(predicted_class), "flower_type": flower_type}
