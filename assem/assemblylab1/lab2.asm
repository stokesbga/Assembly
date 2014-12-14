TITLE  Adding two numbers (AddTwo.asm)
; Created by ...
; Date ...

INCLUDE Irvine32.inc
COMMENT !
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, code:DWORD
DumpRegs PROTO
!
.data
sum WORD 0

.code
mymain PROC
   ;---- Part 1 ----
   mov eax, 5
   mov ebx, 3
   mov ecx, 6
   mov edx, 1
   add eax, ebx
   add edx, ecx
   sub eax, edx
   ;---^ Part 1 ----

   ;--- Part 2 ---
   mov ax, 9
   mov bx, 4
   add sum, ax
   add sum, bx
    
   mov ax, 2
   mov bx, 3
   
   sub sum, ax
   sub sum, bx
   
   mov ax, sum 
   ;--- Part 2 ---

   CALL DumpRegs
   INVOKE ExitProcess, 0
mymain ENDP
END mymain