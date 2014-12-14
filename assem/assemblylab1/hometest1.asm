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
warr WORD 0BEEFh, 0DEEDh, 0FACEh, 1ACEh

.code
MAIN PROC
   mov eax, 0
   mov ax, 3456h
   sub ax, 5678h

   CALL DumpRegs
   INVOKE ExitProcess, 0
MAIN ENDP
end MAIN
END

