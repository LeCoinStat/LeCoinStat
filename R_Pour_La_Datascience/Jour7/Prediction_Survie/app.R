#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput("Pclass","Classe du passager", c("1","2","3"), NULL),
      selectInput("Sex", "Quel est le genre du passager", c("male","female")),
      numericInput("Age", "Quel est l'âge du passage", 0, min = 0, max = 120),
      numericInput("SibSp", "Nombre de frères/soeurs ou époux/épouses à bord", 0, min = 0, max = 8),
      numericInput("Parch", "Nombre de parents/enfants à bord", 0, min = 0, max = 10),
      numericInput("Fare", "Tarif", 32, min = 0, max = 3000)
      
      
      
      
    ),
    mainPanel(textOutput("prediction"))

  )

)

# Define server logic required to draw a histogram
server <- function(input, output) {

  modele_logistique <- readRDS("/Users/natachanjongwayepnga/Documents/GitHub/LeCoinStat/R_Pour_La_Datascience/Jour7/model_logistique.rds") 
  
  output$prediction <- renderText({
    
    # Préparation des données
    new_data <- data.frame(
      
      Pclass = as.factor(input$Pclass),
      Sex = as.factor(input$Sex),
      Age = as.numeric(input$Age),
      SibSp = as.numeric(input$SibSp),
      Parch = as.numeric(input$Parch),
      Fare = as.numeric(input$Fare)
      
    )
    
    # Prédiction
    prob <- predict(modele_logistique, newdata = new_data, type = "response")
    
    pred <- ifelse(prob > 0.5, "Survie", "Non survie")
    
    paste(pred, " avec une probabilité de ", prob)
    
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
