TITLE  lab9
; Created by ... Alex Stokes
; Date ... 10/24/14

INCLUDE Irvine32.inc
COMMENT !
.386
.model flat, stdcall
.stack 4096


ExitProcess PROTO, code:DWORD
DumpRegs PROTO
!

.data
arr1 DWORD 123, 123, 123, 432, 6523, 634, 634, 3, 7 ,7 ,7
arr2 DWORD 456, 234, 623, 277, 888 ,888, 888, 8545, 453, 2
arr3 DWORD 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8


.code
MAIN PROC

  triplet PROTO, arrlength:PTR DWORD, address:PTR DWORD, key:PTR DWORD

  ;--------------------------------------------
  INVOKE triplet, LENGTHOF arr1, ADDR arr1, 123
  CALL DumpRegs

  INVOKE triplet, LENGTHOF arr2, ADDR arr2, 888
  CALL DumpRegs

  INVOKE triplet, LENGTHOF arr3, ADDR arr3, 5
  CALL DumpRegs
  ;---------------------------------------------
 
  INVOKE ExitProcess, 0
MAIN ENDP



; TRIPLET PROCEDURE
triplet PROC USES ebx ecx edx, arrlength: PTR DWORD, address: PTR DWORD, key:PTR DWORD
  mov eax, 0
  mov ecx, arrlength
  mov edx, key
  mov esi, address

  L:
    mov ebx, [esi]           ; target 1st element
    cmp ebx, edx
	je foundOne              ; if key
	jmp next                 ; else if not key

	FOUNDONE:
	mov ebx, [esi + 4]       ; target 2nd element
    cmp ebx, edx
	je foundTwo              ; if 2 key
	jmp next                 ; else if not key

	FOUNDTWO:
	mov ebx, [esi + 8]       ; target 3rd element
    cmp ebx, edx
	je success               ; if triplet 
	jmp next                 ; else if not key


	SUCCESS:
	mov eax, 1               ; set eax to true and exit
	RET


	NEXT:                    ; not found
	add esi, 4
  loop L


  RET
triplet ENDP


end MAIN
END

