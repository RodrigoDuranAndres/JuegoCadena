
load("./datos/diccionario.rda")

silabas = unlist(table(diccionario$primera))

is_winner <- function(silabas, primera){
    !is.element(primera, names(silabas))
}

total = nrow(diccionario)

pb = txtProgressBar(min=1, max=total, initial=0, char="*", width=50L, style=3)

operacion = list()

for (i in 1:total){

  setTxtProgressBar(pb, i)
  
  ultima = diccionario$ultima[i];
  posibles_palabras = filter(diccionario, diccionario$primera == ultima)
  palabras_ganadoras = 0
  for (j in 1:nrow(posibles_palabras)){
      palabras_ganadoras = palabras_ganadoras + is_winner(silabas, posibles_palabras$primera[j])
  }
  operacion[[i]] = nrow(posibles_palabras) - length(palabras_ganadoras)*10
  
  
  # Barra de Carga
}
close(pb)

diccionario$con = operacion
# diccionario = dplyr::bind_rows(palabras_unir)

save(diccionario, file="./diccionario_util.rda")
