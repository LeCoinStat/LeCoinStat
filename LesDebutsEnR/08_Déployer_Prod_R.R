###################################################################################
# Introduction à R et Rstudio
# Partie 7 Déployer en production
# Par: Natacha NJONGWA YEPNGA - LeCoinStat https://www.youtube.com/c/LeCoinStat
# Linkedin: https://www.linkedin.com/in/natacha-njongwa-yepnga/?originalSubdomain=fr
###################################################################################


# Utilisation de pacman pour la gestion des packages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(caret, ggplot2, tree,shiny)

library(shiny)
library(tree)

# Charger le modèle d'arbre de décision
load("/Users/natachanjongwayepnga/Documents/GitHub/LeCoinStat/LesDebutsEnR/model_tree.RData")

# Définition de l'interface utilisateur
ui <- fluidPage(
  titlePanel("Prédiction avec le Modèle d'Arbre de Décision"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("PetalLength", "Longueur des Pétales", value = 1),
      numericInput("PetalWidth", "Largeur des Pétales", value = 1),
      numericInput("SepalLength", "Longueur des Sépales", value = 1),
      numericInput("SepalWidth", "Largeur des Sépales", value = 1),
      actionButton("predict", "Prédire")
    ),
    mainPanel(
      textOutput("prediction")
    )
  )
)

# Définition du serveur
server <- function(input, output) {
  prediction <- eventReactive(input$predict, {
    newdata <- data.frame(
      Sepal.Length = input$SepalLength,
      Sepal.Width = input$SepalWidth,
      Petal.Length = input$PetalLength,
      Petal.Width = input$PetalWidth
    )
    predict(model_tree, newdata, type = "class")
  })
  
  output$prediction <- renderText({
    prediction()
  })
}

# Exécution de l'application
shinyApp(ui = ui, server = server)