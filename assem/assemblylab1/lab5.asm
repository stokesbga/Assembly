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
arr BYTE 01h, 02h, 03h, 04h
arr2 BYTE 04h, 03h, 02h, 01h
counterUp WORD 0
counterDown BYTE ?

.code
MAIN PROC
; ---- PART 1 ------
   mov eax, 0  
   mov esi, OFFSET arr                     ; starting at 0 / counting up
   mov ebx, [OFFSET arr + SIZEOF arr - 1]  ; last index/ counting down
   mov ecx, [LENGTHOF arr/2]               ; counter 

   loops:
     mov al, [esi]
	 mov ah, [ebx]
	 
	 xchg al,ah                           ; move corresponding values to al, ah and swap

	 mov [esi], al
	 mov [ebx], ah

     add esi, TYPE arr                   ; move towards center
	 sub ebx, TYPE arr

	 LOOP loops
   mov eax, DWORD PTR arr
   CALL DumpRegs



 ;----- PART 2 ------
   mov eax, 0
   mov esi, [OFFSET arr2 ]              ; LOW
   mov ebx, [OFFSET arr2 + TYPE arr2]   ; HIGH
   mov ecx, [LENGTHOF arr2 - TYPE arr2] ; 3 for DWORD

   loops2:
     mov al, [esi]
	 mov ah, [ebx]

	 xchg al, ah                        ; bubble elements UP

	 mov [esi], al
	 mov [ebx], ah

     add esi, TYPE arr2
	 add ebx, TYPE arr2
   LOOP loops2


   mov eax, DWORD PTR arr2
   CALL DumpRegs

   INVOKE ExitProcess, 0
MAIN ENDP
end MAIN
END

