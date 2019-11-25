TITLE Assignment 7 Question 2 (A7Q2.asm)
COMMENT !
Description: Prints a floating point number in binary
Name: Adam Fahrer
Date: November 24, 2019
! COMMENT
INCLUDE Irvine32.inc

.data

userFloat DWORD	?
msg1 BYTE "Please enter a float: ", 0
msg2 BYTE "Float in Binary: ", 0
msg3 BYTE " 1.",0
msg4 BYTE " X 2^", 0

.code
main PROC
  finit								

  mov edx, OFFSET msg1
  call WriteString
  call ReadFloat							; Get float value from user  
  fstp userFloat							; store the value into a variable
  call CrLf	

  mov edx, OFFSET msg2						; print "float in binary" message
  call WriteString					
  mov ebx, userFloat					 
  shl ebx, 1								; move the sign bit into carry flag									
  jc negative

  mov al, '+'								; if the number is positive print '+'	
  call WriteChar							
  jmp continue
negative:
  mov al, '-'								; if the number is negative print '-'
  call WriteChar							
continue:
  mov edx, OFFSET msg3
  call WriteString
  
  mov eax, userFloat
  shr eax, 23								; shift the biased exponent into al
  sub al, 127								; subtract 127 to get the exponent value
  mov ebx, 0
  mov bl, al								; store in bl
  
  mov eax, userFloat													
  shl eax, 9								; shift left to remove the sign bit and biased exponent bits						
  mov ecx, 23								
  
l1:											; move the remaining 23 bits into the carry flag one at a time
  shl eax, 1												
  jc one									; print a 1 if the carry flag is set otherwise print 0
  mov al, '0'								
  jmp skipOne
one:
  mov al, '1'			
skipOne:
  call WriteChar
  loop l1						
  
  mov edx, OFFSET msg4						; print the exponent stored in ebx
  call WriteString
  mov eax, ebx
  call WriteInt							
  call ShowFPUStack

  exit
main ENDP

END main