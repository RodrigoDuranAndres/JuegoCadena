#!R.exe --interactive

# -------------------------------------
# Autores: Grupo 2
# Fecha: 28/12/2021
# Descripción: Juego de la cadena 
# Version: 0.1
# --------------------------------------

# Precarga de las librarias necesarias
load("./datos/diccionario_util.rda")
source('./utils.R')

set.seed(1234)

silabas = names(unlist(table(diccionario$primera))) # Saca todas las silabas por las que empieza una palabra

palabras_totales = nrow(diccionario)
ultima_palabra = diccionario[sample(palabras_totales, 1), ] # devuelve una palabra aleatoria 

palabras_usadas = c(ultima_palabra$palabra)


#print(ultima_palabra$palabra)
while (is.element(ultima_palabra$ultima, silabas)){

  posibles_palabras = diccionario[which(diccionario$primera == ultima_palabra$ultima), ]
  posibles_palabras = posibles_palabras[which(!(posibles_palabras$palabra %in% palabras_usadas)), ]
    
  posibles = nrow(posibles_palabras)
  ultima_palabra = posibles_palabras[sample(posibles, 1), ]
  
  palabras_usadas = append(palabras_usadas, ultima_palabra['palabra'])
  
  cat(ultima_palabra$palabra)
}

cat("[JUEGO] La Cadena Resultante del Juego es:")
imprimir_cadena(palabras_usadas, max_per_row=3)