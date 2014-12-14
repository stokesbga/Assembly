TITLE  lab8
; Created by ... Alex Stokes
; Date ... 11/7/14

INCLUDE Irvine32.inc
COMMENT !
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, code:DWORD
DumpRegs PROTO
!


.code
MAIN PROC
 CALL readHex
 CALL showDecimal8
 CALL mulTable
MAIN endP



showDecimal8 PROC uses eax edx ebx
  mov edx, 0
  mov bx, 0Ah
  

  div bx
  add al, 48
  Call WriteChar

  ;// ones place //
  mov al, dl	
  add al, 48
  Call WriteChar
  CALL CRLF

  RET
showDecimal8 ENDP




;*** PART 2 ***
mulTable PROC uses ecx eax edx ebx
  mov eax, 1
  mov ebx, 1
  mov edx, 1
  mov ecx, 15
  go:
	push ecx
	mov ecx, 15
	mov edx, 1

	inner:
	  push eax
	  push edx

	  mul dx
	  pop edx
	  inc dx

	  CALL WriteHexB
	  mov eax, ' '
	  CALL WriteChar
	  pop eax

	  
	loop inner

	inc ax
	pop ecx
	call CRLF

  loop go
  RET
mulTable ENDP


Invoke ExitProcess, 0
end MAIN


