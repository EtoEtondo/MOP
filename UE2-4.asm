MOV P1, #0FFh
SETB P2.3
loop:
JB P2.3, loop
lock:
JNB P2.3, lock
CPL P1.3
SJMP loop
end
