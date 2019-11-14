TITLE Assignment 6 Question A (A6QA.asm)
COMMENT !
Description: Creates an array of random numbers that can be
			 multiplied, divided or printed
Name: Adam Fahrer
Date: November 13, 2019
! COMMENT
INCLUDE Irvine32.inc

.data
  newLine = 0ah											; constant for newLine acts like \n
  menu BYTE "1 - Populate the array with random numbers", newLine,
  "2 - Mulitply the array with a user provided multiplier", newLine,
  "3 - Divide the array with a user provided divisor", newLine,
  "4 - Print the array", newLine,
  "0 - Exit",newLine, 0
  popSuccess BYTE "Populated the array with random numbers between -1500 and +2500",0
  getMult BYTE "Enter the multiplier value: ",0
  getDiv BYTE "Enter the divisor value: ",0
  commaSpace BYTE ", ",0
  array SWORD 10 DUP(-100)								; SWORD array starting value -100
.code	

print PROTO,											; prototype for print procedure 
  len:DWORD,
  ref:DWORD

main PROC
  call Randomize										; generate new seed
start:
  mov edx, OFFSET menu									; print the menu text
  call WriteString										
  call ReadDec											; get the option from user
  call CrLf
  cmp eax, 0											; if eax = 0 quit
  je quit

one: 
  cmp eax, 1											; eax != 1, jump to 2
  jne two 
  push LENGTHOF array									; push lengthof array and offset array then call populate
  push OFFSET array
  call populate
  jmp start

two:
  cmp eax, 2											; eax != 2, jump to 3
  jne three
  mov edx, OFFSET getMult								; get multiplier from user
  call WriteString
  call ReadInt
  push OFFSET array										; push array offset and multiplier to the stack then call multiply
  push eax
  call multiply
  jmp start

three:
  cmp eax, 3											; eax != 3, jump to 4
  jne four
  mov edx, OFFSET getDiv								; get divisor from user
  call WriteString
  call ReadInt
  push OFFSET array										; push array offset and divisor to the stack then call divide
  push eax
  call divide
  jmp start
 
four:
  invoke print, LENGTHOF array, OFFSET array			; invoke print method
  jmp start			
  
quit:
  exit
main ENDP

populate PROC

  ENTER 4,0												; create local variable type DWORD
  pushad

  mov ecx, [EBP + 12]									; get lengthof array from stack
  mov eax, -1500										; -1500 is the lower range
  xchg eax, [EBP-4]										; store the lower range in the local variable
  mov ebx, [EBP+8]

l1:
  mov eax, 4001											; get random num from 0-4000 
  call RandomRange
  add eax, [EBP - 4]									; add -1500 to put number in range -1500 - +2500
  mov [ebx], eax
  add ebx, TYPE WORD
  loop l1

  mov edx, OFFSET popSuccess							; display a message when complete
  call WriteString
  call CrLf
  call CrLf

  popad
  LEAVE
  ret
populate ENDP

multiply PROC, multiple:WORD, ref:DWORD
  pushad
  mov ecx, LENGTHOF array		
  mov ebx, ref

l1:
  mov ax, multiple										; ax is multiple
  mov dx, [ebx]											; dx is the value from array
  imul dx												; multiply dx with ax
  mov [ebx], ax											; store the result in the array
  add ebx, TYPE WORD
  loop l1

  popad
  ret
multiply ENDP

divide PROC, divisor:WORD, ref:DWORD
  pushad
  mov ecx, LENGTHOF array
  mov esi, ref

l1:
  mov bx, divisor										; bx is divisor
  mov ax, [esi]											; ax is value from array
  cwd													; convert to dword before dividing
  idiv bx													
  mov [esi], ax											; store the result in the array
  add esi, TYPE WORD
  loop l1

  popad
  ret
divide ENDP

print PROC, len:DWORD, ref:DWORD
  pushad
  mov al, '['											; print '['
  call WriteChar
  mov ecx, len											; move array length to ecx
  dec ecx																
  mov edx, OFFSET commaSpace
  mov ebx, ref											; ebx = OFFSET array

l1:
  movsx eax, WORD PTR [ebx]								; print array value
  call WriteInt
  call WriteString										; print commaSpace
  add ebx, TYPE WORD
  loop l1

  movsx eax, WORD PTR [ebx]								; print last value with no commaSpace
  call WriteInt
  mov al, ']'											
  call WriteChar										; print '['
  call CrLf
  call CrLf

  popad
  ret
print ENDP

END main