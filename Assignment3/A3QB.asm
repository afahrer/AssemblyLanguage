TITLE Assignment 1 Question B (A1QB.asm)

INCLUDE Irvine32.inc

.data
  prompt BYTE "Please enter a signed integer: ",0
  NUM = 10
  arrayW SWORD NUM DUP(?)
  arrayD SDWORD NUM DUP(?)
.code	
main PROC
  ; get signed values from user
  mov ecx, NUM
  mov edx, OFFSET prompt
  mov esi, TYPE arrayW
  mov ebx, OFFSET arrayW
  l1:
    call WriteString
	call ReadInt
	call CrLf
	mov [ebx], eax
	add ebx, esi
  loop l1
  ; copy arrayW values to arrayD
  mov ecx, NUM
  mov ebx, OFFSET arrayW
  mov edx, OFFSET arrayD
  l2:
	mov eax, [ebx]
	mov [edx], eax
	; increment edx
	add edx, esi
	add edx, esi
	; increment ebx
	add ebx, esi
  loop l2
  ; print DWORD array
  mov ecx, NUM
  mov ebx, OFFSET arrayD
  mov esi, TYPE arrayD
  l3:
    movsx eax, WORD PTR[ebx]
	call WriteInt
	mov al, ' '
	call WriteChar
	add ebx, esi
  loop l3
  exit
main ENDP

END main