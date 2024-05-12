import requests

# URL de base de l'API
url_base = 'https://diabete-srjrppe5ia-od.a.run.app/'

# Test du endpoint d'accueil
response = requests.get(f"{url_base}/")
print("Réponse du endpoint d'accueil:", response.text)
# Données d'exemple pour la prédiction
donnees_predire = {
    "Pregnancies": 2,
    "Glucose": 138,
    "BloodPressure": 62,
    "SkinThickness": 35,
    "Insulin": 0,
    "BMI": 33.6,
    "DiabetesPedigreeFunction": 0.127,
    "Age": 47
}

# Test du endpoint de prédiction
response = requests.post(f"{url_base}/predire", json=donnees_predire)  # Removed the trailing slash
print("Réponse du endpoint de prédiction:", response.text)


# Données d'exemple pour la prédiction avec haute probabilité de diabète
donnees_predire_haute_proba_diabete = {
    "Pregnancies": 8,
    "Glucose": 180,
    "BloodPressure": 90,
    "SkinThickness": 40,
    "Insulin": 300,
    "BMI": 40.0,
    "DiabetesPedigreeFunction": 1.2,
    "Age": 60
}

# Test du endpoint de prédiction
response = requests.post(f"{url_base}/predire", json=donnees_predire_haute_proba_diabete)
print("Réponse du endpoint de prédiction:", response.text)