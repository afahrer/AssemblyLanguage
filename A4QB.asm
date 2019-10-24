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
    ; get the lower value from user
	mov edx, OFFSET lowerPrompt
	call WriteString
	call ReadInt
	mov ebx, eax
	; get the upper value from user
	mov edx, OFFSET upperPrompt
	call WriteString
	call ReadInt
	; store the upper value
	mov upper, eax
	; Store value of ecx and set ecx to 50
	push ecx
	mov ecx, 50
    l2:
	  ; get a random number and print it
      call BetterRandomRange
	  call WriteInt
	  call CrLf
	  ; reset eax so that a new number can be generated
	  mov eax, upper
    loop l2
	; restore original ecx value
	pop ecx
  loop l1
  exit
main ENDP

BetterRandomRange PROC
  ; subtract lower from upper and add 1 making randomRange inclusive 
  sub eax, ebx
  add eax, 1
  call RandomRange
  ; add lower back in so that the random number cannot be too low
  add eax, ebx
  ret
BetterRandomRange ENDP

END main

