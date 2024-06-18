# primero de todo guardar el codigo modificado y reiniciar R para no asegurarse de que el RAM no esta ocupado

#crear llave pares
df$llave <- paste(bloqueo_ejemplo$id1,'_',bloqueo_ejemplo$id2, sep="")
 
head(llave)

#verificar cuantos pares unicos tenemos
length( unique(llave) )

#borrar pares duplicados
df[!duplicated(df$llave), ]
# o 
df %>% distinct(id1, id2, .keep_all = TRUE)

max(bloqueo_ejemplo$VER)
min(bloqueo_ejemplo$VER)

# si se borran muchos, comprueba si se puede correr la tabla sin acabar con el RAM
 # si no comprueba los valores menores/iguales a 1 y avisa a Ivan

#filtrar pares con similitud menor o igual a 1
comprueba <- bloqueo_ejemplo[which(bloqueo_ejemplo$VER<=1),]

# filtrar pares con similitud mayor que 1
comprueba2 <- bloqueo_ejemplo[which(bloqueo_ejemplo$VER>1),]

