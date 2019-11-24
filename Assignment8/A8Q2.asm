TITLE Assignment 8 Question 2 (A8Q2.asm)
COMMENT !
Description: Program to make substrings
Name: Adam Fahrer
Date: November 13, 2019
! COMMENT
INCLUDE Irvine32.inc

.data
  numRows = 4
  numCols = 5

  array SWORD numRows * numCols DUP(1)
  msg1 BYTE "Column to sum: ", 0
  msg2 BYTE "Sum of column: ", 0
.code	

SumColumnArray PROTO,
arr:DWORD,
rows:DWORD,
cols:DWORD,
added:DWORD

main PROC
  call Randomize
  mov edx, OFFSET array
  
  push OFFSET array
  push numRows
  push numCols
  call print2DArray
  call PopulateArray

  push OFFSET array
  push numRows
  push numCols
  call print2DArray

  mov edx, OFFSET msg1
  call WriteString
  call ReadInt
  invoke SumColumnArray, OFFSET array, numRows, numCols, eax
  mov edx, OFFSET msg2
  call WriteString
  call WriteInt
  exit
main ENDP

PopulateArray PROC
	PUSHAD

	mov esi, 0			
	mov ecx, numRows
L1:
	push ecx
	mov edi, 0
	mov ecx, numCols
L2:
	mov eax, 100
	mov ebx, -100
	call BetterRandomRange
	mov array[esi+edi], ax

	add edi, TYPE WORD
	loop L2
	add esi, edi
	pop ecx
	loop L1

	POPAD
  ret
PopulateArray ENDP

print2DArray PROC
	
	ENTER 0,0
	PUSHAD
	mov esi, [EBP+16]				; offset		
	mov ecx, [EBP+12]				; numRows
L1:
	PUSH ecx
	mov edi, 0
	mov al, '|'
	Call WriteChar	
	mov al, 09h
	Call WriteChar					

	mov ecx, [EBP+8]				; numCols
L2:									
	movsx eax, WORD PTR [esi+edi]
	Call WriteInt					
	mov al, ','
	Call WriteChar
	mov al, 09h
	Call WriteChar
	add edi, TYPE WORD
	loop L2							
	mov al, '|'
	Call WriteChar					
	Call CrLf
	add esi, edi					
	POP ecx							
	loop L1
	Call CrLf
	
	POPAD
	LEAVE
	ret
print2DArray ENDP

SumColumnArray PROC,
arr:DWORD,
rows:DWORD,
cols:DWORD,
added:DWORD
  LOCAL rowLength:DWORD
  mov eax, cols
  mov rowLength, eax
  add rowLength, eax
  mov esi, arr
  mov eax, 0
  mov edi, added
  add edi, added
  mov ecx, rows
l1: 
  movsx ebx, WORD PTR[esi+edi]
  add eax, ebx
  add esi, rowLength
  loop l1

  ret
SumColumnArray ENDP

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