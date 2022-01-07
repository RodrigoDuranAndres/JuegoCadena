# Esta función dice si la palabra introducida es valida.

es_palabra_valida <- function(dic, palabra1) {
    palabra1 = tolower(trimws(palabra1))
    return(nchar(palabra1) >= 5 && is.element(palabra1, dic$palabra))
}