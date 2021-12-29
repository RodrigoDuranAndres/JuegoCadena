
load("./palabras_divididas.rda")

dicc = readLines("./datos/dic_es.txt", encoding = "UTF-8");
dicc = trimws(dicc);
dicc = dicc[nchar(dicc) >=5]
dicc = tolower(dicc[!grepl("^[A-Z].*", dicc)]);

# 


diccionario = data.frame(
  palabra = character(),
  primera = character(),
  ultima  = character(),
  len     = integer()
)

palabras = palabras_divididas@hyphen

total = nrow(palabras)
pb = txtProgressBar(min=1, max=total, initial=0, char="#", width=50L)
palabras_unir = list()
for (i in 1:total){
  silabas = unlist(strsplit(palabras[i, 'word'], '-'))
  
  add = data.frame(
    primera = silabas[1],
    ultima  = silabas[length(silabas)],
    palabra = dicc[i],
    len = palabras[i, 'syll']
  )
  palabras_unir[[i]] = add  
  # Barra de Carga
  setTxtProgressBar(pb, i, "Progreso:", "Fin")
}

diccionario = dplyr::bind_rows(palabras_unir)


close(pb)
save(diccionario, file="./diccionario.Rda")

