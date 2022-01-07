#!R.exe --interactive

# -------------------------------------
# Autores: Grupo 2
# Fecha: 28/12/2021
# Descripción: Juego de la cadena 
# Version: 0.1
# --------------------------------------

# Precarga de las librarias necesarias
source("./utils.R")

# Precarga de las librarias necesarias
load("./datos/diccionario.rda") # primera ultima palabra len con

# Función que permite averiguar si una silaba es ganadora
es_silaba_ganadora <- function(silabas, primera_silaba){
  is.element(primera_silaba, silabas)
}

silabas = names(unlist(table(diccionario$primera)))

palabras_totales = nrow(diccionario)
ultima_palabra = diccionario[sample(palabras_totales, 1), ] # devuelve una palabra aleatoria 

palabras_usadas = c(ultima_palabra$palabra)

#print(ultima_palabra$palabra)
while (is.element(ultima_palabra$ultima, silabas)){

  posibles_palabras = diccionario[which(diccionario$primera == ultima_palabra$ultima), ]
  posibles_palabras = posibles_palabras[which(!(posibles_palabras$palabra %in% palabras_usadas)), ]
  if(nrow(posibles_palabras) == 0){
      break
  }

  #posibles = nrow(posibles_palabras)
  
  posibles_ranking = posibles_palabras[order(posibles_palabras$con), ]
  ultima_palabra = posibles_ranking[nrow(posibles_ranking), ]
  palabras_usadas = append(palabras_usadas, ultima_palabra$palabra)
}
print(palabras_usadas)
cat("[JUEGO] La Cadena Resultante del Juego es:\n")
imprimir_cadena(palabras_usadas, max_per_row=3)
cat(sprintf("\nLongitud de la Cadena %d\n", length(palabras_usadas)))