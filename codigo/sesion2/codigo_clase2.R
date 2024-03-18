# Explorando datos de encuesta CEP


# Paquetes

install.packages("tidyverse") #Primera vez que se usa en el pc
install.packages("haven")
install.packages("readxl")
install.packages("janitor")

library(tidyverse) #Cada vez que se inicia una sesión de R
library(haven)
library(readxl)
library(janitor)

# Cargar/importar datos

cep_csv <- read_csv("codigo/sesion2/base_89.csv")
cep_rds <- read_rds("codigo/sesion2/base_89.Rds")
cep_sav <- read_sav("codigo/sesion2/base_89.sav")
cep_xlsx <- read_xlsx("codigo/sesion2/base_89.xlsx")


# Primer ejercicio: tabla de frecuencia


conf_diario <- cep_sav %>% # se inserta con Ctrl + Shift + M
  select(confianza_6_e, sexo) %>% # Selecciona variables
  group_by(confianza_6_e) %>% 
  summarise(frecuencia = n()) %>% 
  ungroup() %>% 
  mutate(porcentaje = frecuencia/sum(frecuencia)*100)

conf_diario

conf_diario <- cep_sav %>% 
  select(confianza_6_e, sexo) %>% 
  group_by(confianza_6_e) %>% 
  summarise(frecuencia = n())

conf_diario


cep_sav %>% 
  group_by(sexo) %>% 
  summarise(edad_prom = mean(edad, na.rm = T),
            edad_mediana = median(edad),
            edad_min = min(edad),
            edad_max = max(edad))
