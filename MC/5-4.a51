ORG 00h
		SJMP main

ORG 0Bh
		SJMP ISR

;--------Main--------;	
ORG 30h
		main:	
		MOV P0, #0FFh			; P0 alle LEDs aus
		MOV P2, #0FFh			; 7-Segment 0 auswählen
		SETB P3.3				; Auf 1 setzen damit Counter zählt
		MOV DPTR, #90h			; LUT Start in DPTR
		MOV TMOD, #11010001b		; Timer-Modus 1 und Gate aktiv
SETB ET0				; Interrupt Aktivierung
		SETB EA				; enable all
MOV TL0, #00h			; überbrückende Zeit
		MOV TCON, #01010000b		; Timer T0 und Counter T1 aktivieren
	cmp:	
MOV TH0, #0F7h			; überbrückende Zeit für 20 Hz
MOV R0, #0FFh			; Prüfreg ISR ausgeführt oder nicht
loop:	
		CJNE R0, #0FFh, cmp		; Prüfen auf Interrupt
		ACALL output			; Ausgabe Subroutine
SJMP loop				; Endlosschleife

;------Interrupt----;
	ORG 60h
	ISR:	
INC R1				; High- und Low-Pegel Läufer
		CJNE R1, #2, weiter			; Periodenabfrage ob vorbei
MOV A, TH1				; Counter auslesen
MOV TL1, #0			; Reset der Counter Werte
		MOV TH1, #0			
MOV B, #2				; da ich TL1 weg geworfen hab ist es so
DIV AB				; wie /256, jetzt nur noch /2 und das ist
					; ca. 500 (512) wegen 1µs MZ Dauer
					; außerdem wird aufgrund von P3.3 nur
					; nur der High-Pegel gezählt
MOV R2, A				; Millisekunden Dauer der Pulsweite
MOV R3, B				; Nachkommastelle der Pulsweite
MOV R1, #0				; reset
weiter:
		CPL P1.0				; Ausgabe an der LED
		MOV C, P1.0				; P3.3 Rechtecksignal übergeben
		MOV P3.3, C				
MOV R0, #0
RETI

;----Ausgabe--;	
output:
MOV A, R3				; Nachkommastelle an A
MOVC A, @A+DPTR		; Wert aus LUT holen
	SETB P2.0				; 7-Segment 0 auswälen
	SETB P2.1
MOV P0, A				; Ausgeben
MOV A, R2				; Um 2. Stelle noch auszugeben
MOV B, #10				; Damit 2. Stelle in B landet
DIV AB				
MOV R4, A				; 3. Wert speichern
MOV A, B				; 2. Stell an A geben
MOVC A, @A+DPTR		; Wert aus LUT holen
ORL A, #10000000b			; Kommastelle
CLR P2.0				; 7-Segment 1 auswählen
SETB P2.1
MOV P0, A				; Ausgeben des 2. Werts

MOV A, R4				; Um 3. Stelle auch noch auszugeben
MOV B, #10				; Damit 3. Stelle in B landet
DIV AB
MOV A, B				; 3. Stelle an A geben
MOVC A, @A+DPTR		; Wert aus LUT holen
SETB P2.0				; 7-Segment 2 auswählen
CLR P2.1
MOV P0, A				; Ausgeben
RET					; Subroutine beenden

;-----LUT-----;
ORG 90h
DB 3Fh, 06h, 5Bh, 4Fh, 66h, 6Dh, 7Dh, 07h, 7Fh, 6Fh
