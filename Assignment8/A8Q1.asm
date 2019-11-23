TITLE Assignment 8 Question 1 (A8Q1.asm)
COMMENT !
Description: Program to make substrings
Name: Adam Fahrer
Date: November 13, 2019
! COMMENT
INCLUDE Irvine32.inc

.data

enterString BYTE "Enter a String Value: ", 0
startIndex BYTE "Start Index: ", 0
endIndex BYTE "End Index: ", 0
substring BYTE "Substring: ", 0
maxStringLength = 30
stringVal BYTE maxStringLength DUP(?)
target BYTE maxStringLength DUP(?)
startVal BYTE ?
endVal BYTE ?

.code	

Str_subString PROTO, 
  string:DWORD,
  tar:DWORD,
  start:BYTE,
  endI:BYTE,
  sLength:BYTE
  
main PROC

  mov edx, OFFSET enterString
  call WriteString
  mov edx, OFFSET stringVal
  mov ecx, LENGTHOF stringVal
  call ReadString

  mov edx, OFFSET startIndex
  call WriteString
  call ReadDec
  mov startVal, al

  mov edx, OFFSET endIndex
  call WriteString
  call ReadDec
  mov endVal, al

  invoke Str_subString, OFFSET stringVal, OFFSET target, startVal, endVal, LENGTHOF stringVal

  mov edx, OFFSET substring
  call WriteString

  mov al, '"'
  call WriteChar

  mov edx, OFFSET target
  call WriteString

  mov al, '"'
  call WriteChar
  exit
main ENDP

Str_subString PROC, 
  string:DWORD,
  tar:DWORD,
  start:BYTE,
  endI:BYTE,
  sLength:BYTE

  pushad

  mov edx, string
  mov ebx, tar

  mov al, start
  add dl, al
  mov al, sLength
  cmp endI, al
  jb movEnd

  mov cl, sLength
  jmp subStart
  
  movEnd:
    mov cl, endI
  
  subStart:
	sub cl, start
  l1:
    mov al, [edx]
	mov [ebx], al
	add edx, TYPE BYTE
	add ebx, TYPE BYTE
  loop l1

  popad
  ret
Str_subString ENDP


END main