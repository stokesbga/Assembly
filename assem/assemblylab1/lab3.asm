TITLE  Adding two numbers (AddTwo.asm)
; Created by ... Alex Stokes
; Date ... 9/23/14

INCLUDE Irvine32.inc
COMMENT !
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, code:DWORD
DumpRegs PROTO
!

.data
	three DWORD 12345678h

	bigEndian BYTE 12h, 34h, 56h, 78h
	littleEndian DWORD ?
	place WORD ?

	myBytes BYTE 10h, 20h, 30h, 40h
	myWords WORD 3 DUP(?), 2000h
	myString BYTE "ABCDE"


.code
MAIN PROC
; ---- PART 1 ------
   mov eax, 0
   mov eax, [three-2]
   mov ax, WORD PTR [three+2]

   CALL DumpRegs



 ;----- PART 2 ------
   mov eax, 0
   mov ax, WORD PTR bigEndian
   xchg ah, al
   mov place, ax

   mov bx, WORD PTR [bigEndian+2]
   xchg bh, bl

   mov eax, DWORD PTR [place-2] 
   mov ax, bx

   CALL DumpRegs



 ;----- PART 3 ------
   mov eax, 0
   mov edx, 0
   ;-- a
   mov dx, WORD PTR myBytes

   ;-- b
   mov al, BYTE PTR myWords[1]

   ;-- c
   mov myString, "H"
   mov myString+1, "E"
   mov myString+2, "L"
   mov myString+3, "L"
   mov myString+4, "O"

   CALL DumpRegs



   INVOKE ExitProcess, 0
MAIN ENDP
end MAIN
END

