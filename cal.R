
load("./datos/diccionario.rda")

diccionario$ultima = str_replace_all(diccionario$ultima, "á", "a") %>%
  str_replace("é", "e") %>% str_replace_all("í", "i") %>%
  str_replace("ó", "o") %>% str_replace_all("ú", "u")




primeras = unlist(table(diccionario$primera))
silabas  = names(primeras)

pb = txtProgressBar(min=0, max=length(silabas), style=3, char="#")
operacion = list()
for (i in 1:length(silabas)){
  sil = silabas[i]
  total = primeras[[i]]
  ultimas = diccionario[diccionario$primera == sil, 'ultima']
  gan = sum(is.element(ultimas, silabas))
  operacion[[sil]] = gan / total
  setTxtProgressBar(pb, i)
}
close(pb)
ops = rep(0.0, each=nrow(diccionario))

t = nrow(diccionario)
pb = txtProgressBar(min=0, max=t, style=3, char="#")

pertenece = is.element(diccionario$ultima, silabas)

for (k in 1:t){
  if (pertenece[k]){
    ops[k] = operacion[[diccionario[k, 'ultima']]]
  }
  if (k == t){
    close(pb)    
  }else{
    setTxtProgressBar(pb, k)
    
  }
}

diccionario$con = ops

save(diccionario, file="./datos/diccionario_util.rda")
