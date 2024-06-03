#Instalar la siguiente función 
#función generar bloques de indices
function_block <- function( nbase, bloques ){
  
  block <- bloques
  tot2 <- nbase
  
  
  block2  <- data.frame(
    id=numeric(),
    ini=numeric(),
    fin=numeric()
  ) 
  
  
  
  if (tot2>block){
    
    tot_block <- block
    inicio <- 1
    idtot <- 1
    
    while (block<tot2){
      
      
      block2 <- block2 %>% 
        add_row(id = idtot, ini= inicio , fin = block)
      
      block <- block + tot_block
      inicio <- inicio +  tot_block
      idtot <- idtot + 1
      
      
    }
    
    if (block>tot2){
      
      block2 <- block2 %>% 
        add_row(id = idtot, ini= inicio , fin = tot2)
      
    }
    
  }
  
  if (nrow(block2)==0){
    
    block2 <- block2 %>% 
      add_row(id = 1, ini= 1 , fin = tot2 )
    
  }
  
  return(block2)
  
} 
