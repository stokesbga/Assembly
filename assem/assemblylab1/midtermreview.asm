TITLE  lab5
; Created by ... Alex Stokes
; Date ... 10/20/14

INCLUDE Irvine32.inc
COMMENT !
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, code:DWORD
DumpRegs PROTO
!

.data
   l DWORD ?
   prompt BYTE "Enter the value of l:",0
   myString BYTE 50 DUP(?)

   ;--- PART 2 ---;
   wArr WORD 1h, 2h, 3h, 4h, 5h
   space BYTE " "
   count DWORD 0

.code
MAIN PROC



Invoke ENDPROCESS,0
;-------------------------
;--- END PROGRAM
Main Endp
end MAIN


