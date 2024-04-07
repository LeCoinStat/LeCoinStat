from shiny import App, render, ui

app_ui = ui.page_fluid(
    ui.panel_title("Application statistique descriptive"),
    ui.h1("Ceci est un titre de niveau 1"),
    ui.h2("Ceci est un titre de niveau 2"),
    ui.h3("Ceci est un titre de niveau 3"),
    ui.h4("Ceci est un titre de niveau 4"),
    ui.br(),
    ui.h5("Ceci est un titre de niveau 5"),
    ui.input_text("prenom","Quel est votre prénom"),
    ui.output_text("afficher_prenom"),
    ui.input_numeric("age", "Quel est votre age?",0),
    ui.output_text("afficher_age")
)


def server(input, output, session):
    
    @render.text
    def afficher_prenom():
        return f"Le prénom de l'utilisateur est {input.prenom()}"
    
    
    @render.text
    def afficher_age():
        age_carre = input.age() * input.age()
        return f"L'age au carre est {age_carre}"


app = App(app_ui, server)
