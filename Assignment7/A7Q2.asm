TITLE Assignment 7 Question 2 (A7Q2.asm)
COMMENT !
Description: Prints a floating point number in binary
Name: Adam Fahrer
Date: November 24, 2019
! COMMENT
INCLUDE Irvine32.inc

.data

userFloat DWORD	?
msg1 BYTE "Please enter a float to convert: ", 0
msg2 BYTE "Float in Binary: ", 0
msg3 BYTE " X 2^", 0

.code
main PROC

	FINIT									

	mov edx, OFFSET msg1
	Call WriteString
	Call ReadFloat							; Get float value from user

	FSTP userFloat							; store the value into a variable
	Call CrLf
	
	mov edx, OFFSET msg2					; print "float in binary" message
	Call WriteString					

	mov ebx, userFloat					

	SHL ebx, 1								; move the sign bit into carry flag									
	JC negative
	mov al, '+'								; if the number is positive print '+'	
	Call WriteChar							

	jmp continue

negative:
	mov al, '-'								; if the number is negative print '-'
	Call WriteChar							
continue:
	mov al, ' '								; print "1."
	Call WriteChar
	mov al, '1'
	Call WriteChar
	mov al, '.'
	Call WriteChar							

	mov eax, userFloat

	SHR eax, 23								; shift the biased exponent into al

	SUB al, 127								; subtract 127 to get the exponent value
	mov ebx, 0
	mov bl, al								; store in bl

	mov eax, userFloat													
	SHL eax, 9								; shift left to remove the sign bit and biased exponent bits						
	mov ecx, 23								
	
l1:											; move the remaining 23 bits into the carry flag one at a time
	SHL eax, 1												
	JC one									; print a 1 if the carry flag is set otherwise print 0
	mov al, '0'								
	jmp skipOne
one:
	mov al, '1'			
skipOne:
	call WriteChar
	loop l1						

	mov edx, OFFSET msg3					; print the exponent stored in ebx
	Call WriteString
	mov eax, ebx
	Call WriteInt							
	call ShowFPUStack

	exit
main ENDP

END main