org 00h
		start:
			MOV DPTR, #50h		; Dptr auf 50h
			MOV R0, #0			; R0 auf 0
			MOV R1, #1			; R1 auf 1
			MOV P0, #0FFh		; 7-Segment Anzeige alles aus
			MOV P2, #0FFh		; Port 2 auf 0 setzen um Segment zu wählen 							
		main:
			MOV R2, #50
		jump:
			MOV A, R0			; Akkuinhalt bekommt R0 für LUT
			SETB P2.0 			; 7-Seg Nr.0 auswählen
			ACALL output		; Subroutine output
			MOV P0, A			; A wird ausgegeben
			ACALL wait
			MOV A, R1			; A bekommt R1
			CLR P2.0  			; 7-Seg Nr.1 auswählen
			ACALL output
			MOV P0, A			; A ausgegeben
			ACALL wait
			DJNZ R2, jump
			INC R0			; R0 um Eins erhöht
			CJNE R0, #10, main		; Sprung auf main, wenn R0 ungleich 10 ist
			MOV R0, #0			; R0 resetten
			INC R1			; R1 um Eins erhöt
			CJNE R1, #10, main		; Sprung auf main, wenn R1 ungleich 10 ist
			MOV R1, #1			; R1 resetten
			SJMP main
		wait:
			MOV R5, #12			; 10 ms 
	loop1:
MOV R4, #255
loop2:
NOP
DJNZ R4, loop2
DJNZ R5, loop1
			RET

		output:
			MOVC A, @A+DPTR	; Wert aus Speicher in A geladen	
			RET				; beenden Subroutine
		
org 50h
			DB 3Fh, 06h, 5Bh, 4Fh, 66h, 6Dh, 7Dh, 07h, 7Fh, 6Fh
		end
