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

#filtrar pares con similitud menor o igual a 1
comprueba <- bloqueo_ejemplo[which(bloqueo_ejemplo$VER<=1),]
