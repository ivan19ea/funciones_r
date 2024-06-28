library(dplyr)

 
bloqueo <- data.frame(
  "id1" =    c(1 ,2 ,3 ,3 ,3  ,4  ,4 ,8 ,9 ,9 ,9  ,9 ,9 ,20 ),
  "id2" =    c(2 ,4 ,5 ,9 ,20 ,54,32 ,1 ,25,34,41 ,68,75,80 ),
  "puntaje"= c(10,8 ,5 ,7 ,10 ,5 , 1 ,5 ,4 ,2 ,41 ,8 ,8  ,1 )
)

bloqueo

bloqueo <- bloqueo %>% 
  group_by(id1 ) %>%
  arrange(desc(puntaje)) %>%  
  mutate(selec = row_number())



bloqueo <- bloqueo %>% 
  arrange(id1)