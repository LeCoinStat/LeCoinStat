from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return 'Bonjour, ceci est la page d\'accueil de mon application Flask !'

@app.route("/hello")
def hello_world():
    return "Hello, World!"
