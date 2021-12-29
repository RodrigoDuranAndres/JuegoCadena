
library(sylly)

library(sylly.es)

source("./utils.R")
load("./datos/diccionario.rda")

es_silaba_ganadora <- function(silabas, primera){
  is.element(primera, silabas)
}
silabas = unlist(table(diccionario$primera))


# Otra forma
turnoJugador = TRUE # Jugador
intentos = 0
ultima_silaba = ""
palabas_usadas = c()
juega_acabado = FALSE

while (!juega_acabado){
  if (turnoJugador) {
    if (intentos <= 5){
      # Palabras generada por el jugador
      palabraJugada <-tolower(readline(prompt = "Elija palabra: ")) 
      # Ver si la palabra dada es válida
      if (palabra_valida(diccionario, palabraJugada)){
        
        c(uno, dos) = silaba(palabraJugada)
        # Ver si coincide con la silaba primera pedida sino está mal
        if (grepl(ultima_silaba, uno)){
          ultima_silaba = dos
          palabas_usadas = append(palabras_usadas, palabraJugada)
          turnoJugador = FALSE
        }else{
          sprintf("La palabra empieza por una silaba incorrecta. Debe ser %s", ultima_silaba)
          intentos = intentos + 1
        }
        
      }else{
        print("La palabra usada no esta en el diccionario")
        intentos = intentos + 1
      }
    }else{
      print("Has usado demasiados intentos para hallar la palabra.\nGame Over\n :( :( :( :( :(")
      juega_acabado = TRUE
    }
  }else{
    palabras_posibles = diccionario[which(diccionario$primera == ultima_silaba)]
    palabras_posibles = filter(posibles_palabras, function(palabra) {
      !is.element(palabra$palabra, palabas_usadas)
    })
    
    if (nrow(palabras_posibles) == 0){
      print("Tu palabra es ganadora\nYou are the winner\n :) :) :) :)")
      juega_acabado = TRUE
    }else{
      palabras_ganadoras = filter(palabras_posibles, function(palabra) {
        es_silaba_ganadora(silabas, palabra$ultima)
      })
      if(is_empty(palabras_ganadoras)){
        palabraJugada = palabras_posibles[1]
      }else {
        palabraJugada = palabras_ganadoras[1]
      }
      palabas_usadas = append(palabras_usadas, palabraJugada)
      c(primera_silaba, ultima_silaba) = silaba_extremos(palabraJugada)
      sprintf("La palabra jugada por la maquina es: %s", palabraJugada)
      turnoJugador = TRUE
    }
  }
  
  if (ultima_silaba != "" && !is.element(ultima_silaba, silabas)){
    if (turnoJugador){ # Turno Bot
      print("La palabra de la maquina es ganadora\nYou are the losser\n :( :( :( :(")
    }else{ # Jugador
      print("Tu palabra es ganadora\nYou are the winner\n :) :) :) :)")
    }
    juega_acabado = TRUE
  }
}
