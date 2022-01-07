

# Esta función obtiene la útima silaba de una palabra valida y la primera.
# :return: c(primera silaba, última silaba)
silaba <- function(palabra) {
    
    palabra = tolower(palabra)
    
    silabas = hyphen(palabra, hyph.pattern="es", min.length = 1, quiet = TRUE)

    # Quitar tildes de las sílabas para que haya más coincidencias
    list_silabas = unlist(strsplit(silabas[1,'word'], "-")) %>%
                   str_replace_all("á", "a") %>%
                   str_replace_all("é", "e") %>%
                   str_replace_all("ó", "o") %>%
                   str_replace_all("í", "i") %>%
                   str_replace_all("ú", "u")

    # Primera y Última Sílabas.    
    return(c(list_silabas[1], list_silabas[silabas[1, 'syll']]))
}
