#!/usr/bin/env Rscript --vanilla

# -------------------------------------
# Autores: Grupo 2
# Fecha: 28/12/2021
# Descripción: Juego de la cadena 
# Version: 0.1
# --------------------------------------

# Precarga de las librarias necesarias
if (!require("sylly")) {install.packages('sylly')}
if (!require("dplyr")) {install.packages('dplyr')}

library(dplyr)
library(sylly)

if (!require("sylly.es")) {install.sylly.lang("es")}
library(sylly.es)

source("./utils.R")
load("./datos/diccionario.rda")

silabas = names(unlist(table(diccionario$primera)))
es_silaba_ganadora <- function(silabas, primera){
  is.element(primera, silabas)
}


# Código
turnoJugador = TRUE # Jugador
intentos = 0
ultima_silaba = ""
palabras_usadas = c()
juega_acabado = FALSE

while (TRUE){
  if (turnoJugador) {
    if (intentos <= 5){
      # Palabras generada por el jugador
      palabraJugada <- tolower(readline(prompt = "[JUGADOR] Palabra Usada: ")) 
      # Ver si la palabra dada es válida
      if (palabra_valida(diccionario, palabraJugada)){
        
        sil = silaba(palabraJugada)
        # Ver si coincide con la silaba primera pedida sino está mal
        if (grepl(ultima_silaba, sil[1])){
          ultima_silaba = sil[length(sil)]
          palabras_usadas = append(palabras_usadas, palabraJugada)
          intentos = 0
          turnoJugador = FALSE
        }else{
          print(sprintf("La palabra empieza por una silaba incorrecta. Debe ser %s", ultima_silaba))
          intentos = intentos + 1
        }
      }else{
        print("La palabra usada no esta en el diccionario")
        intentos = intentos + 1
      }
    }else{
      print("Has usado demasiados intentos para hallar la palabra.")
      print("Game Over")
      print(" :( :( :( :( :(")
      break
    }
  }else{
    palabras_posibles = diccionario[which(diccionario$primera == ultima_silaba), ]
    palabras_posibles = filter(palabras_posibles,!is.element(palabras_posibles$palabra, palabras_usadas))
    
    if (nrow(palabras_posibles) == 0){
      print("Tu palabra es ganadora")
      print("You are the winner")
      print(":) :) :) :)")
      break
    }else{
      # Obtiene las palabras ganadoras, es decir, aquellas cuya silaba final no sea silaba inicial.
      palabras_ganadoras = filter(palabras_posibles, !is.element(palabras_posibles$ultima, silabas))
      if (nrow(palabras_ganadoras) == 0){
        palabraJugada = palabras_posibles[1, ]
      }else {
        palabraJugada = palabras_ganadoras[1, ]
      }
      # print(palabraJugada)
      palabras_usadas = append(palabras_usadas, palabraJugada$palabra)
      ultima_silaba = palabraJugada$ultima
      print(sprintf("[MAQUINA] Palabra Usada: %s", palabraJugada$palabra))
      turnoJugador = TRUE
    }
  }
  
  if (ultima_silaba != "" && !is.element(ultima_silaba, silabas)){
    if (turnoJugador){ # Turno Bot
      print("La palabra de la maquina es ganadora")
      print("You are the losser")
      print(":( :( :( :(")
    }else{ # Jugador
      print("Tu palabra es ganadora")
      print("You are the winner")
      print(":) :) :) :)")
    }
    break
  }
    print(sprintf("[NOTIFICACIÓN] Siguiente Silaba: %s", ultima_silaba))
}
