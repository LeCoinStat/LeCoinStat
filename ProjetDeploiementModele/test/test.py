import joblib
import pandas as pd

# Charger le modèle depuis le fichier
modele = joblib.load('./modele/random_forest_model.pkl')


diabete=pd.read_csv("./modele/data/diabetes.csv")

# Supprimer la colonne 'Outcome'
donnees_sans_outcome = diabete.drop('Outcome', axis=1)

# Faire des prédictions avec le modèle chargé
predictions = modele.predict(donnees_sans_outcome)


# Afficher les prédictions
print(predictions)