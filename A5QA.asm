TITLE Assignment 5 Question A (A5QA.asm)

INCLUDE Irvine32.inc

.data
  file BYTE 30 DUP(?)
  buffer BYTE 100 DUP(?)
  prompt BYTE "Enter the file name: ",0
  file_handle DWORD ?
  count WORD 36 DUP(0)
  value BYTE "Count of ",0
  equals BYTE "' = ",0
.code	
main PROC
  mov edx, OFFSET prompt			; print the prompt string and get an integer value from the user
  call WriteString
  mov edx, OFFSET file
  mov ecx, LENGTHOF file
  call ReadString					; get the file name from user	
  call OpenInputFile
  mov file_handle, eax
read:							
  mov edx, OFFSET buffer			; read 100 chars from file 
  mov ecx, LENGTHOF buffer
  call ReadFromFile
  cmp eax, 0						; if no bytes are left to read then leave the loop
  je done
  mov edx, OFFSET buffer			; Set up registers and call countChars
  mov esi, OFFSET count
  mov ecx, LENGTHOF buffer
  call countChars
  mov eax, file_handle				; put the file handle eax
  jmp read
done:
  mov esi, OFFSET count			
  mov ecx, 10						; Set the registers needed for print procedure
  mov bl, '0'
  call print
  mov ecx, 26						; Set the registers needed for print procedure
  mov bl, 'A'
  call print
exit
main ENDP

; RECEIVES:  esi - OFFSET count
;			 edx - OFFSET buffer
;            ecx - LENGTHOF buffer
; RETURNS:   counted letters in the count array
; Preserves all registers 
countChars PROC USES ecx edx esi eax ebx
  l1:
    push ecx								
	mov al, [edx]					; read char from buffer
	call isLetter					
	jz letter						; jump if it's a letter value
	call isDIgit
	jz number						; else jump to number
	jmp continue
  letter:
	and al, 11011111b				; convert letter to uppercase
	mov ecx, 26						; loop for each letter in the alphabet
	mov bl, 'Z'						; start at Z 
	l2:
	  cmp bl, al					; jump if equal
	  je plusLetter
	  dec bl
	loop l2
  plusLetter:				
	add count[ecx + ecx + 18], 1  ; add 1 to the array value, index = 2 * (ecx + 9) since it's a word array
	jmp continue					; jump to the end
  number:
	mov ecx, 10						; loop 10 times for 10 possible digits
	mov bl, '9'						; start at 9
	l3:
	  cmp bl, al
	  je plusNum					; jump if equal
	  dec bl
	loop l3
  plusNum:
	add count[ecx + ecx - 2], 1		; add 1 to the array value, index = 2 * (ecx - 1) since it's a word array
  continue:
    inc edx							; move to the next char in buffer
	pop ecx							
  loop l1
  ret
countChars ENDP

; RECEIVES:  esi - OFFSET count
;			 bl - starting char value
;            ecx - Number of chars to print
; RETURNS:   counted letters in the count array
; Preserves all registers 
print PROC 
  push ebx
  push ecx
  push eax
l1:
  mov edx, OFFSET value				; print value prompt
  call WriteString
  mov al, 39						; 39 = ascii '
  call WriteChar
  mov al, bl						; get the current char value and print
  call WriteChar
  mov edx, OFFSET equals			; print ' = 
  call WriteString
  movsx eax, WORD PTR[esi]			; Get the count value and print
  call WriteDec
  call CrLf
  inc bl							; Move to the next char value
  add esi, 2						; add 2 to esi to increment since count is WORD array
loop l1	
  pop ebx
  pop ecx
  pop eax
  ret
print ENDP

; RECEIVES:  al - char value
; RETURNS:   zero flag = 1 if char is a letter
; Any value that al is between 'A'-'Z' or 'a'-'z' is considered a letter
isLetter PROC
  cmp al, 'z'	
  ja return
  cmp al, 'A'
  jb return
  cmp al, 'Z'
  ja check_a
  jmp setZero
check_a:
  cmp al, 'a'
  jb return
setZero:
  test ax, 0
return: 
  ret
isLetter ENDP

END main