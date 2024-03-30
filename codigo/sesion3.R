
# Ejercicio 3 -------------------------------------------------------------

# Librerías

library(tidyverse)
library(haven)
library(janitor)
library(palmerpenguins)
library(readxl)

# Cargar datos

cep_original <- read_sav("data/cep/base_89.sav")

# 1. Gráfico de barras

# Usaremos la misma variable que usamos en la clase dos
# Confianza en los diarios (confianza_6_e)

frec_confianza <- cep_original %>% 
  group_by(confianza_6_e) %>% 
  summarise(frecuencia = n())

# Ahora vamos a graficar

ggplot(data = frec_confianza, 
       mapping = aes(x = confianza_6_e, y = frecuencia)) +
  geom_col()

# Tenemos que transformar los datos

# Crear un factor

frec_diarios <- frec_confianza %>% 
  mutate(confianza_6_e = factor(confianza_6_e, 
                                labels = c("Mucha confianza",
                                           "Bastante confianza",
                                           "Poca confianza",
                                           "Nada de confianza",
                                           "No sabe",
                                           "No contesta")))

barras <- frec_diarios %>% 
  ggplot(aes(confianza_6_e, frecuencia)) +
  geom_col()

barras

# geom_bar

cep_original %>% 
  mutate(confianza_6_e = factor(confianza_6_e, 
                                labels = c("Mucha confianza",
                                           "Bastante confianza",
                                           "Poca confianza",
                                           "Nada de confianza",
                                           "No sabe",
                                           "No contesta"))) %>% 
  ggplot(aes(confianza_6_e)) +
  geom_bar()

# Ponerle color

#Color fijo
frec_diarios %>% 
  ggplot(aes(confianza_6_e, frecuencia)) +
  geom_col(fill = "lightgreen")

#Color de acuerdo a la categoría
frec_diarios %>% 
  ggplot(aes(confianza_6_e, frecuencia)) +
  geom_col(aes(fill = confianza_6_e), 
           color = "black",
           linewidth = 1)

# Ultimos detalles

frec_diarios %>% 
  ggplot(aes(confianza_6_e, frecuencia)) +
  geom_col(aes(fill = confianza_6_e), 
           color = "black",
           linewidth = 1) +
  labs(x = "Confianza en los diarios",
       y = "Frecuencia",
       title = "¿Cuánto confian los encuestados en los diarios?",
       subtitle = "Respuesta a pregunta confianza_6_e",
       caption = "Fuente: Encuesta CEP N° 89") +
  theme_minimal()


# 2. Gráfico de cajas, violín o puntos

pinguinos <- penguins

# Cajas

pinguinos %>% 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_boxplot()

# Violín

pinguinos %>% 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_violin()

# Puntos

pinguinos %>% 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_point()

# Jitter

pinguinos %>% 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_jitter(width = 0.15)

# Combinamos 2 geometrías

pinguinos %>% 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_boxplot() +
  geom_jitter(width = 0.15)

# Póngamosle color

pinguinos %>% 
  ggplot(aes(x = species, y = body_mass_g, fill = species)) +
  geom_boxplot() +
  geom_jitter(width = 0.15, shape = 21)

# Démonos color

pinguinos %>% 
  ggplot(aes(x = species, y = body_mass_g, fill = species)) +
  geom_boxplot(alpha = 0.5) +
  geom_jitter(width = 0.15, shape = 21) +
  scale_fill_viridis_d()

# Últimos detalles

pinguinos %>% 
  ggplot(aes(x = species, y = body_mass_g, fill = species)) +
  geom_boxplot(alpha = 0.5) +
  geom_jitter(width = 0.15, shape = 21) +
  scale_fill_viridis_d() +
  labs(x = "Especies",
       y = "Masa corporal (g)") +
  theme_bw() +
  theme(legend.position = "none")


#### EXTRA: GRÁFICO DE LÍNEA ####

# Cargamos los datos del dolar observado de 2023
dolar <- read_xls("data/Indicador.xls", skip = 3)

# Verificamos que la columna día es de tipo POSIXct
# Es la clase que tiene R para trabajar con fechas
class(dolar$Dia)

dolar %>%
  filter(!is.na(Valor)) %>% #Quitamos días sin valor
  ggplot(aes(Dia, Valor)) +
  geom_line()

dolar %>%
  filter(!is.na(Valor)) %>% #Quitamos días sin valor
  ggplot(aes(Dia, Valor)) +
  geom_line(color = "steelblue")

## Media móvil

dolar_mov <- dolar %>%
  filter(!is.na(Valor)) %>%
  mutate(val_3 = zoo::rollmean(Valor, k = 3, fill = NA, align = "center"),
         val_5 = zoo::rollmean(Valor, k = 5, fill = NA, align = "center"),
         val_7 = zoo::rollmean(Valor, k = 7, fill = NA, align = "center"))

dolar_mov %>%
  pivot_longer(2:5, names_to = "medicion", values_to = "valores") %>%
  ggplot(aes(Dia, valores, group = medicion, color = medicion)) +
  geom_line()


dolar_mov %>%
  pivot_longer(2:5, names_to = "medicion", values_to = "valores") %>%
  ggplot(aes(Dia, valores, group = medicion, color = medicion)) +
  geom_line() +
  scale_color_manual(
    values = c("coral", 
    "steelblue", 
    "purple2", 
    "lightgreen")) +
  facet_wrap(~medicion)
