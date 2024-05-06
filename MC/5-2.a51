ORG 000h
start:
MOV DPTR, #50h 
MOV R0, #00h 
MOV R2, #11111110b 
MOV R4, #0
main:
MOV A, R0 
ACALL output 
MOV A, R2 
MOV R4, #0D6h
wait:
DJNZ R4, #0D6h, wait
RL A 
MOV R2, A 
INC R0 
ACALL delay 
CJNE R0, #08, main 
MOV R0, #00h
ADD A, DPL
MOV DPL, R5
CJNE R5, #80h ,back
back:
MOV DPTR, #50h
delay:
MOV R6, #255
here:
DJNZ R6, here 
RET 
output:
MOVC A, @A+DPTR 
MOV P0, A 
MOV P2, R2 
RET 
ORG 50h
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