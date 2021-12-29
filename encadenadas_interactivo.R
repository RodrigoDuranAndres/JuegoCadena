#!/usr/bin/env Rscript --vanilla

# -------------------------------------
# Autores: Grupo 2
# Fecha: 28/12/2021
# Descripción: Juego de la cadena 
# Version: 0.1
# --------------------------------------

# Precarga de las librarias necesarias
if (!require("sylly")) {install.packages('sylly')}
library(sylly)

library(sylly.es)

load("./datos/diccionario.rda")

es_silaba_ganadora <- function(silabas, primera){
    is.element(primera, silabas)
}
# 
# Entry Point
palabras_usadas = c()

while TRUE{
    intentos = 1
    palabraJugador <- readline(prompt = "Elija palabra")
    while (!palabra_valida(diccionario, palabraJugador){
        palabraJugador <- readline(prompt = "Palabra no válida, elija otra")
        if (intentos <= 5){
            print("maquina gana")
            break
        }
        intentos = intentos + 1
    }
    
    
    palabras_usadas = append(palabas_usadas, palabraJugador)
    palabraMaquina =
    sprintf("Palabra de la maquina: %s\n", palabraMaquina)

    # ESCRIBE AQUI
    # Mira el comentario. de donde? en la linea 20. linea 20 de donde? 
    # Comentario: Usa una variable 

}

# Otra forma
turnoJugador = TRUE # Jugador
intentos = 0
ultima_silaba = ""
palabas_usadas = c()
juega_acabado = FALSE

while (!juega_acabado){
    if (turno) {
        if (intentos <= 5){
            # Palabras generada por el jugador
            palabraJugada <- readline(prompt = "Elija palabra") %>% tolower()
            # Ver si la palabra dada es válida
            if (palabra_valida(diccionario, palabraJugada)){
                
                c(uno, dos) = silaba(palabraJugada)
                # Ver si coincide con la silaba primera pedida sino está mal
                if (uno == ultima_silaba){
                    ultima_silaba = dos
                    palabas_usadas = append(palabras_usadas, palabraJugada)
                    turno = FALSE
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
        palabras_posibles = diccionario[diccionario$primera == ultima_silaba && !(diccionario$palabra %in% palabras_usadas)]
        palabras_ganadoras = filter(palabras_posibles, palabra_ganadora(palabras_posibles))
        sprintf("La palabra empieza por una silaba incorrecta. Debe ser %s", ultima_silaba)
        turno = TRUE
    }

    if (palabras_ganadora(diccionario, ultima_silaba)){
        if (turno){ # Turno Bot
            print("La palabra de la maquina es ganadora\nYou are the losser\n :( :( :( :(")
        }else{ # Jugador
            print("Tu palabra es ganadora\nYou are the winner\n :) :) :) :)")
        }
        juega_acabado = TRUE
    }
}