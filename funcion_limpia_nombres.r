
#Función para limpiar y estandarizar nombres 
function_clean_name <- function(nomb) { 
 
  
  NOMBRE <- nomb
  NOMBRE <- trimws(toupper(NOMBRE))
  
  NOMBRE <- gsub('[0-9]+', '', gsub('[^[:alnum:] ]','',NOMBRE) )
  
  NOMBRE <- gsub('Á','A',NOMBRE)
  NOMBRE <- gsub('É','E',NOMBRE)
  NOMBRE <- gsub('Í','I',NOMBRE)
  NOMBRE <- gsub('Ó','O',NOMBRE)
  NOMBRE <- gsub('Ú','U',NOMBRE)
  
  
  NOMBRE <-  gsub('\\bDE\\b','',NOMBRE)
  NOMBRE <-  gsub('\\bDEL\\b','',NOMBRE)
  NOMBRE <-  gsub('\\bLA\\b','',NOMBRE)
  NOMBRE <-  gsub('\\bLOS\\b','',NOMBRE)
 
  NOMBRE <-  gsub('\\bMA\\b'  , 'MARIA',NOMBRE )
  NOMBRE <-  gsub('\\bFCO\\b' , 'FRANCISCO',NOMBRE)
  NOMBRE <-  gsub('\\bGPE\\b' , 'GUADALUPE',NOMBRE)
  NOMBRE <-  gsub('\\bLUPE\\b', 'GUADALUPE',NOMBRE)
  NOMBRE <-  gsub('\\bFDA\\b' , 'FERNANDA ',NOMBRE)
  NOMBRE <-  gsub('\\bFDO\\b' , 'FERNANDO',NOMBRE)
  NOMBRE <-  gsub('\\bHDZ\\b' , 'HERNANDEZ',NOMBRE)
  NOMBRE <-  gsub('\\bHDEZ\\b', 'HERNANDEZ',NOMBRE)
  NOMBRE <-  gsub('\\bMTZ\\b' , 'MARTINEZ',NOMBRE)
 
  
  NOMBRE <- gsub('V','B',NOMBRE)
  NOMBRE <- gsub('Z','S',NOMBRE)
  NOMBRE <- gsub('N','M',NOMBRE)
  NOMBRE <- gsub('Ñ','M',NOMBRE)
  NOMBRE <- gsub('K','C',NOMBRE)
  NOMBRE <- gsub('Y','I',NOMBRE)
  
  NOMBRE <- gsub('([[:alpha:]])\\1+', '\\1', NOMBRE)
  
  NOMBRE <- trimws(gsub('( )\\1+', '\\1', NOMBRE))
  
 
  return (NOMBRE)
}



#Ejemplo limpiar nombres en un data frame y asignarlo a una nueva variable
Ensanut$nombre_mod  <-  function_clean_name( Ensanut$nombre_original )