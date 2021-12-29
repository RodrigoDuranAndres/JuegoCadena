
load("./datos/diccionario.rda")

primeras = unlist(table(diccionario$primera))
silabas  = names(primeras)

pb = txtProgressBar(min=0, max=length(silabas), style=3, char="#")
operacion = list()
for (i in 1:length(silabas)){
  sil = silabas[i]
  hay = primeras[[i]]
  gan = sum(diccionario$ultima == sil)
  operacion[[sil]] = hay - gan * 5
  setTxtProgressBar(pb, i)
}