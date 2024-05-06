start:
MOV C, P2.0
MOV P1.0, C
MOV C, P2.1
MOV P1.1, C
ORL C, P2.0
CPL C
MOV P1.7, C
JMP start
end
