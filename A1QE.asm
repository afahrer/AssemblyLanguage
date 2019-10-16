TITLE Assignment 1 Question 5 (A1Q5.asm)

INCLUDE Irvine32.inc

; psuedocode in python because i don't have a java ide installed 
; and my internet is really slow rn :)
COMMENT !
f = 1
f1 = 3
f2 = 2
f3 = 5
f4 = f3 + 2 * f
for i in range(30):
    print(f)
    f = f1
    f1 = f2
    f2 = f3
    f3 = f4
    f4 = f3 + 2 * f
! COMMENT
.data
  commaSpace BYTE ", ",0
  f DWORD 1
  f1 DWORD 3
  f2 DWORD 2
  f3 DWORD 5
  f4 DWORD 0
.code	
main PROC
  mov edx, OFFSET commaSpace
  ; calculate inital f4 value using eax
  mov eax, f3
  add eax, f
  add eax, f
  mov f4, eax
  ; print the first 29 values of f and store other values accordingly
  mov ecx, 29
  l1:
	mov eax, f
	call WriteDec
    call WriteString
	; f = f1
	mov eax, f1
	mov f, eax
    ; f1 = f2
	mov eax, f2
	mov f1, eax
	; f2 = f3
	mov eax, f3
	mov f2, eax
	; f3 = f4
	mov eax, f4
	mov f3, eax
	; f4 = f3 + 2 * f
	mov eax, f3
    add eax, f
    add eax, f
    mov f4, eax
  loop l1
  ; print value 30 with no commma
  mov eax, f
  call WriteDec
  call CrLf
  exit
main ENDP

END main