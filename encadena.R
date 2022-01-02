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

silabas = names(unlist(table(diccionario$primera))) # Saca todas las silabas por las que empieza una palabra


# Palabra Inicial
ultima_palabra = tolower(readline("[JUEGO] Dar una Palabra Inicial (+5 letras): "))
while (!es_palabra_valida(diccionario, ultima_palabra)){
    print("[JUEGO] La Palabra Dada no es Válida. Introduzca una nueva.\n Debe estar en el diccionario de la RAE y tener más o igual a 5 letras.\n")
    ultima_palabra = tolower(readlines("[JUEGO] Dar una Palabra Inicial (+5 letras): "))
}

ultima_palabra = diccionario[diccionario$palabra == ultima_palabra, ] # devuelve una palabra aleatoria 

palabras_usadas = c(ultima_palabra$palabra)

#print(ultima_palabra$palabra)
while (is.element(ultima_palabra$ultima, silabas)){

  posibles_palabras = diccionario[which(diccionario$primera == ultima_palabra$ultima), ]
  posibles_palabras = posibles_palabras[which(!(posibles_palabras$palabra %in% palabras_usadas)), ]
    
  posibles = nrow(posibles_palabras)
  ultima_palabra = posibles_palabras[sample(posibles, 1), ]
  
  palabras_usadas = append(palabras_usadas, ultima_palabra['palabra'])
  
}

cat("\n[JUEGO] La Cadena Resultante del Juego es:\n")
imprimir_cadena(palabras_usadas, max_per_row=3)