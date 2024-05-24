
--Ejecutar el codigo de las funciones en la base de datos master

CREATE function limpia_caracteres(@p_str1 VARCHAR(MAX))   
RETURNS VARCHAR(MAX) as    BEGIN   
    
DECLARE @ret_value VARCHAR(MAX);    
DECLARE @VALORES VARCHAR(39);     
DECLARE @LONG INT;    
DECLARE @CONT INT;    
DECLARE @invalidChar nchar(1);    
DECLARE @INDEXPOS INT;   
        
SET @VALORES='ABCDEFGHIJKLMN—OPQRSTUVWXYZ _¡…Õ”⁄√ü'      
SET @ret_value = upper(@p_str1)   
SET @LONG = LEN(@p_str1)     
SET @CONT = 1   
SET @INDEXPOS = 0        

WHILE @CONT <= @LONG     
BEGIN         
	SET @invalidChar = SUBSTRING(@ret_value, @CONT, 1);      
	SET @INDEXPOS = CHARINDEX(@invalidChar, @VALORES)      
	
	IF @INDEXPOS <= 0      
		SET @ret_value = REPLACE(@ret_value, @invalidChar,'_');          
	
	IF @INDEXPOS >= 30      
	BEGIN        
		IF @INDEXPOS = 30       
			SET @ret_value = REPLACE(@ret_value, @invalidChar,'A');     
		
		IF @INDEXPOS = 31     
			SET @ret_value = REPLACE(@ret_value, @invalidChar,'E');       
					
		IF @INDEXPOS = 32       
			SET @ret_value = REPLACE(@ret_value, @invalidChar,'I');        
						
		IF @INDEXPOS = 33       
			SET @ret_value = REPLACE(@ret_value, @invalidChar,'O');     
							
		IF @INDEXPOS = 34      
			SET @ret_value = REPLACE(@ret_value, @invalidChar,'U');       
								
		IF @INDEXPOS = 35      
			SET @ret_value = REPLACE(@ret_value, @invalidChar,'A');       
									
		IF @INDEXPOS = 36       
			SET @ret_value = REPLACE(@ret_value, @invalidChar,'Y');       
	END        
										
	SET @CONT = @CONT + 1;      
END     

IF CHARINDEX('_', @ret_value) > 0    
	SET @ret_value = REPLACE(@ret_value, '_','');   
	
RETURN @ret_value       

END


CREATE function CLEAR_ABREV (@ab_str1 VARCHAR(MAX))     
RETURNS VARCHAR(MAX) as    BEGIN     
DECLARE @res_value VARCHAR(MAX)    
SET @res_value = LTRIM(RTRIM(UPPER(@ab_str1)))      
-------------------------------------------------------------    
-------------------------------------------------------------     
IF @res_value like '% DE %'     
BEGIN     
SET @res_value= REPLACE(@res_value, ' DE ', ' ' )     
END         

IF @res_value like 'DE %'      
BEGIN        
SET @res_value= REPLACE(@res_value, 'DE ', '' )     
END          

IF @res_value like '% DE'      
BEGIN        
SET @res_value= REPLACE(@res_value, ' DE', '' )     
END     
-------------------------------------------------------------    
-------------------------------------------------------------     
IF @res_value like '% DEL %'      
BEGIN        
SET @res_value= REPLACE(@res_value, ' DEL ', ' ' )     
END        

IF @res_value like 'DEL %'      
BEGIN       
SET @res_value= REPLACE(@res_value, 'DEL ', '' )     
END          

IF @res_value like '% DEL'      
BEGIN      
SET @res_value= REPLACE(@res_value, ' DEL', '' )     
END     
-------------------------------------------------------------   
-------------------------------------------------------------    
IF @res_value like '% LA %'    
BEGIN      
 SET @res_value= REPLACE(@res_value, ' LA ', ' ' )     
END          

IF @res_value like 'LA %'      
BEGIN      
SET @res_value= REPLACE(@res_value, 'LA ', '' )      
END         
IF @res_value like '% LA'     
BEGIN        
SET @res_value= REPLACE(@res_value, ' LA', '' )     
END     
-------------------------------------------------------------    
-------------------------------------------------------------     
IF @res_value like '% LOS %'       
BEGIN       
SET @res_value= REPLACE(@res_value, ' LOS ', ' ' )       
END         
IF @res_value like 'LOS %'       
BEGIN         
SET @res_value= REPLACE(@res_value, 'LOS ', '' )       
END          
IF @res_value like '% LOS'      
BEGIN        
SET @res_value= REPLACE(@res_value, ' LOS', '' )      
END      
-------------------------------------------------------------    
-------------------------------------------------------------     
IF @res_value like '% MA %'     
BEGIN        
SET @res_value= REPLACE(@res_value, ' MA ', ' MARIA ' )      
END          
IF @res_value like 'MA %'      
BEGIN         
SET @res_value= REPLACE(@res_value, 'MA ', 'MARIA ' )     
END         
IF @res_value like '% MA'       
BEGIN       
SET @res_value= REPLACE(@res_value, ' MA', ' MARIA ' )      
END         
IF @res_value = 'MA'     
BEGIN        
SET @res_value= 'MARIA'       
END     
-------------------------------------------------------------    
-------------------------------------------------------------     
IF @res_value like '% FCO %'       
BEGIN     
SET @res_value= REPLACE(@res_value, ' FCO ', ' FRANCISCO ' )     
END          
IF @res_value like 'FCO %'      
BEGIN       
SET @res_value= REPLACE(@res_value, 'FCO ', 'FRANCISCO ' )      
END        
IF @res_value like '% FCO'     
BEGIN        
SET @res_value= REPLACE(@res_value, ' FCO', ' FRANCISCO ' )      
END          
IF @res_value = 'FCO'    
BEGIN        
SET @res_value= 'FRANCISCO'       
END     
-------------------------------------------------------------    
-------------------------------------------------------------      
IF @res_value like '% GPE %'     
BEGIN       
SET @res_value= REPLACE(@res_value, ' GPE ', ' GUADALUPE ' )      
END         
IF @res_value like 'GPE %'     
BEGIN        
SET @res_value= REPLACE(@res_value, 'GPE ', 'GUADALUPE ' )     
END          
IF @res_value like '% GPE'      
BEGIN       
SET @res_value= REPLACE(@res_value, ' GPE', ' GUADALUPE ' )      
END         
IF @res_value = 'GPE'      
BEGIN        
SET @res_value= 'GUADALUPE'       
END      
-------------------------------------------------------------    
-------------------------------------------------------------    
IF @res_value like '% LUPE %'     
BEGIN        
SET @res_value= REPLACE(@res_value, ' LUPE ', ' GUADALUPE ' )     
END         
IF @res_value like 'LUPE %'      
BEGIN        
SET @res_value= REPLACE(@res_value, 'LUPE ', 'GUADALUPE ' )     
END          
IF @res_value like '% LUPE'       
BEGIN        
SET @res_value= REPLACE(@res_value, ' LUPE', ' GUADALUPE ' )      
END          
IF @res_value = 'LUPE'      
BEGIN        
SET @res_value= 'GUADALUPE'        
END      
-------------------------------------------------------------   
-------------------------------------------------------------    
IF @res_value like '% FDA %'      
BEGIN         
SET @res_value= REPLACE(@res_value, ' FDA ', ' FERNANDA ' )     
END          
IF @res_value like 'FDA %'      
BEGIN        
SET @res_value= REPLACE(@res_value, 'FDA ', 'FERNANDA ' )      
END        
IF @res_value like '% FDA'      
BEGIN       
SET @res_value= REPLACE(@res_value, ' FDA', ' FERNANDA ' )      
END          
IF @res_value = 'FDA'     
BEGIN      
SET @res_value= 'FERNANDA'       
END     
-------------------------------------------------------------    
-------------------------------------------------------------     
IF @res_value like '% FDO %'      
BEGIN       
SET @res_value= REPLACE(@res_value, ' FDO ', ' FERNANDO ' )    
END        
IF @res_value like 'FDO %'      
BEGIN       
SET @res_value= REPLACE(@res_value, 'FDO ', 'FERNANDO ' )      
END        
IF @res_value like '% FDO'      
BEGIN       
SET @res_value= REPLACE(@res_value, ' FDO', ' FERNANDO ' )      
END         
IF @res_value = 'FDO'      
BEGIN        
SET @res_value= 'FERNANDO'        
END      
-------------------------------------------------------------    
-------------------------------------------------------------      
IF @res_value like '% HDZ %'      
BEGIN      
SET @res_value= REPLACE(@res_value, ' HDZ ', ' HERNANDEZ ' )     
END        
IF @res_value like 'HDZ %'     
BEGIN        
SET @res_value= REPLACE(@res_value, 'HDZ ', 'HERNANDEZ ' )     
END         
IF @res_value like '% HDZ'      
BEGIN       
SET @res_value= REPLACE(@res_value, ' HDZ', ' HERNANDEZ ' )     
END        
IF @res_value = 'HDZ'     
BEGIN       
SET @res_value= 'HERNANDEZ'       
END     
-------------------------------------------------------------   
-------------------------------------------------------------     
IF @res_value like '% HDEZ %'      
BEGIN    
SET @res_value= REPLACE(@res_value, ' HDEZ ', ' HERNANDEZ ' )     
END          
IF @res_value like 'HDEZ %'      
BEGIN       
SET @res_value= REPLACE(@res_value, 'HDEZ ', 'HERNANDEZ ' )     
END          
IF @res_value like '% HDEZ'     
BEGIN       
SET @res_value= REPLACE(@res_value, ' HDEZ', ' HERNANDEZ ' )   
END          
IF @res_value = 'HDEZ'      
BEGIN        
SET @res_value= 'HERNANDEZ'       
END      
-------------------------------------------------------------    
-------------------------------------------------------------      
IF @res_value like '% MTZ %'      
BEGIN       
SET @res_value= REPLACE(@res_value, ' MTZ ', ' MARTINEZ ' )       
END       
IF @res_value like 'MTZ %'      
BEGIN       
SET @res_value= REPLACE(@res_value, 'MTZ ', 'MARTINEZ ' )     
END         
IF @res_value like '% MTZ'    
BEGIN      
SET @res_value= REPLACE(@res_value, ' MTZ', ' MARTINEZ ' )      
END         
IF @res_value = 'MTZ'     
BEGIN        
SET @res_value= 'MARTINEZ'       
END      
  
RETURN @res_value  
END    





CREATE function DELETE_DOBLES (@del_str1 VARCHAR(MAX))   RETURNS VARCHAR(MAX) as     
BEGIN    

DECLARE @res_value VARCHAR(MAX)    
DECLARE @str_base VARCHAR(MAX)    
DECLARE @char_comp CHAR(1)   
DECLARE @i INT     
DECLARE @j INT    
DECLARE @foundIT INT      


--Recibir la cadena de texto y guaradarla en dos variables
SET @res_value = LTRIM(RTRIM(UPPER(@del_str1)))   
SET @str_base = LTRIM(RTRIM(UPPER(@del_str1)))    



SET @i = 1     

WHILE @i < ( len(@res_value) + 1)     
BEGIN      
	SET @char_comp = SUBSTRING(@res_value, @i, 1)       
	SET @j=@i+1       
	
	WHILE @j <  (len(@res_value) + 1) or @foundIT = 0      
	BEGIN         
		IF SUBSTRING(@res_value, @j, 1) = @char_comp        
		BEGIN      
			SET @res_value = STUFF(@res_value, @j, 1, '')             
		END       
		ELSE      
		BEGIN           
			SET @foundIT = 1       
			break         
		END                      
	END              

	SET @i = @i + 1  
END        

RETURN @res_value      

END    



CREATE function estandarizar_nombres(@str_est   VARCHAR(MAX))   
RETURNS VARCHAR(MAX) as   BEGIN     
 
SET @str_est = (select master.dbo.limpia_caracteres(@str_est))     
SET @str_est = (select MASTER.DBO.CLEAR_ABREV(@str_est))    
SET @str_est = (select replace(@str_est,'V','B'))    
SET @str_est = (select replace(@str_est,'Z','S'))   
SET @str_est = (select replace(@str_est,'N','M'))    
SET @str_est = (select replace(@str_est,'—','M'))   
SET @str_est = (select replace(@str_est,'K','C'))   
SET @str_est = (select replace(@str_est,'Y','I'))     
SET @str_est = (select MASTER.DBO.DELETE_DOBLES(@str_est))      
 
return @str_est      

END



 

 CREATE FUNCTION [dbo].[fnSplitString]   (       @string NVARCHAR(MAX),       @delimiter CHAR(1)   )    
 RETURNS @output TABLE(splitdata NVARCHAR(MAX)   )    
 BEGIN       
 
 DECLARE @start INT, @end INT       
 SELECT @start = 1, @end = CHARINDEX(@delimiter, @string)       
 
 WHILE @start < LEN(@string) + 1  
 BEGIN          
	IF @end = 0            
		SET @end = LEN(@string) + 1                 
		
		INSERT INTO @output (splitdata)          
		VALUES(ltrim(rtrim(SUBSTRING(@string, @start, @end - @start))))        
		
		SET @start = @end + 1          
		SET @end = CHARINDEX(@delimiter, @string, @start)             
 END       
 
 RETURN     
END







CREATE FUNCTION dbo.ngrams_numeric      (@string nvarchar(max))       
RETURNS @ids TABLE (token char(3), pos_q int)  AS  
BEGIN     
	
	SET @string = ltrim(rtrim(@string));      
	DECLARE @pos int = 1;     
	DECLARE @len int;    
	declare @partition nvarchar(100);    
	DECLARE @pos_n int;      
	DECLARE rename_split 
	
	CURSOR FOR    select concat('<<',splitdata,'>>') from master.dbo.fnSplitString(@string,' ')     OPEN rename_split      
	FETCH NEXT FROM rename_split     INTO @partition     
	
	WHILE @@FETCH_STATUS = 0       
	BEGIN         
		set @pos_n =1;     
		set @pos =1;     
		SET @len  = LEN(@partition) - 2;      
			IF @len <= 0         
				RETURN;         
				WHILE @pos <= @len      
				BEGIN         
					INSERT INTO @ids (token, pos_q)         
					SELECT SUBSTRING(@partition, @pos, 3), @pos_n;            
					
					SET @pos = @pos + 1;     
					SET @pos_n = @pos_n + 1;       
				END       
				
				FETCH NEXT FROM rename_split    INTO @partition          
	END;       

CLOSE rename_split;   
DEALLOCATE rename_split;           
RETURN;   

END;      


















