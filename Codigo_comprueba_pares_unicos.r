#crear llave pares
llave <- paste(bloqueo_ejemplo$id1,'_',bloqueo_ejemplo$id2, sep="")
 
head(llave)

#verificar cuantos pares unicos tenemos
length( unique(llave) )


max(bloqueo_ejemplo$VER)
min(bloqueo_ejemplo$VER)

#filtrar pares con similitud menor o igual a 1
comprueba <- bloqueo_ejemplo[which(bloqueo_ejemplo$VER<=1),]