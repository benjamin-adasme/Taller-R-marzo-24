
pacman::p_load(tidyverse,
               readxl,
               haven)


cep <- read_sav("data/cep/base_89.sav")

names(cep)

sub_cep <- cep %>% 
  select(starts_with("confianza_6"), gse, region, zona_u_r, sexo, edad)

summary(sub_cep)

# Ejercicio con tribunales: frecuencia


sub_cep %>% 
  rename("trib_justicia" = confianza_6_d) %>% 
  group_by(trib_justicia) %>% 
  summarise(n = n()) %>% 
  ungroup() %>% 
  mutate(porc = n/sum(n)*100)

sub_cep %>% 
  rename("trib_justicia" = confianza_6_d) %>% 
  group_by(sexo, trib_justicia) %>% 
  summarise(n = n()) %>% 
  group_by(sexo) %>% 
  mutate(porc = n/sum(n)*100)

