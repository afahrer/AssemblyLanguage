TITLE Assignment 1 Question A (A1QA.asm)

INCLUDE Irvine32.inc

.data
  ;variables for strings to be printed
  prompt BYTE "Please enter a number: ",0
  s BYTE "Source",0
  t BYTE "Target",0
  ;variables for source and target
  source DWORD ?
  target DwORD ?
.code	
main PROC
  ; print the prompt string and get an integer value from the user
  mov edx, OFFSET prompt
  call WriteString
  call ReadInt
  call CrLf
  ; set the value of source then use ebx to copy it to target
  mov source,eax
  mov ebx, source
  mov target, ebx
  ; print source value
  mov eax, source
  mov edx, offset s
  call WriteString
  call CrLf
  call WriteBin
  call CrLf
  call WriteHex
  call CrLf
  call WriteInt
  call CrLf
  call CrLf
  ; print target value
  mov edx, offset t
  mov eax, target
  call WriteString
  call CrLf
  call WriteBin
  call CrLf
  call WriteHex
  call CrLf
  call WriteInt
  exit
main ENDP

END main