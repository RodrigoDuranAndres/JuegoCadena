
if (!require("sylly")) {install.packages('sylly')}
library(sylly)

library(sylly.es)

# Carga del diccionario para ser posteriormente analizado y divido por 
# su silaba iniciañ

diccionario = readLines("./dic_es.txt", encoding = "UTF-8");
diccionario_completo = paste(diccionario, collapse="_ ")

# Sacamos todas las silabas iniciales de cada palabra y las guardamos

# Filtro Nombres Propios y Otros. También se filtran todas las palabras con
# un tamaño incorrecto

diccionario = diccionario[nchar(diccionario) >=5]

prohibidas = tolower(diccionario[grepl("^[A-Z].*", diccionario)]);

# Sacamos las 

hyph.txt.es <- hyphen(diccionario, hyph.pattern="es", min.length=1)
# Guardamos el array en  un archivo .RData o .dat
