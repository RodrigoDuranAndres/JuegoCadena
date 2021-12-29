#!/usr/bin/env Rscript --vanilla

# -------------------------------------
# Autores: Grupo 2
# Fecha: 28/12/2021
# Descripción: Juego de la cadena 
# Version: 0.1
# --------------------------------------

# Precarga de las librarias necesarias
source("./utils.R")

# Para tests
set.seed(123)

# palabra primera ultima len

# Inicio del Programa
## Precarga de valores.s
load("./datos/diccionario.rda")

es_silaba_ganadora <- function(silabas, primera){
    is.null(silabas[[primera]])
}

silabas = unlist(table(diccionario$primera))
palabras_totales = nrow(diccionario)
ultima_palabra = diccionario[sample(palabras_totales, 1), ] # devuelve una palabra aleatoria 

palabras_usadas = c(ultima_palabra$palabra)

while (!es_silaba_ganadora(silabas, ultima_palabra$ultima)){
    posibles_palabras = diccionario[which(diccionario$primera == ultima_palabra$ultima),]
    posibles_palabras = posibles_palabras[which(!(posibles_palabras$palabra %in% palabras_usadas)),]
    ultima_palabra = posibles_palabras[sample(nrow(posibles_palabras), 1), ]
    palabras_usadas = append(palabas_usadas, ultima_palabra['palabra'])
    print(ultima_palabra$palabra)
}


