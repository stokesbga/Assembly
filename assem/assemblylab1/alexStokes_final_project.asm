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

; procedure prototypes:
SetColor PROTO forecolor:BYTE, backcolor: BYTE
WriteColorChar PROTO char:BYTE, forecolor:BYTE, backcolor:BYTE
PrintRowOdd PROTO color:BYTE
PrintRowEven PROTO color:BYTE

.data
rows = 8
columns = 8
horizCharsPerSquare = 2

.code
main PROC
    mov ecx, rows / horizCharsPerSquare
L1:
    INVOKE PrintRowOdd, gray
    call Crlf
    INVOKE PrintRowEven, gray
    call Crlf
    loop L1

    INVOKE SetColor, lightGray, black ; return to normal color
    call Crlf

    exit
main ENDP

PrintRowOdd PROC uses ecx, color:BYTE
    mov ecx, columns / horizCharsPerSquare
L1:
    INVOKE WriteColorChar, ' ', color, color
    INVOKE WriteColorChar, ' ', color, color
    INVOKE WriteColorChar, ' ', white, white
    INVOKE WriteColorChar, ' ', white, white
    loop L1

    ret
PrintRowOdd ENDP

PrintRowEven PROC uses ecx, color:BYTE
    mov ecx, columns / horizCharsPerSquare
L1:
    INVOKE WriteColorChar, ' ', white, white
    INVOKE WriteColorChar, ' ', white, white
    INVOKE WriteColorChar, ' ', color, color
    INVOKE WriteColorChar, ' ', color, color
    loop L1

    ret
PrintRowEven ENDP

WriteColorChar PROC USES eax, char:BYTE, forecolor:BYTE, backcolor:BYTE 
    INVOKE SetColor, forecolor, backcolor
    mov al, char
    call WriteChar

    ret
WriteColorChar ENDP

SetColor PROC, forecolor:BYTE, backcolor:BYTE
    movzx eax, backcolor
    shl eax, 4
    or al, forecolor
    call SetTextColor       ; from Irvine32.lib
    ret
SetColor ENDP
END MAIN


