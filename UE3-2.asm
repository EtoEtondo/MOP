org 0
CLR RS0
CLR RS1			; Registerbank 0 aktivieren
MOV P2, #0FFh		; auf Port P2 wird 1111 1111 geladen
MOV A, #0			; 0 auf den Akku 
MOV SP, #04Fh		; Stackpointer auf Adresse 4Fh
jump2:
CJNE A,P2,jump1		;Sprung auf jump1 wenn Akku und Port2 ungleich sind
SJMP jump2			;Sprung auf jump2
jump1:
MOV R4, #0			; 00h auf R4 laden
MOV R7, #08h		; 08h auf R7 laden
MOV A, P2			; Wert von Port 2 in Akku laden
jump4:
RLC A				; Rotate-Left auf den Akku
JC jump3			; Sprung auf jump3 wenn Carry-Bit 1 ist (wird durch 						; RLC beeinflusst)
INC R4			; inkrementiere R4
jump3:
DJNZ R7, jump4		; 8x wird auf jump4 gesprungen        Befehl 1Fh
PUSH  0x04			; R4 wird auf Stack gepusht
RLC A				; Rotate-Left auf den Akku
SJMP jump2			; sprung auf jump2
end
