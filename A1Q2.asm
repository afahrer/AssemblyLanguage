TITLE Assignment 1 Question 2 (A1Q2.asm)

INCLUDE Irvine32.inc

.data
  prompt BYTE "Please enter a signed integer: ",0
  NUM = 3
  arrayW WORD NUM DUP(0)
  arrayD DWORD NUM DUP(0)
.code	
main PROC
  ; get signed values from user
  mov ecx, NUM
  mov edx, OFFSET prompt
  mov si, TYPE arrayW
  mov ebx, OFFSET arrayW
  l1:
    call WriteString
	call ReadInt
	call CrLf
	mov bx, ax
	add bx, si
  loop l1
  ; print loop
  mov ecx, NUM
  mov ebx, OFFSET arrayW
  l3:
    mov ax, bx
	call WriteBin
	call CrLf
	add bx, si
  loop l3
  exit
main ENDP

END main