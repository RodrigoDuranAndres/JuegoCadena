#!R.exe --interactive

# -------------------------------------
# Autores: Grupo 2
# Fecha: 28/12/2021
# Descripción: Juego de la cadena 
# Version: 0.1
# --------------------------------------

# Precarga de las librarias necesarias
if(!interactive()){
    cat("\n[ERROR] the application should be run interactively\n")
    q()   
}


if (!require("sylly")) {install.packages('sylly')}
if (!require("dplyr")) {install.packages('dplyr')}

suppressMessages(library(dplyr))
suppressMessages(library(sylly))

if (!require("sylly.es")) {install.sylly.lang("es")}
suppressMessages(library(sylly.es))

source("./utils.R")
load("./datos/diccionario_util.rda")


# Configuración IA
## TODO Pedir al jugador el nivel de difilcultad
# Dificultad 1-10
# Cada nivel de difilcultad, da un 10% de que la IA coga la mejor palabra.

dificultad = as.integer(readline("[JUEGO] Decida el Nivel de Dificultad (1-10): "))
if (dificultad > 11 || dificultad < 1){
    dificultad = 5
}

silabas = names(unlist(table(diccionario$primera)))
es_silaba_ganadora <- function(silabas, primera){
  is.element(primera, silabas)
}

# Probabilidades de la IA
prob_buena = 0.075 * dificultad
print(prob_buena)

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
          intentos = 0
          turnoJugador = FALSE
          palabras_usadas <- append(palabras_usadas, palabraJugada)
        }else{
          cat(sprintf("La palabra empieza por una silaba incorrecta. Debe ser %s\n", ultima_silaba))
          intentos = intentos + 1
        }
      }else{
        cat("La palabra usada no esta en el diccionario\n")
        intentos = intentos + 1
      }
    }else{
      cat("Has usado demasiados intentos para hallar la palabra.\n")
      cat("Game Over\n")
      cat(" :( :( :( :( :(\n")
      break
    }
  }else{
    palabras_posibles = diccionario[which(diccionario$primera == ultima_silaba), ]
    palabras_posibles = filter(palabras_posibles,!is.element(palabras_posibles$palabra, palabras_usadas))
    
    if (nrow(palabras_posibles) == 0){
      cat("Tu palabra es ganadora\n")
      cat("You are the winner\n")
      cat(":) :) :) :)\n")
      break
    }else{
      # Se puede usar el ranking pero inverso para esto.
      # Obtiene las palabras ganadoras, es decir, aquellas cuya silaba final no sea silaba inicial.
      palabras_ganadoras = filter(palabras_posibles, !is.element(palabras_posibles$ultima, silabas))
      decision = runif(1) # Decide si la IA coge o no una palabra ganadora o no.
      if (nrow(palabras_ganadoras) != 0 && decision <= prob_buena){
        palabraJugada = palabras_ganadoras[1, ]
      }else {
        palabraJugada = palabras_posibles[1, ]
      }
      # cat(palabraJugada)
      ultima_silaba = palabraJugada$ultima
      cat(sprintf("[MAQUINA] Palabra Usada: %s\n", palabraJugada$palabra))
      palabras_usadas <- append(palabras_usadas, palabraJugada$palabra)
      turnoJugador = TRUE
    }
  }
  
  cat(sprintf("[JUEGO] Siguiente Silaba: %s\n", ultima_silaba))  
  if (ultima_silaba != "" && !is.element(ultima_silaba, silabas)){
    cat("\n")
    if (turnoJugador){ # Turno Bot
      cat("La palabra de la maquina es ganadora\n")
      cat("You are the losser\n")
      cat(":( :( :( :(\n")
    }else{ # Jugador
      cat("Tu palabra es ganadora\n")
      cat("You are the winner\n")
      cat(":) :) :) :)\n")
    }
    break
  }
}

cat("\n[JUEGO] La Cadena Resultante del Juego es:\n")
imprimir_cadena(palabras_usadas, max_per_row=2)