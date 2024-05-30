import streamlit as st
import pandas as pd
import requests
import json

#streamlit run app.py
# Titre de l'application
st.title('Prédiction des espèces d\'Iris')

# URL de l'API FastAPI
api_url = 'http://127.0.0.1:8000/predict'

# Fonction pour prédire une seule fleur
def predict_single(data):
    """
    Envoie une requête POST à l'API pour obtenir la prédiction pour une seule fleur.
    
    Args:
        data (dict): Un dictionnaire contenant les caractéristiques de la fleur.
        
    Returns:
        str: La prédiction retournée par l'API.
    """
    response = requests.post(api_url, json=data)
    if response.status_code == 200:
        return response.json()['prediction']
    else:
        st.error('Erreur lors de la prédiction')
        return None

# Entrées utilisateur pour les caractéristiques de la fleur
sepal_length = st.number_input('Longueur du sépale (cm)', min_value=0.0, format="%.2f")
sepal_width = st.number_input('Largeur du sépale (cm)', min_value=0.0, format="%.2f")
petal_length = st.number_input('Longueur du pétale (cm)', min_value=0.0, format="%.2f")
petal_width = st.number_input('Largeur du pétale (cm)', min_value=0.0, format="%.2f")

# Bouton pour faire la prédiction pour une seule fleur
if st.button('Prédire'):
    # Préparation des données pour l'API
    data = {
        'sepal_length': sepal_length,
        'sepal_width': sepal_width,
        'petal_length': petal_length,
        'petal_width': petal_width
    }
    # Appel à l'API pour obtenir la prédiction
    prediction = predict_single(data)
    # Affichage de la prédiction
    if prediction:
        st.success(f'L\'espèce prédite est : {prediction}')

# Téléchargement du fichier CSV
uploaded_file = st.file_uploader("Choisissez un fichier CSV", type="csv")

if uploaded_file is not None:
    # Lecture du fichier CSV
    df = pd.read_csv(uploaded_file)
    
    # Affichage des données du CSV
    st.write("Données du fichier CSV:")
    st.write(df)
    
    # Vérification que le CSV a les bonnes colonnes
    expected_columns = ['sepal_length', 'sepal_width', 'petal_length', 'petal_width']
    if all(col in df.columns for col in expected_columns):
        # Préparer les données pour l'API
        data = df[expected_columns].to_dict(orient='records')
        
        # Faire les prédictions pour chaque ligne du CSV
        predictions = [predict_single(d) for d in data]
        
        # Ajouter les prédictions au DataFrame
        df['prediction'] = predictions
        
        # Afficher le DataFrame avec les prédictions
        st.write("Résultats avec les prédictions:")
        st.write(df)
    else:
        # Message d'erreur si les colonnes sont incorrectes
        st.error(f"Le fichier CSV doit contenir les colonnes suivantes: {expected_columns}")
