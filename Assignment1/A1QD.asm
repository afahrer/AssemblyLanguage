TITLE Assignment 1 Question D (A1QD.asm)

INCLUDE Irvine32.inc

.data
  array DWORD 10 DUP(?) 
  prompt BYTE "Please enter a integer: ",0
  commaSpace BYTE ", ",0
.code	
main PROC
  mov ecx, LENGTHOF array
  mov esi, TYPE array
  mov edx, OFFSET prompt
  mov ebx, OFFSET array
  ; collect the values and store them in the array
  l1:
    call WriteString
	call ReadDec
	mov [ebx], eax 
	add ebx, esi
  loop l1
  ; loop half the size of the array
  mov ecx, 5
  ; reset ebx to begining of array
  mov ebx, OFFSET array
  ; shift the elements in array, last value is already in eax from ReadDec
  l2:
    ; store the value to be shifted
    mov edx, [ebx]
    mov [ebx], eax
	add ebx, esi
	mov eax, [ebx]
	mov [ebx], edx
	add ebx, esi
  loop l2
  ; print the values
  mov ecx, LENGTHOF array
  dec ecx
  mov ebx, OFFSET array
  mov edx, OFFSET commaSpace
  mov al, '['
  call WriteChar
  l3:
	movsx eax, WORD PTR[ebx]
	call WriteDec
	call WriteString
	add ebx, esi
  loop l3
  ; print the last value with no comma
  movsx eax, WORD PTR[ebx]
  call WriteDec
  mov al, ']'
  call WriteChar
  exit
main ENDP

END main