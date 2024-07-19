
# crear la variable de calidad de match

# positivo asegurado -> todo 0 
positivo$puntuacion <- "0"
positivo$corto <- "0"
positivo$loc_dif <- "0"
positivo$invertido <- "0"
positivo$anio_dif <- "0"
positivo$dia_mes_dif <- "0"
positivo$fecha_dif <- "0"

# positivo dudoso 

# puntuacion baja

maybe$puntuacion <- ifelse(maybe$nomb_simi<=0,9,1,0)
  
# por nombre corto -> 1 o 0
# genera variable = 1 cuando hay menos de 3 palabras
maybe$corto <- ifesle(data$palabras < 3, 1, 0)

# por localidad distinta -> 1 o 0
  # misma formula que al crear S1
maybe$loc_dif <- ifelse(maybe$loc_en == maybe$loc_def, 0, 1)

# por mes y dia invertido -> 1 o 0

maybe$invertido <- "1"

# por año diferente -> 1 o 0

maybe$anio_dif <- "1"

# por dia y mes diferente -> 1 o 0
  
maybe$dia_mes_dif <- "1"

# por fecha entera diferente -> 1 o 0

maybe$fecha_dif <- "1"

# juntar todas las bases de datos
positivos_total <- rbind(positivo, maybe)


# revisar que no haya duplicados
sum(duplicated(positivos_total$id_en))
positivos_total_copia <- positivos_total
positivos_total_copia$pares <- paste(positivos_total_copia$id_en, positivos_total_copia$id_df)
sum(duplicated(positivos_total_copia$pares))
rm(positivos_total_copia)

# reemplazar celdas vacias por 0
positivos_total$puntuacion <- positivos_total[is.na(positivos_total$puntuacion)] <- 0
positivos_total$corto <- positivos_total[is.na(positivos_total$corto)] <- 0
positivos_total$loc_dif <- positivos_total[is.na(positivos_total$loc_dif)] <- 0
positivos_total$invertido <- positivos_total[is.na(positivos_total$invertido)] <- 0
positivos_total$anio_dif <- positivos_total[is.na(positivos_total$anio_dif)] <- 0
positivos_total$dia_mes_dif <- positivos_total[is.na(positivos_total$dia_mes_dif)] <- 0
positivos_total$fecha_dif <- positivos_total[is.na(positivos_total$fecha_dif)] <- 0

# revisar la distribucion de las variables



# concatenar celdas de calidad en una sola variable
positivos_total$calidad_vinculo <- paste(positivos_total$puntuacion, positivos_total$corto, 
                                         positivos_total$loc_dif, positivos_total$invertido, 
                                         positivos_total$anio_dif, positivos_total$dia_mes_dif, 
                                         positivos_total$fecha_dif)

# crear base de datos
resultados <- data.frame(positivos_total$id_en, positivos_total$id_def, 
                         positivos_total$calidad_vinculo)




