#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram
ui <- dashboardPage(
  
  dashboardHeader(title = "Prédiction de la survie sur le Titanic"),
  
  dashboardSidebar(
    
    sidebarMenu(
      menuItem("Inputs", tabName = "Inputs", icon = icon("input")),
      menuItem("Prediction", tabName = "Prediction", icon = icon("dashboard")),
      menuItem("Données", tabName = "Prediction")
      
    )
    
    
    
  ),
  dashboardBody(
    
    tabItems(
      
      tabItem(tabName = "Inputs",
              
              selectInput("Pclass", "Classe de passager", c("1", "2", "3")),
              selectInput("Sex", "Sexe", choices = c("male" = "male", "female" = "female")),
              numericInput("Age", "Âge", 30, min = 0, max = 100),
              numericInput("SibSp", "Nombre de frères/soeurs ou époux/épouses à bord", 0, min = 0, max = 8),
              numericInput("Parch", "Nombre de parents/enfants à bord", 0, min = 0, max = 6),
              numericInput("Fare", "Tarif", 32, min = 0, max = 3000),
              textInput("Nom", "Quel est votre nom?", value = "")
          
              ),
      tabItem(tabName = "Prediction",
              h2("Le résultat de la prédictiton"),
              textOutput("prediction")
              )
      
      
    )
    
    
    
  )
  
  
  
  
  
)
