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
   mov edx, OFFSET prompt     ; ask for l
   CALL WriteString
   CALL ReadInt

   mov ecx, 20                ; 20 loops
   mov edx, OFFSET myString
	
	twenty:
	   CALL randMaker
	LOOP twenty

	
	;-------------------------
	;---PART 2 ---
	mov ecx, 4
    mov esi, OFFSET wArr
    CALL DumpMemS
   
   INVOKE ExitProcess, 0
MAIN ENDP


;-------------------------
;*** RandMaker procedure ***  
randMaker PROC USES eax edx ecx
   mov ecx, eax                  ; set repetitions to l
   lrep:
      mov eax, 26                ; add 65 to 0-25 to get capital letters
	  CALL RandomRange
	  add eax, 'A'
	  mov [edx], eax
	  inc edx
	LOOP lrep

	mov edx, OFFSET myString
	CALL WriteString
	Call CRLF
	RET
randMaker ENDP




;-------------------------
;---Part 2 Procedures---
DumpMemS PROC
  itr:
    CALL WriteIntS
  LOOP itr
DumpMemS endP


WriteIntS PROC 
  mov eax, 0
  movzx eax, WORD PTR [esi]       ; just get word in array
  add esi, TYPE wArr              ; increase 2 bytes
  CALL WriteInt

  mov edx, OFFSET space
  CALL WriteString

RET
WriteIntS endP



;-------------------------
;--- END PROGRAM
end MAIN


