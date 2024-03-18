# Desafio 

#

enteros <- c(3L, 45L, 7L, 65L, 0L, 8L)

class(enteros)

decimales <-c(0.3, 0.2, 1.1, 2.2, -0.004, 6)

class(decimales)

texto <- rep("a", 6)

logicos <- c(TRUE, FALSE, FALSE, TRUE, FALSE, TRUE)

var1 <- c(6, 8, 8, 8, 8, 6)

var1_factor <- factor(var1, labels = c("si", "no"))

var1_factor

mi_tabla <- data.frame(enteros,
                       decimales,
                       texto,
                       logicos,
                       var1_factor)

mean(mi_tabla$enteros)

promedio_ent <- mean(mi_tabla$enteros)

promedio_ent


                      