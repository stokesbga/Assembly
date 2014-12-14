TITLE  lab10
; Created by ... Alex Stokes
; Date ... 12/3/14

INCLUDE Irvine32.inc
COMMENT !
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, code:DWORD
DumpRegs PROTO
!


.data
input DWORD ?
promptForN1 BYTE "Please enter the value of N Sieve for Eratosthenes:", 0ah, 0ah, 0
promptForN2 BYTE "Please enter the value of N for Integer Division:", 0ah, 0ah, 0
promptForN3 BYTE "Please enter the value of N for Reciprocal Sum:", 0ah, 0ah, 0

											; -------- PROTOTYPES
sumReciprocals PROTO, N:DWORD
Primes PROTO, N:DWORD
isPrime PROTO, N:DWORD
Sieve PROTO, N:DWORD
FindNums PROTO, N:DWORD, DIVME: DWORD

											; -------- VARIABLES
listOfPrimes DWORD 2000 DUP(0)								
oneVal REAL8 1.0
loadMe REAL8 0.0

eratAr DWORD 2000 DUP(0)
erathInc DWORD 2




.code
MAIN PROC
	; --------------------------------------------- SIEVE
	mov edx, OFFSET promptForN1								; get value of N
	CALL WriteString										; for Sieve
	CALL ReadInt
	mov input, eax
	Invoke Sieve, input		
	CALL CRLF						
	CALL CRLF					

	; --------------------------------------------- PRIMES
	mov edx, OFFSET promptForN2								; get value of N
	CALL WriteString										; for Primes
	CALL ReadInt
	mov input, eax
	Invoke Primes, input
	CALL CRLF
	CALL CRLF					
	CALL CRLF					

	; --------------------------------------------- SUM
	mov edx, OFFSET promptForN3								; get value of N
	CALL WriteString										; for sum
	CALL ReadInt
	mov input, eax
	Invoke sumReciprocals, input
	CALL CRLF					
Invoke ExitProcess, 0
MAIN ENDP




; ---------------------------------------------------------- Part one
; ---------------------------------------------------------- Finding Primes with 
; ---------------------------------------------------------- Eratosthenes
Sieve PROC uses esi eax ebx ecx edx, N:DWORD
	mov esi, OFFSET eratAr
	mov ecx, N
	mov eax, 0
	mov edx, 0
	mov ebx, 2
	mov edi, 2	
													    ; --- POPULATE ARRAY
	
	push esi											; save array offset
	myLoop:
		mov [esi], edi
		inc edi											; increment counter to list 
		mov eax, [esi]									; elements in ascending order
		CALL WriteInt
		add esi, TYPE DWORD
		cmp ecx, 2
		je next
	LOOP myLoop

	next:												
	pop esi												; exit and reset to default position
	CALL CRLF

	
	mov ecx, 9											; outer loop iterates 9 times
	erath:
		Invoke FindNums, N, erathInc					; run helper procedure with n and divisor
		inc erathInc
		CALL CRLF
	LOOP erath
			
RET
Sieve ENDP



; --------------------------------------------------------------- Helper for Eratothenes
; --------------------------------------------------------------------------------------
FindNums PROC uses esi ecx eax edx, N:DWORD, DIVME:DWORD               
	mov esi, OFFSET eratAr
	mov ecx, N
	sub ecx, 1
	mov ebx, DIVME
	
	inner:	
		mov edx, 0					
		mov eax, [esi]									; catch 2 and make sure he gets to stay prime
		cmp eax, 2					
		je cont
		cmp eax, ebx									; catch when divisor = N and allow to stay prime
		je cont

		div ebx											; divide by bx and if there is no remainder, is prime
		cmp edx, 0		
		je notPrime
		jmp cont

		notPrime:
		  mov edx, 0
		  mov [esi], edx								; if not prime, set [esi] to zero

		cont:
		  mov eax, [esi]								; print [esi] and get next
		  CALL WRITEINT
		  add esi, 4
	LOOP inner
RET
FindNums ENDP





; ---------------------------------------------------------- Part two
; ---------------------------------------------------------- Finding Primes with Integer Division
Primes PROC uses eax ebx ecx, N:DWORD
	mov ebx, 0
	mov ecx, N

	iterate:
		push ecx									; save ecx, if 1 stop
		cmp ecx, 1
		je done

		mov N, ecx									; place ecx in current value
		Invoke isPrime, N							; run helper to find if prime
		pop ecx										; pop ecx
		cmp eax, 1
		je printMe									; find if prime, output number if it is (eax is true/1) 
	LOOP iterate
	
	printMe:
		dec ecx										; print the primes and jump back into loop
		mov eax, N
		CALL WriteInt
		jmp iterate

 done:
 RET
Primes ENDP


;--------------------------------------------------------- IsPrime helper method
isPrime PROC uses ebx ecx edx, N:DWORD
	mov eax, N
	mov ecx, 9										; iterate 9 times
	mov ebx, 0

	cmp eax, 2										; if 2, is prime
	je prime

	find:	
		push eax							
		cmp ecx, eax								; if divisor = num stay prime
		je sameNum
		cmp ecx, 1									; if no divisor, prime
		je prime

		mov edx, 0
		mov ebx, ecx								; divide and check for remainder
		div ebx
		cmp edx, 0
		je notPrime									; if no remainder, not prime
		mov ebx, 0
		pop eax
	LOOP find	

	sameNum:										; same number check again with next divisor
		dec cx
		jmp find

	prime:
	mov eax, 1										; set eax to 1 for prime, 0 for not
	mov ecx, 0
	jmp finishall

	notPrime:
	mov eax, 0
	jmp finishall

  finishall:
  RET 
isPrime ENDP






; -------------------------------------------- Part three
; -------------------------------------------- Summing all reciprocals

sumReciprocals PROC uses eax ebx ecx, N:DWORD
	
	mov ecx, N

	fld loadMe
	iterate:

	push ecx
		cmp ecx, 1
		je done

		mov N, ecx
		Invoke isPrime, N 
		pop ecx
		cmp eax, 1
		je addMe
	LOOP iterate

	addMe:
	dec ecx
	fld oneVal
	fild N
	fdiv
	fadd
	jmp iterate

	done:
	CALL CRLF
	CALL WriteFloat

	RET
sumReciprocals ENDP

END Main
END

