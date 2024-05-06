;
$DATE (18.06.2018)
$TITLE ( )
$PAGELENGTH(56)
$PAGEWIDTH(150)
$DEBUG
$XREF
$NOLIST
$MOD51
$LIST
;
org 0
;-----------MAIN----------------

MOV P0, #0FFh	;--- LEDs ausgeschaltet
SETB P3.2 		;--- Taster wird auf 1 gesetzt
start:
SETB P0.2 		;--- LED 3 auf 0 gesetzt
CLR P0.0 		;--- LED 1 auf 1 gesetzt
loop:
JB P3.2, loop 		;--- bleibt in loop solange Taster 0 ist
lock:
JNB P3.2, lock 	;--- bleibt in lock solange Taster 1 ist
MOV A, #8 		;--- A=8 ca. 2s delay
ACALL delay 	;--- Subroutine f¸r delay
SETB P0.0 		;--- LED 1 auf 0
CLR P0.4 		;--- LED 3 auf 1
MOV A, #12 		;--- A=12 entspricht ca. 3s delay
ACALL delay 	;--- Subroutine für den delay
SETB P0.4 		;--- LED 1 auf 0
CLR P0.2 		;--- LED 3 auf 1
MOV A, #4 		;--- A=4 entspricht ca. 1s delay
ACALL delay 	;--- Subroutine f¸r delay
SJMP start 		;--- jump zu loop

;-----SUBROUTINE--------------------
delay:
MOV R1, A        	;---Programm der 3. Aufgabe
loop1:
MOV R2, #250
loop2:
MOV R3, #250
loop3:
NOP
NOP
DJNZ R3, loop3
DJNZ R2, loop2
DJNZ R1, loop1
RET

end

