TITLE Question 1 (Qu1.asm)

INCLUDE Irvine32.inc

.data
  prompt BYTE "Please enter a number: ",0
  s BYTE "Source",0
  t BYTE "Target",0
  source DWORD 0
  target DwORD 0
.code	
main PROC
  mov edx, OFFSET prompt
  call WriteString
  call ReadInt
  mov source,eax
  mov ebx, source
  mov target, ebx
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
  mov edx, offset t
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