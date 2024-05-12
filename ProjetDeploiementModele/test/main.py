import streamlit as st
import pandas as pd
import requests

# URL de l'API
URL_BASE = 'https://diabete-srjrppe5ia-od.a.run.app/'

def envoyer_pour_prediction(donnees):
    """ Envoie les données à l'API et récupère les prédictions. """
    response = requests.post(f"{URL_BASE}/predire", json=donnees)
    if response.status_code == 200:
        return response.json()
    else:
        return None

def main():
    st.title("Application de prédiction du diabète")
    st.write("Veuillez charger un fichier CSV contenant les données des patients.")

    # Téléchargement de fichier par l'utilisateur
    fichier = st.file_uploader("Choisissez un fichier CSV", type='csv')
    if fichier is not None:
        # Chargement des données
        donnees = pd.read_csv(fichier)

        # Afficher les données chargées
        st.write("Données chargées :")
        st.write(donnees)

        if st.button("Prédire"):
            # Prédire chaque ligne des données chargées
            predictions = []
            for _, row in donnees.iterrows():
                donnees_api = row.to_dict()
                resultat = envoyer_pour_prediction(donnees_api)
                if resultat:
                    predictions.append({'prediction': resultat['resultats'], 'probabilite_diabete': resultat.get('probabilite', 'N/A')})
                else:
                    predictions.append({'prediction': 'Erreur', 'probabilite_diabete': 'N/A'})

            # Affichage des résultats
            st.write("Prédictions :")
            st.table(predictions)
        else:
            st.write("Cliquez sur le bouton 'Prédire' pour obtenir les résultats.")

if __name__ == "__main__":
    main()
