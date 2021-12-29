# Esta función dice si la palabra introducida es ganadora (no existen palabras que empiecen por su última sílaba).

palabra_ganadora <- function(diccionario, primera_silaba) {
    return(any(diccionario, primera == primera_silaba))
}