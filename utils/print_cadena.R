
# Imprime en pantaña la cadena de palabras que se genera durante la ejecución del programa
# cadena: character()
imprimir_cadena <- function(cadena, max_per_row=3) {
 
    n = length(cadena)
    row = "\"\""
    for (i in 1:n){
        row = sprintf("%s -> %s", row, cadena[i])
    
        if ((i %% max_per_row) == 0){
            print(row)
            row = cadena[i]
        }
    }
}