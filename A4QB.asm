TITLE Assignment 4 Question B (A4QB.asm)

INCLUDE Irvine32.inc

.data
  upperPrompt BYTE "Upper Value ",0
  lowerPrompt BYTE "Lower Value ",0
  upper DWORD ?
.code	
main PROC
  mov ecx, 5
  l1:
    mov edx, OFFSET lowerPrompt
	call WriteString
	call ReadInt
	mov ebx, eax
	mov edx, OFFSET upperPrompt
	call WriteString
	call ReadInt
	mov upper, eax
	push ecx
	mov ecx, 50
    l2:
      call BetterRandomRange
	  call WriteInt
	  call CrLf
	  mov eax, upper
    loop l2
	pop ecx
  loop l1
  exit
main ENDP

BetterRandomRange PROC
  sub eax, ebx
  add eax, 1
  call RandomRange
  add eax, ebx
  ret
BetterRandomRange ENDP

END main

