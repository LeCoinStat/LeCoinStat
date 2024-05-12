Les étapes pour déployer un modèle de machine learning sur le Cloud. La vidéo complète est disponible ici: [Déploiement des modèles de ML](https://www.youtube.com/watch?v=xaI03GSya0g)



# 1. Construire le modèle de machine Learning
- Le code pour construire, entraîner et sauvegarder le modèle se trouve dans le dossier `modele`.

# 2. Créer une API pour le modèle (Fast API)

- Implémenter l'application dans `main.py`
- Utiliser test/test_request.py pour tester l'appel à l'API en local

# 3. Configurer Google Cloud 
- Créer un nouveau projet
- Activer l'API Cloud Run et l'API Cloud Build

## Installer et initialiser Google Cloud SDK
- [Installer Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- Initialiser avec gcloud init



# 4 Créer le fichier requirements.txt
pip freeze > requirements.txt

# 5. Conteneurisation:  Dockerfile, requirements.txt, .dockerignore
Créer les fichier Dockerfile, et .dockerignore

- [Guide de containerisation sur Google Cloud](https://cloud.google.com/run/docs/quickstarts/build-and-deploy#containerizing)

[Code Dockerfile](https://fastapi.tiangolo.com/deployment/docker/)

# 6. Construction et déploiement dans le Cloud

Deux approches 

## Ancienne méthode gcr.io (cette méthode n'est plus recommandée à partir du mois de Mai 2024)

### Définir les variables
PROJECT_ID="your-project-id"   # Remplacez 'your-project-id' par votre ID de projet GCP
IMAGE_NAME="your-image-name"   # Remplacez 'your-image-name' par le nom de votre image Docker
REGION="your-region"           # Remplacez 'your-region' par la région GCP de votre choix

### Soumettre le build de l'image Docker à Google Container Registry
gcloud builds submit --tag gcr.io/${PROJECT_ID}/${IMAGE_NAME}

### Déployer l'image sur Google Cloud Run
gcloud run deploy --image gcr.io/${PROJECT_ID}/${IMAGE_NAME} --platform managed --region ${REGION}


gcloud builds submit --tag gcr.io/testapi-420317/deploiement
gcloud run deploy --image gcr.io/testapi-420317/deploiement --platform managed


## Nouvelle approche: artefact registry (il faut activer le service sur GCP)

### Commencez par créer un dossier dans l'artefact registry


### Définir les variables
PROJECT_ID="your-project-id"      # Remplacez par votre ID de projet GCP
REGION="europe-west9"             # Remplacez par la région GCP
REPO_NAME="your-repo-name"        # Remplacez par le nom de votre dépôt dans Artifact Registry
IMAGE_NAME="your-image-name"      # Remplacez par le nom de votre image Docker
IMAGE_TAG="your-tag"              # Remplacez par le tag que vous souhaitez utiliser

#### Construire et soumettre l'image à Google Artifact Registry
gcloud builds submit --tag ${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:${IMAGE_TAG} .

#### Déployer l'image sur Google Cloud Run
gcloud run deploy --image ${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:${IMAGE_TAG} --platform managed --region ${REGION}





gcloud builds submit --tag europe-west9-docker.pkg.dev/testapi-420317/projetml/index:tag .
gcloud run deploy --image europe-west9-docker.pkg.dev/testapi-420317/projetml/index:tag --platform managed


# 7 Test
- Tester le code avec `test/test.py` en utilisant le lien disponible après le déploiement

# 8 Regarder le tutoriel vidéo

[Déploiement des Modèles de Machine Learning avec Flask, Docker et GCP](https://www.youtube.com/watch?v=xaI03GSya0g)

