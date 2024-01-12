#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 11 21:12:43 2024

@author: natachanjongwayepnga
"""

def statdescriptive(nom_liste):
    """
        Cette fonction permet de faire des statistiques descriptives sur une liste
        parameters:
            nom_liste: liste de nombre
    """
    minimum = min(nom_liste)
    maximum = max(nom_liste)
    somme = sum(nom_liste)
    moyenne = somme/len(nom_liste)
    resultat = {"min":minimum, "max":maximum,"somme":somme, "moyenne":moyenne}
    
    return resultat

def somme_element(nom_liste):
    """
        Cette fonction permet de calculer une somme
    
    """
    return sum(nom_liste)
