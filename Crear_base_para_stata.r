install.packages("RecordLinkage")
 
 library(RecordLinkage)
 
 
 nombre_completo_mod_eEN s1 nombre
 SEXO                    s2 sexo
 ENTIDAD_RESIDENCIA      s3
 MUNICIPIO RESIDENCIA    s4
 ENTIDAD_NACIMIENTO      s5     
 DIA NACIMEINTO          s6
 MES NACIMEINTO          s7
 AÑO NACIMIENTO          s8
 
 
 
 head( resultado_ensanut_06_pares)
 
 #crear variable similitud nombres
 resultado_ensanut_06_pares$nomb_simi <-  levenshteinSim(resultado_ensanut_06_pares$nombre_completo_mod_eEN, resultado_ensanut_06_pares$nombre_completo_mod_IN) 
 
 #crear variables s1 a s8
 resultado_ensanut_06_pares$s1 <- ifelse(resultado_ensanut_06_pares$nomb_simi>=.90,1,0)
   
   resultado_ensanut_06_pares$s2  <- ifelse(resultado_ensanut_06_pares$ENTIDAD_EN==resultado_ensanut_06_pares$ENTIDAD_IN,1,0)

   resultado_ensanut_06_pares$s3  <- ifelse(resultado_ensanut_06_pares$ANIO_NAC_EN==resultado_ensanut_06_pares$ANIO_NAC_IN,1,0)

   ID_ENSANUT, ID_INEGI, S1, S2, .... S8 SCORE

# guarda como CSV grande
write.csv(df, "specify_path_and_file_name.csv")
