

library(sqldf)

#Reemplazar nombres de las variables
resultado_ensanut_06_pares <- sqldf('select b.*, c.* from bloqueo_fin as a left join 
(SELECT id, nombre_completo_mod AS nombre_completo_mod_eEN  , SEXO AS SEXO_EN, ENTIDAD as ENTIDAD_EN , MUNIC AS MUNIC_EN , DIA_NAC_EN, MES_NAC_EN, ANIO_NAC_EN, FECHA_NAC_EN   FROM ENSANUT)b ON a.id1=b.id 
left join(select id, nombre_completo_mod AS nombre_completo_mod_IN  , SEXO AS SEXO_IN, ENTIDAD as ENTIDAD_IN , MUNIC AS MUNIC_IN , DIA_NAC_IN, MES_NAC_IN, ANIO_NAC_IN, FECHA_NAC_IN from INEGI)c on c.id=a.id2 ')

