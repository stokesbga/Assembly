TITLE  lab7
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
myArr DWORD 1h,2h,3h,4h
prompt BYTE "Enter the value for j and k: ", 0



.code
MAIN PROC
  ;--- Get user vals for j and k --
  mov edx, OFFSET prompt
  CALL WriteString
  CALL ReadInt
  mov ebx, eax

  CALL ReadInt
  mov edx, eax

  CALL sumArr             ; Call #1  *****

  mov ebx, 3              ;   j = 3
  mov edx, 4              ;   k = 4
  CALL sumArr             ; Call #2  *****



  ;--- Part 2 ---
  CALL graderRunner

Main endP



; ****** PART 1 *******
; *********************
; --- Array Sum
sumArr PROC USES esi ecx ebx edx
    mov eax, 0
    mov esi, OFFSET myArr   ;    location pointer
	mov ecx, LENGTHOF myArr ;    size
	 

	inRangeTest:
	  cmp ecx, 0
	  je done

	  cmp [esi], ebx
	  jae abovej
	  jmp next

	abovej:
	  cmp [esi], edx
	  jbe inRange
	  ja next

	inRange:
	  add eax, [esi]
	  jmp next

	next:
	  dec ecx
	  add esi, TYPE myArr
	  jmp inRangeTest
	
	done:
	CALL DumpRegs
	RET
sumArr ENDP






; ****** PART 2 *******
; *********************
; --- Calc Grade
calcGrade PROC USES eax
    cmp eax, 60
	jae aboveSixty
	mov al, "F"
	jmp grade

	aboveSixty:
	  cmp eax, 70
	  jae aboveSeventy
	  mov al, "D"
	  jmp grade
	
	aboveSeventy:
	  cmp al, 80
	  jae aboveEighty
	  mov eax, "C"
	  jmp grade

	aboveEighty:
	  cmp al, 90
	  jae aboveNinety
	  mov eax, "B"
	  jmp grade
	
	aboveNinety:
	  mov al, "A"
	  jmp grade

	  grade:

	  CALL WriteChar
	  RET

calcGrade endP



;-- Random number Gen and runner for Part 2
graderRunner PROC
  mov ecx, 10
  
  getGrades:
    mov eax, 50
    CALL RandomRange
    add eax, 50
    CALL WriteInt
    CALL calcGrade
  loop getGrades

  RET
graderRunner ENDp

Invoke ExitProcess, 0
end MAIN


