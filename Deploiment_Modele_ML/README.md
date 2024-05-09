### 1. Write App (Flask, TensorFlow)
- The code to build, train, and save the model is in the `test` folder.
- Implement the app in `main.py`
### 2. Setup Google Cloud 
- Create new project
- Activate Cloud Run API and Cloud Build API

### 3. Install and init Google Cloud SDK
- https://cloud.google.com/sdk/docs/install

### 4. Dockerfile, requirements.txt, .dockerignore
- https://cloud.google.com/run/docs/quickstarts/build-and-deploy#containerizing

### 5. Cloud build & deploy
```
#gcloud builds submit --tag gcr.io/testapi-420317/index
#gcloud run deploy --image gcr.io/testapi-420317/index --platform managed
gcloud builds submit --tag europe-west9-docker.pkg.dev/testapi-420317/projetml/index:tag .
gcloud run deploy --image europe-west9-docker.pkg.dev/testapi-420317/projetml/index:tag --platform managed


```

### Test
- Test the code with `test/test.py`

### Watch the video tutorial
- How To Deploy ML Models With Google Cloud Run

[![Alt text](https://img.youtube.com/vi/vieoHqt7pxo/hqdefault.jpg)](https://youtu.be/vieoHqt7pxo)
