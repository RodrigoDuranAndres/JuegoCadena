# Esta función dice si la palabra introducida es valida.

palabra_valida <- function(dic, palabra1) {
    palabra1 = tolower(palabra1)
    return(nchar(palabra1) > 5 && is.element(palabra1, dic))
}