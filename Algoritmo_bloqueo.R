#Para poder realizar la vinculación ambas bases deben tener las siguientes variables:
# id (en minusculas) esta variable debe contener el identificador por cada registro
# nombre_completo_mod (en minusculas) esta variable debe contener el nombre de la persona  concatenado y limpio con el orden nombres, apellido paterno y apellido materno, para limpiar el nombre de debe utilizar la función function_clean_name()
#Tambien se debe asegurar que en el nombre no se concatenen valores NA estos deben eliminar previamente a la limpieza


#Instalar las siguientes librerias
#gdata
#RODBC
#stringdist
#sqldf
#dplyr

#Empieza algoritmo bloqueo

#Cargar las librerias
library(gdata)
library(RODBC)
library(stringdist)
library(sqldf)
library(dplyr)

 

#Obtener bases de datos
con <- odbcConnect("sql_jeha",believeNRows=FALSE)

#Obtener datos para la base A
ENSANUT <- sqlQuery(con, "SELECT id, primer_NOMBRE, SEGUNDO_NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO FROM  [vincula_yelda_gdl_paz].[dbo].[gdl]")

#Concatenar nombres en una sola variable llamada nombre_completo
ENSANUT$nombre_completo <- paste(ENSANUT$primer_NOMBRE, ENSANUT$SEGUNDO_NOMBRE, ENSANUT$PRIMER_APELLIDO, ENSANUT$SEGUNDO_APELLIDO )

#Limpiar el nombre concatenado con la función function_clean_name() y aguardarla en la variable nombre_completo_mod
ENSANUT$nombre_completo_mod <- function_clean_name(ENSANUT$nombre_completo)

#Generar guias de los idices de la base A utilizando la funcion function_block()
block1 <- function_block( nrow(ENSANUT) ,9000) 


#Obtener datos para la base B
INEGI <- sqlQuery(con, "select top  100000 id, nombre_mod, paterno_mod, materno_mod  from [vincula_imss_yelda].[dbo].[seed_2017_2022]")

#Concatenar nombres en una sola variable llamada nombre_completo
INEGI$nombre_completo <- paste(INEGI$nombre_mod, INEGI$paterno_mod, INEGI$materno_mod )

#Limpiar el nombre concatenado con la función function_clean_name() y aguardarla en la variable nombre_completo_mod
INEGI$nombre_completo_mod <- function_clean_name(INEGI$nombre_completo)

#Generar guias de los idices de la base B utilizando la funcion function_block()
block2 <- function_block( nrow(INEGI) ,9000) 



#Empieza sección para generar el bloqueo##################################################################################################

#Obetener total de bloques a procesar
totb <- nrow(block1)*nrow(block2)
bloqueo_list <- vector("list", totb )
p <- 1


timw1  <-  Sys.time()

#recorrer todos los bloques de la base 1
for (a in 1:nrow(block1)){
  
  #obtener los registros para crear el indice de la tabla a
   base_a <-  ENSANUT[ block1[a,2]:block1[a,3] ,]
  
   agregados  <- data.frame(
     id1=character(),
     token=character(), 
     c1=numeric(),
     total=numeric()
   ) 
  
   

   
   result_bd1 <- vector("list", nrow(base_a) )
    
 
  for (b1 in  1:nrow(base_a) ){
    
    
    
    
    guarda <-   qgrams("a", base_a$nombre_completo_mod[ b1 ], q = 3)
  
    primer <- data.frame(   cbind(
              replicate(length(colnames(guarda)),  base_a$id[ b1 ] ),
              colnames(guarda),
              replicate(length(colnames(guarda)),sum(as.vector(guarda[2,])) ),
              as.vector(guarda[2,])
                )
              ) 
  
    colnames(primer) <- c('id1','token', 'c1','total')
  
    #agregados <- rbind(agregados, primer) 
    result_bd1[[b1]] <- primer
    
  }
  
   
   
   
   agregados <- data.frame()
   agregados <- do.call(rbind, result_bd1)
   
   
  for (a2 in 1:nrow(block2) ){
    
    
    
    
    
    #obtener los registros para crear el indice de la tabla b
    base_b <-  INEGI[ block2[a2,2]:block2[a2,3] ,]
    
    
    agregadosbd2  <- data.frame(
      id2=character(),
      token=character(), 
      c1=numeric(),
      total=numeric()
    ) 
    
    result_bd2 <- vector("list", nrow(base_b) )
    
    
    
    for (b2 in  1:nrow(base_b) ){
      
    
      guarda <-   qgrams("a", base_b$nombre_completo_mod[ b2 ], q = 3)
      
      primer <- data.frame(   cbind(
        replicate(length(colnames(guarda)),  base_b$id[ b2 ] ),
        colnames(guarda),
        replicate(length(colnames(guarda)),sum(as.vector(guarda[2,])) ),
        as.vector(guarda[2,])
      )
      ) 
      
      colnames(primer) <- c('id2','token', 'c1','total')
      
       
      
      result_bd2[[b2]] <- primer
      
    }
    

    
    agregadosbd2 <- data.frame()
    agregadosbd2 <- do.call(rbind, result_bd2)
    
    agregados$c1 <- as.numeric(agregados$c1)
    agregados$total <- as.numeric(agregados$total)
    
    agregadosbd2$c1 <- as.numeric(agregadosbd2$c1)
    agregadosbd2$total <- as.numeric(agregadosbd2$total)
    
   
    #generar union 
    RESULTADO <- sqldf('SELECT distinct agregados.id1,  agregadosbd2.id2, cast( sum(   case when  agregados.total<=agregadosbd2.total then agregados.total else agregadosbd2.total end ) as float)/ cast( case when agregados.c1<=agregadosbd2.c1 then cast(agregados.c1 as float) else cast(agregadosbd2.c1 as float) end as float)  AS VER
      FROM agregados 
      INNER JOIN agregadosbd2
      ON agregados.token = agregadosbd2.token   
      group by  agregados.id1,  agregadosbd2.id2 having  cast( sum(   case when  agregados.total<=agregadosbd2.total then agregados.total else agregadosbd2.total end ) as float)/ cast( case when cast(agregados.c1 as float)<=cast(agregadosbd2.c1 as float) then cast(agregados.c1 as float) else cast(agregadosbd2.c1 as float) end as float) >=.825')
    
    
    bloqueo_list[[p]] <- RESULTADO
    
    por <-  round( (p/totb)*100, digits = 3)
  
    print(paste(block1$id[a],'-', block2$id[a2] , por ,'%'))
    p <- p+1
     
  }
  
}
print(Sys.time()- timw1)


#unir bloqueo en un dataframe
bloqueo_fin <- do.call(rbind, bloqueo_list)
