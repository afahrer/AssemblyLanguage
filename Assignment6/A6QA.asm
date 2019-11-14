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
  "2 - Mulitply the array with a user provided multiplier", newLine,
  "3 - Divide the array with a user provided divisor", newLine,
  "4 - Print the array", newLine,
  "0 - Exit",newLine, 0
  popSuccess BYTE "Populated the array with random numbers between -1500 and +2500",0
  getMult BYTE "Enter the multiplier value: ",0
  getDiv BYTE "Enter the divisor value: ",0
  commaSpace BYTE ", ",0
  array SWORD 10 DUP(-100)
.code	

print PROTO,
  len:DWORD,
  ref:DWORD

main PROC
  call Randomize
start:
  mov edx, OFFSET menu
  call WriteString
  call ReadDec
  call CrLf
  cmp eax, 0
  je quit

one: 
  cmp eax, 1
  jne two 
  push LENGTHOF array
  push OFFSET array
  call populate
  jmp start

two:
  cmp eax, 2
  jne three
  mov edx, OFFSET getMult
  call WriteString
  call ReadInt
  push OFFSET array
  push eax
  call multiply
  jmp start

three:
  cmp eax, 3
  jne four
  mov edx, OFFSET getDiv
  call WriteString
  call ReadInt
  push OFFSET array
  push eax
  call divide
  jmp start
 
four:
  invoke print, LENGTHOF array, OFFSET array
  jmp start
quit:
  exit
main ENDP

populate PROC

  ENTER 4,0				; create local variable type DWORD
  pushad

  mov ecx, [EBP + 12]	; get lengthof array from stack
  mov eax, -1500		; -1500 is the lower range
  xchg eax, [EBP-4]		; store the lower range in the local variable
  mov ebx, [EBP+8]

l1:
  mov eax, 4001			; get random num from 0-4000 
  call RandomRange
  add eax, [EBP - 4]	; add -1500 to put number in range -1500 - +2500
  mov [ebx], eax
  add ebx, TYPE WORD
  loop l1

  mov edx, OFFSET popSuccess
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
  mov ax, multiple
  mov dx, [ebx]
  imul dx						; multiply dx with ax
  mov [ebx], ax					; get the word value
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
  mov bx, divisor
  mov ax, [esi]
  cwd
  idiv bx
  mov [esi], ax
  add esi, TYPE WORD
  loop l1
  popad
  ret
divide ENDP

print PROC, len:DWORD, ref:DWORD
  pushad
  mov al, '['
  call WriteChar
  mov ecx, len
  dec ecx
  mov edx, OFFSET commaSpace
  mov ebx, ref
l1:
  movsx eax, WORD PTR [ebx]
  call WriteInt
  call WriteString
  add ebx, TYPE WORD
  loop l1
  movsx eax, WORD PTR [ebx]
  call WriteInt
  mov al, ']'
  call WriteChar
  call CrLf
  call CrLf
  popad
  ret
print ENDP

END main