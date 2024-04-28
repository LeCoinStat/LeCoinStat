# Utiliser une image Python slim comme base
FROM python:3.11-slim

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier des dépendances de l'application dans le conteneur
COPY requirements.txt /app

# Installer les dépendances de l'application
RUN pip install -r requirements.txt

# Copier le code de l'application dans le conteneur
COPY . /app



# Commande pour exécuter l'application avec Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]


#docker run -p 8000:8000 fastapi_image:v0