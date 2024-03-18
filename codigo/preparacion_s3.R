
# Sesión 3 - gráficos con ggplot2 -----------------------------------------

#### Librerías ####

library(tidyverse)
library(haven)
library(readxl)
library(janitor)

#Instalamos la librería palmerpenguins para el dataset de pinguinos

install.packages("palmerpenguins")

library(palmerpenguins)


#### Datos ####

# Usaremos tres datasets diferentes 

cep_original <- read_sav("codigo/sesion2/base_89.sav")

pinguinos <- penguins

dolar <- read_xls("data/Indicador.xls", skip = 3)


#### 1. Gráfico de barras ####

# Recordamos lo hecho anteriormente

cep_original %>% 
  group_by(confianza_6_e) %>% 
  summarise(frecuencia = n())

# Dos opciones: usar datos originales o de resumen



cep_original %>% 
  ggplot(aes(x = confianza_6_e)) +
  geom_bar()

# Transformamos la variable en factor

cep_nueva <- cep_original %>% 
  mutate(conf_6e_rec = factor(confianza_6_e, 
                              labels = c("Mucha confianza",
                                         "Bastante confianza",
                                         "Poca confianza",
                                         "Nada de confianza",
                                         "No sabe",
                                         "No contesta")))

# Ahora se ve como un gráfico de barras

cep_nueva %>% 
  ggplot(aes(x = conf_6e_rec)) +
  geom_bar()


# Mismo gráfico pero con los datos de resumen creados por nosotros

cep_nueva %>% 
  group_by(conf_6e_rec) %>% # Por defecto el primer argumento es x, el segundo siempre es y
  summarise(freq = n()) %>% 
  ggplot(aes(conf_6e_rec, freq)) +
  geom_col()


# Dos formas de agregar el color: fijo o según la variable

# Color fijo con el argumento fill en geom_col

cep_nueva %>% 
  group_by(conf_6e_rec) %>% 
  summarise(freq = n()) %>% 
  ggplot(aes(conf_6e_rec, freq)) +
  geom_col(fill = "lightgreen")


# Color relativo a la variable con el argumento fill en aes()

cep_nueva %>% 
  group_by(conf_6e_rec) %>% 
  summarise(freq = n()) %>% 
  ggplot(aes(conf_6e_rec, freq)) +
  geom_col(aes(fill = conf_6e_rec))

# También podemos rotar el gráfico para ver mejor las etiquetas

cep_nueva %>% 
  group_by(conf_6e_rec) %>% 
  summarise(freq = n()) %>% 
  ggplot(aes(conf_6e_rec, freq)) + # Es igual que hacer explícito x = ...
  geom_col(aes(fill = conf_6e_rec)) +
  coord_flip()


#### 2. Gráfico de caja/puntos/violin ####


# Usaremos el dataset de pinguinos 

# Cajas + puntos
pinguinos %>% 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_boxplot() +
  geom_jitter(width = 0.2)

# Violín + puntos
pinguinos %>% 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_violin() +
  geom_jitter(width = 0.2)

# Póngamosle color mejor

pinguinos %>% 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_boxplot(aes(fill = species),
               alpha = 0.5) +
  geom_jitter(aes(fill = species),
              width = 0.2,
              shape = 21)

# Mejoremos la visualización con títulos, quitando la leyenda y con un tema predefinido

pinguinos %>% 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_boxplot(aes(fill = species),
               alpha = 0.5) +
  geom_jitter(aes(fill = species),
              width = 0.2,
              shape = 21) +
  labs(title = "Masa según la especie de pingüino",
       subtitle = "Pingüinos del archipiélago Palmer, Antártica",
       x = "Especies",
       y = "Masa corporal (mm)",
       caption = "Datos del paquete palmerpenguins. Gráfico elaborado en el taller Introducción a R y Rstudio, marzo de 2024") +
  theme_minimal() +
  theme(legend.position = "none")

# Lo último. ¿Cambiemos los colores?

pinguinos %>% 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_boxplot(aes(fill = species),
               alpha = 0.5) +
  geom_jitter(aes(fill = species),
              width = 0.2,
              shape = 21) +
  #scale_fill_viridis_d() +
  #scale_fill_brewer(palette = "Set1") +
  #scale_fill_manual(values = c("orange", "lightblue", "purple")) +
  labs(title = "Masa según la especie de pingüino",
       subtitle = "Pingüinos del archipiélago Palmer, Antártica",
       x = "Especies",
       y = "Masa corporal (mm)",
       caption = "Datos del paquete palmerpenguins. Gráfico elaborado en el taller Introducción a R y Rstudio, marzo de 2024") +
  theme_minimal() +
  theme(legend.position = "none")


#### 3. Gráfico de líneas - Serie de tiempo ####

# Con los datos del dolar observado debemos trabajar con fechas.

dolar %>% 
  ggplot(aes(x = Dia, y = Valor)) +
  geom_line()

# Problema: aparecen cortes por los fines de semana. 
# Solución: eliminamos los datos NA

dolar %>% 
  filter(!is.na(Valor)) %>% 
  ggplot(aes(x = Dia, y = Valor)) +
  geom_line()

# De nuevo, pongámosle color

dolar %>% 
  filter(!is.na(Valor)) %>%
  ggplot(aes(x = Dia, y = Valor)) +
  geom_line(color = "coral",
            linetype = 2,
            linewidth = 0.8) +
  theme_linedraw()


# Agreguemos algo nuevo: una etiqueta

dolar %>% 
  mutate(max_val = if_else(Valor == max(dolar$Valor, na.rm = T), 
                           paste0("$", Valor, "\n", Dia),
                           NA)) %>% 
  filter(!is.na(Valor)) %>%
  ggplot(aes(x = Dia, y = Valor)) +
  geom_line(color = "coral",
            linetype = 1,
            linewidth = 0.8) +
  geom_text(aes(label = max_val)) +
  theme_linedraw()

# Extra: agregar medias móviles

dolar %>% 
  filter(!is.na(Valor)) %>% 
  mutate(media_mov = zoo::rollmean(Valor, 7, align = "center", fill = NA)) %>% 
  ggplot(aes(x = Dia, y = media_mov)) +
  geom_line(color = "firebrick3",
            linetype = 1,
            linewidth = 0.8) +
  # geom_text(aes(label = max_val)) +
  theme_linedraw()
