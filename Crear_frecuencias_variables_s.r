

library(sqldf)

tabla_1 <- sqldf("select distinct s1, s2, s3, s4, s5, s6, s7, s8, count(*) as total  from nombre_tabla group by s1, s2, s3, s4, s5, s6, s7, s8")
tabla_mayor_cero <- sqldf("select distinct s1, s2, s3, s4, s5, s6, s7, s8, count(*) as total  from nombre_tabla where puntaje>0 group by s1, s2, s3, s4, s5, s6, s7, s8")
tabla_menor_cero <- sqldf("select distinct s1, s2, s3, s4, s5, s6, s7, s8, count(*) as total  from nombre_tabla where puntaje<=0 group by s1, s2, s3, s4, s5, s6, s7, s8")