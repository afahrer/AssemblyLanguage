TITLE Assignment 1 Question 4 (A1Q4.asm)

INCLUDE Irvine32.inc

.data
  array DWORD 10 DUP(0) 
  prompt BYTE "Please enter a integer: ",0
.code	
main PROC
  mov ecx, LENGTHOF array
  mov esi, TYPE array
  mov edx, OFFSET prompt
  mov ebx, OFFSET array
  l1:
    call WriteString
	call ReadInt
	mov [ebx], eax 
	add ebx, esi
  loop l1

  mov ecx, 5
  mov ebx, OFFSET array
  l2:
    mov edx, [ebx]
    mov [ebx], eax
	add ebx, esi
	mov eax, [ebx]
	mov [ebx], edx
	add ebx, esi
  loop l2

  mov ecx, LENGTHOF array
  mov ebx, OFFSET array
  l3:
    movsx eax, WORD PTR[ebx]
	call WriteInt
	mov al, ' '
	call WriteChar
	add ebx, esi
  loop l3

  exit
main ENDP

END main