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
library(DT)
# Define UI for application that draws a histogram
ui <- dashboardPage(
  
  dashboardHeader(title = "Prédiction de la survie sur le Titanic"),
  
  dashboardSidebar(
    
    sidebarMenu(
      
      menuItem("Importation des données", tabName = "importCVS", icon = icon("file-csv")),
      menuItem("Afficher le csv", tabName = "affichage", icon = icon("table")),
      menuItem("Données", tabName = "predictions")
      
    )
    
    
    
  ),
  dashboardBody(
    
    tabItems(
      
      tabItem(tabName = "importCVS",
              
              fileInput("fileInput", "Choisir un fichier CSV",
                        accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
              actionButton("loadData", "Charger les données")), 
              
      tabItem(tabName = "affichage", DTOutput("dataTable")),
      
      tabItem(tabName = "predictions", DTOutput("predictionsTable"))
      
      
    )
    
    
    
  )
  
  
  
  
  
)
