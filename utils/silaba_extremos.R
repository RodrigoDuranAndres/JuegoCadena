

# Esta función obtiene la útima silaba de una palabra valida y la primera.
# :return: c(primera silaba, última silaba)
silaba <- function(palabra) {
    palabra = tolower(palabra)
    silabas = hyphen(palabra, hyph.pattern="es", min.length = 1, quiet = TRUE)
    list_silabas = unlist(strsplit(silabas[1,'word'], "-"))

    return(c(list_silabas[1], list_silabas[silabas[1, 'syll']]))
}
