
ORG 000h;				
SJMP start          

ORG 03h							
SJMP  ISR				
						
ORG 30h						  
start:		          
MOV DPTR,#0A0h      ; LUT initialisiert
MOV R0,#00h	        ; Spaltenzähler	
MOV R2,#11111110b   ; Spaltenauswahl
SETB   P3.2       ; P3.2 ALS INPUT KONFIGURIEREN
SETB   IT0        ; FALLENDE FLANKE AUSLÖSUNGSART
SETB   EX0        ; EXTERNE INTERUPT 0 auslösen
SETB   EA         ; Interruptfreigabe

main:		          								 
MOV A,R0	        
ACALL output	    ; Subroutine
MOV A,R2          ; nächste Spalte
RL A		          
MOV R2,A	       
INC R0		        ; Zähler erhöhen
ACALL delay	      
CJNE R0,#8,main	  ; jede Spalte
MOV R0,#00h	      ; R0 resetten
INC R5				    ; WÜRFELNUMMER-LAUFZÄHLER							 
CJNE R5,#06h,main 
MOV R5,#00h	 			
SJMP main	        

delay:		        
MOV R6,#255	      ; ZEITVERZÖRGERUNG 276,16µs						      		
here:             							 
DJNZ R6,here      								 
RET		            
	
output:		        		
MOVC A,@A+DPTR	  ; Wert aus LUT holen
MOV P0,A	        ; SPALTEN-AUSGABE
MOV P2,R2	        ; Spaltenauswahl
RET		            

ISR:							
PUSH ACC					;	Akku und PSW sichern				       
PUSH PSW													
MOV DPTR,#0A0h                                                                                         
MOV  A,R5				  ; Momentaner Wert von R5
MOV B,#08h			  ; Da im Abstand von 8
MUL AB						
ADD A,DPL					; OFFSET+MULTI=AUSWERTUNG
MOV DPL,A					; Update DPTR
POP PSW						; Akku und PSW sichern
POP ACC														
RETI						

ORG 0A0h
DB 00000000b, 00000000b, 00000000b, 00011000b
DB 00011000b, 00000000b, 00000000b, 00000000b ;1
DB 00000011b, 00000011b, 00000000b, 00000000b 
DB 00000000b, 00000000b, 11000000b, 11000000b ;2
DB 00000011b, 00000011b, 00000000b, 00011000b
DB 00011000b, 00000000b, 11000000b, 11000000b ;3
DB 11000011b, 11000011b, 00000000b, 00000000b
DB 00000000b, 00000000b, 11000011b, 11000011b ;4
DB 11000011b, 11000011b, 00000000b, 00011000b
DB 00011000b, 00000000b, 11000011b, 11000011b ;5
DB 11011011b, 11011011b, 00000000b, 00000000b
DB 00000000b, 00000000b, 11011011b, 11011011b ;6
END
