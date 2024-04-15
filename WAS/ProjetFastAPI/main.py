from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Bienvenue sur LeCoinStat, Bonjour à tous et à toutes"}

@app.get("/data/")
def root():
    return {"La base de donnée": "La base de donées est "}