TITLE Assignment 4 Question B (A4QB.asm)
COMMENT !
Description: Gets a lower bound and upper bound from user
             then generates a random number from between lower and upper
			 this repeats 5 times
Name: Adam Fahrer
Date: October 23, 2019
! COMMENT
INCLUDE Irvine32.inc

.data
  upperPrompt BYTE "Upper Value: ",0
  lowerPrompt BYTE "Lower Value: ",0
  randomPrompt BYTE "Random Value: ",0
  upper DWORD ?
.code	
main PROC
  call Randomize
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
	; get a random number and print it
	mov edx, OFFSET randomPrompt
	call WriteString
	call BetterRandomRange
	call WriteInt
	call CrLf
	call CrLf
	; reset eax so that a new number can be generated
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

