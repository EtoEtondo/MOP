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
MOV P0, #0FFh 	;--- LEDs ausschalten
SETB P3.2		;--- Taster S19 wird auf 1 gesetzt
SETB P0.0		;--- LED 1 auf  1 setzen
CLR P0.2 		;--- LED 3  auf 0 setzen
loop:
JB P3.2, loop 		;--- in loop solange Taster 0 ist
lock:
JNB P3.2, lock 	;--- in lock solange Taster 1 ist
CPL P0.0 		;--- LED 1 wird invertieren
CPL P0.2 		;--- LED 3 wird invertieren
SJMP loop 		;--- jump zu loop
end
