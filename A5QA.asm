TITLE Assignment 5 Question A (A4QA.asm)

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
  push ecx
l1:							
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
  pop ecx
loop l1
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

; esi, offset count -- edx, offset buffer
countChars PROC USES ecx
  l1:
    push ecx
	mov al, [edx]
	call isLetter
	jz letter 
	jmp number
  letter:
	and al, 11011111b
	mov ecx, 26
	mov bl, 'Z'
	l2:
	  cmp bl, al
	  je plus
	  dec bl
	loop l2
	jmp continue
	plus:
	  add count[ecx + ecx + 18], 1
	jmp continue
  number:
	mov ecx, 10
	mov bl, '9'
	l3:
	  cmp bl, al
	  je plusNum
	  dec bl
	loop l3
	jmp continue
  plusNum:
	add count[ecx + ecx - 2], 1
  continue:
    inc edx
	pop ecx
  loop l1
  ret
countChars ENDP

; does not account for values between upper and lower case
isLetter PROC
  cmp al, 'z'
  ja ID1
  cmp al, 'A'
  jb ID1
  test ax, 0
  ID1: ret
isLetter ENDP

print PROC ; ecx, loop count -- bl, starting char value
l1:
  mov edx, OFFSET value			; print value prompt
  call WriteString
  mov al, 39					; 39 = ascii '
  call WriteChar
  mov al, bl					; get the current char value and print
  call WriteChar
  mov edx, OFFSET equals		; print ' = 
  call WriteString
  movsx eax, WORD PTR[esi]		; Get the count value and print
  call WriteDec
  call CrLf
  inc bl						; Move to the next char value
  add esi, 2					; add 2 to esi to increment since count is WORD array
loop l1
ret
print ENDP
END main