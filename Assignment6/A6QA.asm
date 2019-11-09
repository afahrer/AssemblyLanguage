TITLE Assignment 6 Question A (A6QA.asm)
COMMENT !
Description: Gets a number from the user and determines 
             if the number is a power of 2
Name: Adam Fahrer
Date: November 5, 2019
! COMMENT
INCLUDE Irvine32.inc

.data
  newLine = 0ah ; constant for acts like \n
  menu BYTE "1 - Populate the array with random numbers", newLine,
  "2 - Mulitply the array with a provided multiplier", newLine,
  "3 - Divide the array with a user provided divisor", newLine,
  "4 - Print the array", newLine,
  "0 - Exit",newLine, 0
  
.code	
main PROC

start:
  mov edx, OFFSET menu
  call WriteString
  call ReadDec
  cmp eax, 0
  je quit
  
  cmp eax, 1
  jne two 
  call populate
  jmp start

two:
  cmp eax, 2
  jne three
  call multiply
  jmp start

three:
  cmp eax, 3
  jne four
  call divide
  jmp start
 
four:
  call print
  jmp start
quit:
  exit
main ENDP

populate PROC
ret
populate ENDP

multiply PROC
ret
multiply ENDP

divide PROC
ret
divide ENDP

print PROC
ret
print ENDP

END main