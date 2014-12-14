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
  A1 REAL8 3.14
  B1 REAL8 1.23
  C1 REAL8 5.55

  fourNum REAL8 4.0
  threeDen REAL8 3.0
  radius REAL8 1.2

.code
MAIN PROC
  CALL Terms
  CALL PiMath
  
Invoke ExitProcess, 0
MAIN ENDP

; --------------------------- Part one
; --------------------------- (A+B)/C + (B+C)/A + (C+A)/B
Terms PROC
  FLD A1
  FLD B1
  FADD
  FLD C1 
  FDIV
								; seccond group 
  FLD B1 
  FLD C1 
  FADD 
  FLD A1
  FDIV
  FADD
								; third group
  FLD C1 
  FLD A1 
  FADD 
  FLD B1
  FDIV
  FADD
  
  CALL WriteFloat
  CALL CRLF
								; third group
 RET
Terms ENDP


; --------------------------- Part two
; --------------------------- 4/3pi * Radius^3
PiMath PROC
  FLD fourNum
  FLD threeDen
  FDIV
  FLDPI
  FMUL
  FLD Radius
  FLD Radius
  FLD Radius
  FMUL
  FMUL
  FMUL
  CALL WriteFloat
  CALL CRLF

RET
PiMath ENDP


END Main

