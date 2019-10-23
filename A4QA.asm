TITLE Assignment 4 Question A (A4QA.asm)

INCLUDE Irvine32.inc

.data
  ;variables for strings to be printed
  prompt BYTE "Enter the file name: ",0
  secretPrompt BYTE "Secret Message: ",0
  ; buffer accepts a string up to 30 characters in length
  buffer BYTE 30 DUP(?)
  letters BYTE 26 DUP(?)
  index BYTE 27 DUP(?)
  fileHandle HANDLE ?
.code	
main PROC
  ; print the prompt string and get an integer value from the user
  mov edx, OFFSET prompt
  call WriteString
  
  mov edx, OFFSET buffer
  mov ecx, SIZEOF buffer
  call ReadString
  call OpenInputFile
  mov fileHandle, eax

  mov edx, OFFSET letters
  mov ecx, SIZEOF letters
  call ReadFromFile

  mov edx, OFFSET index
  mov ecx, SIZEOF index
  call ReadFromFile
  
  mov eax, fileHandle
  call CloseFile

  mov ecx, LENGTHOF letters

  mov ebx, OFFSET letters
  mov esi, TYPE letters
  mov al, '['
  call WriteChar
  l3:
	movsx eax, WORD PTR[ebx]
	call WriteChar
	add ebx, esi
  loop l3
  mov al, ']'
  call WriteChar

  mov ecx, LENGTHOF index
  mov ebx, OFFSET index
  mov esi, TYPE index
  mov al, '['
  call WriteChar
  l2:
	mov eax, [ebx]
	call Writeint
	add ebx, esi
  loop l2

  mov al, ']'
  call WriteChar
  
  exit
main ENDP

END main