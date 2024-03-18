

# Primer código de R en el Taller

2 + 2 # Esto es una suma

3*4

# Operadores de comparación

8 < 2

8 > 2

4 * 5 == 20

8 != 2


objeto <- c(1 , 4, 9)

# CLases de objetos

numero <- c(0.7, -13, 100)

class(numero)

mi_texto <- "mi cuento del día de hoy"

class(mi_texto)

is.numeric(numero)

is.numeric(mi_texto)

numero


# Trabajando con data frame

df <- data.frame(var1 = 1:4, 
                 var2 = c("a", "b", "c", NA), 
                 otro_nom = c(TRUE, TRUE, FALSE, TRUE))

df                 

View(df)


# Desafío
# 
# 1 Crear 5 vectores, uno correspondiente cada clase de objetos que revisamos, y guardarlos por separado. Deben tener una longitud mínima de 6 elementos. El nombre de cada objeto debe indicar su clase (ej. vector_numero, obj_log, vcadena, etc. )
# 

#Vector 1
enteros <- c(3L, 45L, 7L, 65L, 0L, 8L)

class(enteros)

# Vector 2
decimales <- c(0.3 , 0.2, 1.1, 2.2, -0.004, 6)

class(decimales)

# Vector 3
texto <- rep("a", 6)

class(texto)

# Vector 4
logicos <- c(TRUE, FALSE, FALSE, TRUE, FALSE, TRUE)

class(logicos)

# Vector 5
var1 <- c(6, 8, 8, 8, 8, 6)

var1_factor <- factor(var1, labels = c("Sí", "No"))

var1_factor

# Creamos el data frame con los objetos/vectores y la función data.frame()
mi_tabla <- data.frame(enteros,
                       decimales,
                       texto,
                       logicos,
                       var1_factor)

# Sacamos el promedio de una varible con la función mean() y el signo $ para llamar la variable.

promedio_dec <- mean(mi_tabla$decimales)

promedio_dec
