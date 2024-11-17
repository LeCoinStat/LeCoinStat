# -------------------------------------------
# INSTALLATIONS NÉCESSAIRES
# -------------------------------------------
# Installez les bibliothèques suivantes avant d'exécuter ce fichier :
#
# pip install streamlit langchain-openai langchain-community pypdf openai
#
# Lancer l'application avec :
# streamlit run nom_du_fichier.py
# -------------------------------------------

import os
import streamlit as st
from langchain_community.document_loaders import PyPDFLoader
from langchain_core.vectorstores import InMemoryVectorStore
from langchain_openai import OpenAIEmbeddings

# Configuration de la clé API OpenAI
os.environ["OPENAI_API_KEY"] = "VotreCléAPIOpenAI"

# Titre de l'application
st.title("Assistant Analyste Financier Intelligent")
st.subheader("Analysez vos rapports financiers avec un assistant IA")

# Téléchargement du fichier PDF
uploaded_file = st.file_uploader("Chargez un rapport financier au format PDF", type="pdf")

if uploaded_file:
    # Enregistrer le fichier localement
    with open("uploaded_file.pdf", "wb") as f:
        f.write(uploaded_file.read())
    
    # Charger le fichier PDF avec PyPDFLoader
    st.write("📄 Chargement du fichier...")
    loader = PyPDFLoader("uploaded_file.pdf")
    
    # Charger les pages de manière asynchrone
    pages = []
    for page in loader.lazy_load():
        pages.append(page)
    
    # Vérification que le document contient des pages
    if not pages:
        st.warning("⚠️ Le fichier PDF est vide ou n'a pas pu être chargé.")
    ©else:
        # Afficher les métadonnées et les 100 premiers caractères de la première page
        st.subheader("Aperçu de la première page")
        st.write(f"Métadon nées : {pages[0].metadata}")
        st.write(f"Contenu (100 premiers caractères) : {pages[0].page_content[:100]}")

        # Créer un index vectoriel pour la recherche
        vector_store = InMemoryVectorStore.from_documents(pages, OpenAIEmbeddings())

        # Questions financières par défaut
        st.subheader("Questions prédéfinies")
        default_questions = [
            "Quel est le chiffre d'affaires total de cette année ?",
            "Quels sont les segments les plus performants ?",
            "Quelle est l'évolution des bénéfices par rapport à l'année précédente ?",
            "Quels sont les principaux coûts opérationnels ?",
            "Quel est le ratio de solvabilité (CET1) ?",
        ]
        selected_question = st.selectbox("Choisissez une question prédéfinie :", default_questions)

        # Bouton pour les questions prédéfinies
        if st.button("Obtenir une réponse pour la question prédéfinie"):
            st.write("🔍 Recherche en cours pour la question prédéfinie...")
            docs = vector_store.similarity_search(selected_question, k=2)
            if docs:
                for doc in docs:
                    st.write(f'Page {doc.metadata["page"]}: {doc.page_content[:300]}...')
            else:
                st.warning("⚠️ Aucune réponse trouvée dans le document.")

        # Option pour poser une question personnalisée
        st.subheader("Posez une question spécifique")
        user_question = st.text_input("Entrez votre propre question :", "")

        # Bouton pour les questions spécifiques
        if st.button("Obtenir une réponse pour la question spécifique"):
            if user_question.strip():
                st.write("🔍 Recherche en cours pour la question spécifique...")
                docs = vector_store.similarity_search(user_question, k=2)
                if docs:
                    for doc in docs:
                        st.write(f'Page {doc.metadata["page"]}: {doc.page_content[:300]}...')
                else:
                    st.warning("⚠️ Aucune réponse trouvée dans le document.")
            else:
                st.warning("⚠️ Veuillez entrer une question spécifique avant de cliquer.")
