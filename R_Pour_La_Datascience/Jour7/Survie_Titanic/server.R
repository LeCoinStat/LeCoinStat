#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {
  
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
