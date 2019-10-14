TITLE Assignment 1 Question 2 (A1Q2.asm)

INCLUDE Irvine32.inc

.data
  prompt BYTE "Please enter a signed integer: ",0
  NUM = 3
  arrayW SWORD NUM DUP(0)
  arrayD SDWORD NUM DUP(0)
.code	
main PROC
  ; get signed values from user
  mov ecx, NUM
  mov edx, OFFSET prompt
  mov esi, TYPE arrayW
  mov ebx, OFFSET arrayW
  l1:
    call WriteString
	call ReadInt
	call CrLf
	mov [ebx], eax
	add ebx, esi
  loop l1
  mov ecx, NUM
  mov edx, OFFSET arrayD
  l2:
    mov eax, [ebx] 
    mov [edx], eax
	add edx, esi
	add edx, esi
	add ebx, esi
  loop l2
  ; print loop
  mov ecx, NUM
  mov ebx, OFFSET arrayW
  l3:
    movsx eax, DWORD PTR[edx]
	call WriteInt
	call CrLf
	add edx, esi
	add edx, esi
  loop l3
  exit
main ENDP

END main