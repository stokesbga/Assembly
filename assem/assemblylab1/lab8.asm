TITLE  lab8
; Created by ... Alex Stokes
; Date ... 10/30/14

INCLUDE Irvine32.inc
COMMENT !
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, code:DWORD
DumpRegs PROTO
!

.data
key BYTE 6, 4, 1, 0, 8, 5, 2, 4, 4, 6
myString BYTE "Encrypt Me!",0
encrString BYTE ?
cur BYTE ?
cur2 BYTE ?

.code
MAIN PROC
 
  mov eax, 0
  mov esi, OFFSET myString
  mov edi, OFFSET key
  mov ecx, LENGTHOF myString
  mov ebx, 0

  mov edx, esi
  CALL WRITESTRING
  CALL enDCrypt

  mov ebx, 1
  CALL enDCrypt

Main endP



enDCrypt PROC USES ecx esi edi eax edx ebx
  push esi
  cmp ebx, 0
  jne toRight
  
  ;LEFT ROTATION
  ebxIsZLeft:
  en:
     push ecx
	 mov cl, [edi]
	 mov al, [esi]
     rol al, cl
	 mov [esi], al

	 inc esi
	 inc edi
	 pop ecx 
  LOOP en
  jmp done

  ;RIGHT ROTATION
  toRight:
    ri:
     push ecx
	 mov cl, [edi]
	 mov al, [esi]
     ror al, cl
	 mov [esi], al

	 inc esi
	 inc edi
	 pop ecx
  LOOP ri

  done:
  add esi, 1
  mov ah, 0
  mov [esi], ah

  pop esi
  mov edx, esi
  CALL WRITESTRING
  CALL CRLF
RET
endCrypt ENDp

Invoke ExitProcess, 0
end MAIN


