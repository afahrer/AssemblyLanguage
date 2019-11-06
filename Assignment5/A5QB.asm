TITLE Assignment 5 Question B (A5QB.asm)
COMMENT !
Description: Gets a number from the user and determines 
             if the number is a power of 2
Name: Adam Fahrer
Date: November 5, 2019
! COMMENT
INCLUDE Irvine32.inc

.data
  msg BYTE "Enter an number that is a power of 2: ",0
  bin BYTE "Binary Value: ",0
  notPow BYTE "Number is not a power of 2",0
  isPow BYTE "Number is a power of 2",0
.code	
main PROC
  mov edx, OFFSET msg				; prompt the user
  call WriteString
  call ReadDec						; get number value
  call CrLf
  call isPowerOfTwo					
  jz isPower						; jump to isPower if the zero flag is set
  mov edx, OFFSET notPow			; print notPow message
  call WriteString
  jmp printBin						; jump to printBin
isPower:
  mov edx, OFFSET isPow				; print isPow message
  call WriteString
printBin:
  call CrLf
  mov edx, OFFSET bin				; print bin message
  call WriteString
  call WriteBin						; print binary value
  exit
main ENDP

; RECEIVES:  eax - number in question
; RETURNS:   ZF = 1 if the number is a power of 2
isPowerOfTwo PROC
  push ecx
  push eax
  mov ecx, 32						; rotate eax 32 times 
l1:
  cmp eax, 1            
  je setZero						; if eax = 1 it is a power of 2
  ror eax, 1						; rotate eax right until eax = 1
  loop l1
  jmp skipZero						; if eax is never equal to 1 then the number is not power of 2
setZero:
  pop eax		
  test ax, 0						; set zero flag
  jmp return						; jump to return
skipZero:
  pop eax
return:
  pop ecx
  ret
isPowerOfTwo ENDP
END main