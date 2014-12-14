TITLE Lab 5		(z_selig_lab5_1.asm)

INCLUDE Irvine32.inc

COMMENT!
	.386
	.model flat,stdcall
	.stack 4096

	Create a procedure that generates a random string of length L containing all capital
	letters. When calling the procedure, pass the value of L in EAX and pass the pointer to 
	an array of bytes that will hold the random string. Write a test program that will call 
	your procedure 20 times and display the strings in the console window.
	Ask user for the value of L (using ReadInt procedure)
	Bonus (2 pts): modify the procedure so that it alternate capital and lower-case letters.
	Make sure the program works with both even and odd values of L.
	
	ExitProcess PROTO, code:DWORD
	DumpRegs PROTO 
!

.data
intVal SDWORD ?
prompt BYTE "Enter an integer in decimal format, between 0 and 80: ",0
myString BYTE 81 DUP (?)				; Assigning 80 bytes to string

.code
main PROC
	CALL Randomize						; Generate random seed
	mov edx,OFFSET prompt		
	CALL WriteString					; Displays prompt
	CALL ReadInt						; Takes numerical input
	mov ecx,20							; Initializing loop counter to 20
	L1:
		CALL stringGenerator			; Calls stringGenerator 20 times
	LOOP L1
	INVOKE ExitProcess,0
main ENDP

stringGenerator PROC USES eax ecx esi	; USES keyword saves register values on stack
	mov ecx,eax							; Moves desired string length to loop counter
	mov esi,OFFSET myString	
	TARGET:
		mov eax,26d					
		CALL RandomRange				; Calls RandomRange for 0-25
		add eax,41h						; Shifts to ASCII uppercase character set
		mov [esi],eax					; Places random character into [esi], eax times
		inc esi
	LOOP TARGET
	mov ecx,LENGTHOF myString / 2		; Set loop counter to half of string length
	mov esi,OFFSET myString	
	L2:
		mov ebx,[esi]					; Loop increments through every other
		add ebx,20h						; array element and adds 20h to turn
		mov [esi],ebx					; uppercase letters into lowercase
		add esi,TYPE myString * 2
	LOOP L2
	mov edx,OFFSET myString
	CALL WriteString					; Displays string
	CALL CRLF
	ret
stringGenerator ENDP

END main