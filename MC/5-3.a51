ORG 000h
SJMP start

;-----Start------;
ORG 20h
start:
MOV DPTR, #90h			; LUT Start in DPTR reingeladen 
MOV R0, #00h 			; OFFSET
MOV R2, #11111110b		; R2 für Spalten
SETB   P3.2         ; als Interrupt konfigurieren
SETB EX0				; Interrupt 0 frei
SETB IT0				; Pegelgesteuert
SETB EA				; enable all

;----Main-----;
main:		          ; DARSTELLEN WÜRFELNUMMERN									 
MOV A,R0	        
ACALL output	    ; MOMENTANER STAND AUSGEBEN AN DER LED MATRIX
MOV A,R2          ; Spalte rotieren
RL A		          
MOV R2,A	        
INC R0		        ; SPALTENZÄHLER
ACALL delay	      
CJNE R0,#8,main	  ; JEDE SPALTE ansteuern
MOV R0,#00h	      ; reset R0
INC R5				    ; WÜRFELNUMMER-LAUFZÄHLER							 
CJNE R5,#06h,main ; von 0 bis 6
MOV R5,#00h	 			; R5 reset
SJMP main	        ; Endlosschleife

;---DELAY---;
delay:
MOV R7, #255       ; ca 200 Mikrosekunden
here:
DJNZ R7, here      
RET

output:		        								
MOVC A,@A+DPTR	  ; Wert aus LUT holen
MOV P0,A	        ; Spalten Ausgabe
MOV P2,R2	        ; Spalte wälen
RET	


;----Interrupt----;
isr:
PUSH ACC					;	Akku sichern				       
PUSH PSW					;	PSW sichern								
MOV DPTR,#70h    ;	                                                                                      
MOV  A,R5				  ; Zufallswert reinladen
MOV B,#08h			  ; da Abstand 8
MUL AB						 
ADD A,DPL					; OFFSET+MULTI= Wert für LUT
MOV DPL,A					; Wert für DPTR
POP PSW						
POP ACC														
RETI


;-----IVT-----;
ORG 03h
SJMP isr

ORG 90h
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
