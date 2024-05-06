org 00h
		start:
			MOV DPTR, #50h		; Dptr auf 50h
			MOV R0, #0			; R0 auf 0
			MOV P0, #0FFh		; 7-Segment Anzeige alles aus
			MOV P2, #0FFh		; Port 2 auf 1 setzen um Segment zu wählen 							
		main:
			MOV A, R0			; Index in Akku für LUT 
			ACALL output		; Subroutine output 
			MOV P0, A			; A wird ausgegeben
			INC R0			; R0 inkrementiert
			CJNE R0, #10, wait		; Sprung auf wait, wenn R0 ungleich 10 ist
			MOV R0, #0			; R0 resetten
		wait:
			MOV R5, #240		; 200 ms Warteschleiffe
	loop1:
MOV R4, #255
loop2:
NOP
DJNZ R3, loop2
DJNZ R1, loop1
		
		output:
			MOVC A, @A+DPTR	; Wert aus Speicher in A geladen	
			RET				; beenden Subroutine
		
org 50h
			DB 3Fh, 06h, 5Bh, 4Fh, 66h, 6Dh, 7Dh, 07h, 7Fh, 6Fh
		end
