TITLE Assignment 4 Question A (A4QA.asm)

INCLUDE Irvine32.inc

.data
  ; variables for strings to be printed
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
  ; get the file name from user
  mov edx, OFFSET buffer
  mov ecx, SIZEOF buffer
  call ReadString
  call OpenInputFile
  ; store the file handle
  mov fileHandle, eax 
  ; capture the first 26 bytes of the file and store in the letters array
  mov edx, OFFSET letters
  mov ecx, SIZEOF letters
  call ReadFromFile
  ; capture the next 27 bytes of the file and store in the index array
  mov eax, fileHandle
  mov edx, OFFSET index
  mov ecx, SIZEOF index
  call ReadFromFile
  ; close the file
  mov eax, fileHandle
  call CloseFile
  ; print the secret message prompt
  mov edx, OFFSET secretPrompt
  call WriteString
  ; set up registers for the loop
  mov ebx, OFFSET letters
  mov ecx, LENGTHOF letters
  mov edx, OFFSET index
  ; start at the end of the array
  add edx, LENGTHOF letters
  l1:
    ; get the next index value
	mov esi, [edx]
	; reset edx then add esi to get to the correct index
	mov edx, OFFSET index
	add edx, esi
	; add ebx to esi, ebx contains the memory address of array index 0
	add esi, ebx
	; get the letter value and print to the console
	mov eax, [esi]
	call WriteChar
  loop l1
  call CrLf 
  exit
main ENDP

END main