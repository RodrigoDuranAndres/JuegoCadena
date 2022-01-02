
# Estos son funciones comunes entre varios programas.
if(!require("stringr")){install.packages("stringr")}
library(stringr)

if (!require("sylly")) {install.packages('sylly')}
if (!require("dplyr")) {install.packages('dplyr')}

suppressMessages(library(dplyr))
suppressMessages(library(sylly))

if (!require("sylly.es")) {install.sylly.lang("es")}
suppressMessages(library(sylly.es))


# Shotcut para importar funciones.
source("./utils/palabra_valida.R")
source("./utils/silaba_extremos.R")
source("./utils/print_cadena.R")