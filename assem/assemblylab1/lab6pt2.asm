TITLE  lab5
; Created by ... Alex Stokes
; Date ... 10/7/14

INCLUDE Irvine32.inc
COMMENT !
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, code:DWORD
DumpRegs PROTO
!

.data
   ;--- PART 2 ---;
   wArr WORD 1h, 2h, 3h, 4h, 5h
   space BYTE " "
   count DWORD 0

.code
main PROC
mov ecx, 4
mov esi, OFFSET wArr
CALL DumpMemS
INVOKE ExitProcess,0
main ENDP


DumpMemS PROC
  itr:
    CALL WriteIntS
  LOOP itr
DumpMemS endP


WriteIntS PROC 
  mov eax, 0
  movzx eax, WORD PTR [esi]
  add esi, 2
  CALL WriteInt

  mov edx, OFFSET space
  CALL WriteString

RET
WriteIntS endP

END main

