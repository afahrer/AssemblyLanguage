TITLE Assignment 5 Question A (A4QA.asm)

INCLUDE Irvine32.inc

.data
  file BYTE 30 DUP(?)
  buffer BYTE 100 DUP(?)
  prompt BYTE "Enter the file name: ",0
  file_handle DWORD ?
  count BYTE 36 DUP(0)
  value BYTE "Count of ",0
.code	
main PROC
  ; print the prompt string and get an integer value from the user
  mov edx, OFFSET prompt
  call WriteString
  ; get the file name from user	
  mov edx, OFFSET file
  mov ecx, LENGTHOF file
  call ReadString
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
  mov ecx, 10
  ; print numbers
  mov bl, '0'
  call print
  mov ecx, 26
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
	  add count[ecx + 9], 1
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
	add count[ecx-1], 1
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
  mov edx, OFFSET value
l3:
  call WriteString
  mov al, 39
  call WriteChar
  mov al, bl
  call WriteChar
  mov al, 39
  call WriteChar
  mov al, ' '
  call WriteChar
  movsx eax, BYTE PTR[esi]
  call WriteDec
  call CrLf
  inc bl
  inc esi
loop l3
ret
print ENDP
END main