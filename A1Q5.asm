TITLE Assignment 1 Question 5 (A1Q5.asm)

INCLUDE Irvine32.inc

COMMENT !
f = 1
f1 = 3
f2 = 2
f3 = 5
f4 = f3 + 2 * f
for i in range(30):
    print(f)
    f = f1
    f1 = f2
    f2 = f3
    f3 = f4
    f4 = f3 + 2 * f
! COMMENT

.data
  f DWORD 1
  f1 DWORD 3
  f2 DWORD 2
  f3 DWORD 5
  f4 DWORD 0

.code	
main PROC
  mov eax, f3
  add eax, f
  add eax, f
  mov f4, eax
  mov ecx, 30
  l1:
	mov eax, f
	call WriteInt
	call CrLf

	mov eax, f1
	mov f, eax

	mov eax, f2
	mov f1, eax

	mov eax, f3
	mov f2, eax

	mov eax, f4
	mov f3, eax

	mov eax, f3
    add eax, f
    add eax, f
    mov f4, eax

  loop l1
  exit
main ENDP

END main