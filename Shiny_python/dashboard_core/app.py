from pathlib import Path
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

from shiny import App, Inputs, Outputs, Session, reactive, render, ui

sns.set_theme(style="white")
df = pd.read_csv(Path(__file__).parent / "penguins.csv", na_values="NA")
#Recupérer les colonnes
variables = df.columns.tolist()
variables_dict = {var: var for var in variables}


app_ui = ui.page_sidebar(
    ui.sidebar(
        ui.input_select("variable", "Choisir la variable",variables_dict )
    ),
    ui.layout_columns(
        ui.card(
            ui.card_header("Base de données"),
            ui.output_data_frame("base_donnee")
        ),
        ui.card(
            ui.card_header("Statistique descriptive"),
            ui.output_data_frame("stat_descriptive")
        )
        ,
        ui.card(
            ui.card_header("Graphique de la variable"),
            ui.output_plot("creation_graphique")
        )
    )
    
)


def server(input: Inputs, output: Outputs, session: Session):
    
    @reactive.calc
    def filtre_base()  ->pd.DataFrame:
        filtre = df[[input.variable()]]
        return filtre
    
    @render.data_frame
    def base_donnee():
        return filtre_base()
    
    @render.data_frame
    def stat_descriptive():
        # Calculer le décompte des valeurs uniques pour la variable sélectionnée
        stats = filtre_base().value_counts().reset_index()
        stats.columns = [input.variable(), 'Effectifs']
        return stats
    
    @render.plot
    def creation_graphique():
        
        # Calculer les décomptes de la variable sélectionnée
        data = filtre_base().value_counts().reset_index()
        data.columns = [input.variable(), 'Effectifs']
        
        # Création du barplot
        plt.figure(figsize=(10, 6))  # Taille du graphique
        sns.barplot(x=input.variable(), y='Effectifs', data=data)
        plt.title(f'Répartition de la variable {input.variable()}')
        plt.xticks(rotation=45)  # Rotation des labels de l'axe x pour une meilleure lisibilité


    
app = App(app_ui, server)
