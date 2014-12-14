TITLE  lab4
; Created by ... Alex Stokes
; Date ... 10/4/14

INCLUDE Irvine32.inc
COMMENT !
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, code:DWORD
DumpRegs PROTO
!

.data
arr BYTE 1h,2h,3h,4h,5h,6h,7h,8h


.code
MAIN PROC
; ---- PART 1 ------
   mov esi, 0
   mov eax, 0
   mov cx, [LENGTHOF arr]
  
   loop_start:
      mov al, arr[esi]
	  xchg al, arr[esi + TYPE arr]
	  mov arr[esi], al
	  
	  add esi, TYPE arr
	  CALL DumpRegs
	  add esi, TYPE arr
	  dec ecx
	  
      LOOP loop_start


 ;----- PART 2 ------
   mov eax, 0  ;total
   mov ebx, 1  ;n-1
   mov edx, 0  ;n-2
   mov ecx, 7

   fib:
      mov edx, ebx
	  mov ebx, eax
      mov eax, ebx
	  add eax, edx
	  
	  CALL WriteInt
   LOOP fib


   INVOKE ExitProcess, 0
MAIN ENDP
end MAIN
END

